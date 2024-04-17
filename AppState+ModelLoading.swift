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
    // MARK: Loading assets
    // load assets from Reality Composer Pro
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
    
    // load assets that use in this app
    public func loadModels() async {
        defer {
            finishedLoadingAssets()
        }
        _ = Date.timeIntervalSinceReferenceDate
        logger.info("Starting load from Reality Composer Pro Project.")
        await finishedStartingUp()
        // モデルの読み込み
        await withTaskGroup(of: LoadResult.self) { taskGroup in
            loadMapModel(taskGroup: &taskGroup)
            loadMapPinModels(taskGroup: &taskGroup)
            for await result in taskGroup {
                if pins.first(where: { $0.prefecture.rawValue == result.key }) != nil {
                    addMapPinEntitiesToState(result: result)
                } else if result.key == "map" {
                    addMapEntityToState(entity: result.entity)
                }
            }
        }
    }
    
    // locad pin model (load from Reality Composer Pro and change position, lighting, tapp gesture and id)
    private func loadMapPinModels(taskGroup: inout TaskGroup<LoadResult>) {
        logger.info("Loading map models")
        for pin in pins {
            taskGroup.addTask {
                do {
                    guard let pinEntity = try await self.loadFromRCPro(named: pinModelName, fromSceneNamed: pinSceneName, scaleFactor: 0.03) else {
                        fatalError("Attempted to load piece entity \(pin.prefecture.rawValue) but failed.")
                    }
                    // メインスレッド上で位置を設定するために、新しい関数を呼び出す
                    await self.setPositionForEntity(pinEntity, position: SIMD3<Float>(pin.locationX, 0.004, pin.locationZ))
                    await self.setImageBasedLightForEntity(entity: pinEntity, intensityExponent: 0.8)
                    await self.setPinsTappable(entity: pinEntity)
                    print("pin.prefecture.rawValue: \(pin.prefecture.rawValue)")
                    await self.setIdentifiableComponent(entity: pinEntity, id: pin.prefecture.rawValue, displayName: pin.prefecture.nameInKanji())
                    return LoadResult(entity: pinEntity, key: pin.prefecture.rawValue)
                } catch {
                    fatalError("Attempter to load \(pin.prefecture.rawValue)")
                }
            }
        }
    }
    
    private func loadMapModel(taskGroup: inout TaskGroup<LoadResult>) {
        taskGroup.addTask {
            var result: Entity? = nil
            do {
                logger.info("Loading map model.")
                if let entity = try await self.loadFromRCPro(named: mapModelName, fromSceneNamed: mapSceneName, scaleFactor: 0.05
                ) {
                    await self.setImageBasedLightForEntity(entity: entity, intensityExponent: 1.5)
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
    
    // MARK: Add entities to AppState
    // add map pin entities to app state
    private func addMapPinEntitiesToState(result: LoadResult) {
        self.add(template: result.entity)
    }
    
    // add map entity to app state
    private func addMapEntityToState(entity: Entity) {
        print("add map entity to state fired")
        mapModel = entity
    }
    
    // MARK: Add entities to Root entity
    // add map entity to root entity
    public func addMapEntityToScene() {
        guard let mapModel = mapModel else {
            fatalError("Map model not loaded.")
        }
        root.addChild(mapModel)
    }
    
    // add map pin entities to root entity
    public func addMapPinEntitiesToScene() {
        for pin in pinTemplates {
            root.addChild(pin)
        }
    }
    
    // MARK: Entity settings
    // rotate root entity
    public func rotateRoot() {
        // Y軸を中心に45度回転させる（ラジアンで指定）
        let angle = Float.pi / 4 // 45度
        root.transform.rotation = simd_quatf(angle: angle, axis: [1, 0, 0])
    }
    
    // set entity position ( to adjust pin location )
    @MainActor
    private func setPositionForEntity(_ entity: Entity, position: SIMD3<Float>) {
        entity.position = position
    }
    
    // set entity scale
    @MainActor
    private func setScaleForEntity(entity: Entity, scale: Float) {
        entity.scale = SIMD3<Float>(repeating: scale)
    }
    
    // set entity lighting
    @MainActor
    private func setImageBasedLightForEntity(entity: Entity, intensityExponent: Float) async {
        guard let env = try? await EnvironmentResource(named: "ImageBasedLight")
        else { return }
        
        let iblComponent = ImageBasedLightComponent(source: .single(env), intensityExponent: intensityExponent)
        
        entity.components[ImageBasedLightComponent.self] = iblComponent
        entity.components.set(ImageBasedLightReceiverComponent(imageBasedLight: entity))
    }
    
    // set entity id(make pin identifiable)
    private func setIdentifiableComponent(entity: Entity, id: String, displayName: String) async {
        let identifiableComponent = IdentifiableComponent(id: id, displayName: displayName)
        entity.components.set(identifiableComponent)
    }
    
    // set entity tap gesture(make pin tappable)
    @MainActor
    private func setPinsTappable(entity: Entity) async {
        entity.components[CollisionComponent.self] = CollisionComponent(
            shapes: [.generateBox(size: [0.1, 1, 0.1])],
            mode: .trigger,
            filter: .sensor
        )
        // 入力ターゲットコンポーネントを追加
        entity.components[InputTargetComponent.self] = InputTargetComponent()
    }
}
