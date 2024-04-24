//
//  ModelLoadingView.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/04/05.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ModelLoadingView: View {
    @Environment(AppState.self) var appState

    var body: some View {
        RealityView { content in
            guard let entity = try? await Entity(named: standByMapSceneName, in: realityKitContentBundle) else {
                fatalError("Unable to load scene model")
            }
            
            // edit scale
            entity.scale = SIMD3<Float>(repeating: 0.02)
            
            // add light
            guard let env = try? await EnvironmentResource(named: "ImageBasedLight")
            else { return }
            
            let iblComponent = ImageBasedLightComponent(source: .single(env), intensityExponent: 0.8)
            
            entity.components[ImageBasedLightComponent.self] = iblComponent
            entity.components.set(ImageBasedLightReceiverComponent(imageBasedLight: entity))
            
            // add animation
            let animation = entity.availableAnimations[0]
            let player = entity.playAnimation(animation.repeat(), transitionDuration: 0.25, startsPaused: true)
            appState.animationPlayer = player
            player.resume()
            
            content.add(entity)
        }
    }
}
