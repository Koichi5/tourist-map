//
//  AppState+ModelLoading.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/03/25.
//

import Foundation
import RealityKit
import RealityKitContent

actor EntityContainer {
    var entity: Entity?
    func setEntity(_ newEntity: Entity?) {
        entity = newEntity
    }
}

struct LoadResult: Sendable {
    var entity: Entity
    var key: String
}

extension AppState {
    private func loadFromRCPro(named entityName: String, fromSceneNamed sceneName: String, scaleFactor: Float? = nil) async throws -> Entity? {
        var ret: Entity? = nil
        logger.info("Loading entity \(entityName) from Reality Composer Pro scene \(sceneName)")
        do {
            let scene = try await Entity(named: sceneName, in: realityKitContentBundle)
            let entityContainer = EntityContainer()
            let theRet = scene.findEntity(named: entityName)
            if let scaleFactor = scaleFactor {
                theRet?.scale = SIMD3<Float>(repeating: scaleFactor)
            }
            await entityContainer.setEntity(theRet)
            ret = await entityContainer.entity
        } catch {
            fatalError("\tEncountered fatal error: \(error.localizedDescription)")
        }
        return ret
    }
    
    public func loadModels() async {
        defer {
            finishedLoadingAssets()
        }
        _ = Date.timeIntervalSinceReferenceDate
        logger.info("Starting load from Reality Composer Pro Project.")
        finishedStartingUp()
        await withTaskGroup(of: LoadResult.self) { taskGroup in
            loadMapPinModels(taskGroup: &taskGroup)
            loadMapModel(taskGroup: &taskGroup)
            for await result in taskGroup {
                if pins.first(where: { $0.key.rawValue == result.key }) != nil {
                    processLoadedPinModels(result: result)
                } else if result.key == "map" {
                    addMapEntity(entity: result.entity)
                } else {}
            }
        }
    }
    
    private func processLoadedPinModels(result: LoadResult) {
        self.add(template: result.entity)
    }
    
//    @discardableResult
//    public func addPinEntitiesToScene(for key: PinKey) async -> [Entity] {
//        do {
//            print("add pin entities to scene fired")
//            for pin in pinTemplates {
//                root.addChild(pin)
//            }
//        }
//        return pinTemplates
//    }
    
    @discardableResult
    public func addMapEntity(entity: Entity) -> Entity {
        print("add map entity to scene fired")
        // AppState が保持している mapModel に引数で受け取った Entity を追加することができる。AppState.mapModel で他のページからアクセスすることができ、root.addChild(appState.mapModel) でルートに追加することができる。SwiftSplash も同じ仕様
        
        mapModel = entity
        return entity
    }
    
    public func addMapEntityToScene() {
        if mapModel != nil {
            fatalError("map model is not loaded")
        } else {
            root.addChild(mapModel!)
        }
    }
    
    // 位置を設定する関数をMainActorを使って定義
    @MainActor
    private func setPositionForEntity(_ entity: Entity, position: SIMD3<Float>) {
        entity.position = position
    }

    private func loadMapPinModels(taskGroup: inout TaskGroup<LoadResult>) {
        logger.info("Loading map models")
        for pin in pins {
            taskGroup.addTask {
                do {
                    guard let pinEntity = try await self.loadFromRCPro(named: pinModelName, fromSceneNamed: pinSceneName, scaleFactor: 0.03) else {
                        fatalError("Attempted to load piece entity \(pin.name) but failed.")
                    }
                    // メインスレッド上で位置を設定するために、新しい関数を呼び出す
                    await self.setPositionForEntity(pinEntity, position: SIMD3<Float>(pin.locationX, 0.004, pin.locationZ))
                    await self.setImageBasedLightForEntity(entity: pinEntity, intensityExponent: 0.8)
                    await self.setPinsTappable(entity: pinEntity)
                    await self.setIdentifiableComponent(entity: pinEntity, id: pin.name)
                    return LoadResult(entity: pinEntity, key: pin.key.rawValue)
                } catch {
                    fatalError("Attempter to load \(pin.name)")
                }
            }
        }
    }
    
    @MainActor
    private func setImageBasedLightForEntity(entity: Entity, intensityExponent: Float) async {
        guard let env = try? await EnvironmentResource(named: "ImageBasedLight")
        else { return }
        
        let iblComponent = ImageBasedLightComponent(source: .single(env), intensityExponent: intensityExponent)

        entity.components[ImageBasedLightComponent.self] = iblComponent
        entity.components.set(ImageBasedLightReceiverComponent(imageBasedLight: entity))
    }
    
    private func setIdentifiableComponent(entity: Entity, id: String) async {
        let identifiableComponent = IdentifiableComponent(id: id)
        entity.components.set(identifiableComponent)
    }
    
    @MainActor
    private func setPinsTappable(entity: Entity) async {
        entity.components[CollisionComponent.self] = CollisionComponent(
            shapes: [.generateBox(size: [0.1, 0.1, 0.1])],
            mode: .trigger,
            filter: .sensor
        )
        // 入力ターゲットコンポーネントを追加
        entity.components[InputTargetComponent.self] = InputTargetComponent()
    }
    
//    @MainActor
//    private func setCollisionComponentForEntity(entity: Entity) async {
//        do {
//            let collisionComponent = await CollisionComponent(shapes: [try ShapeResource.generateConvex(from: entity)])
//            entity.components.set(InputTargetComponent())
//        } catch {
//            print("Failed to set collision component for entity. \(error)")
//        }
//    }
    
    private func loadMapModel(taskGroup: inout TaskGroup<LoadResult>) {
        taskGroup.addTask {
            var result: Entity? = nil
            do {
                logger.info("Loading start pirce.")
                if let entity = try await self.loadFromRCPro(named: mapModelName, fromSceneNamed: mapSceneName, scaleFactor: 0.05
                ) {
                    await self.setImageBasedLightForEntity(entity: entity, intensityExponent: 0.5)
                    result = entity
                }
            } catch {
                fatalError("Attempted to load map entity but failed: \(error.localizedDescription)")
            }
            guard let result = result else {
                fatalError("Loaded map model is nil")
            }
            return LoadResult(entity: result, key: "map")
        }
    }
}
