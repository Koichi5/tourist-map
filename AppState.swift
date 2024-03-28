//
//  AppState.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/03/25.
//

import Foundation
import RealityKit

@Observable
@MainActor
public class AppState {
    
    var phase: AppPhase = .startingUp
    
    var isImmersiveViewShown = false
    
    var pinTemplates = [Entity]()
    
    public var root = Entity()
    
    public var mapModel: Entity?
    
    public var pins = [
        Pin(name: "tokyo", locationX: 0.043, locationZ: 0.049, key: .tokyo, city: City(name: "Tokyo", displayName: "東京", description: "日本の首都", latitude: 35.6813667, longitude: 139.7657033)),
        
        Pin(name: "osaka", locationX: -0.05, locationZ: 0.078, key: .osaka, city: City(name: "Osaka", displayName: "大阪", description: "日本の首都", latitude: 35.6813667, longitude: 139.7657033))
    ]
    
    init() {
        Task.detached(priority: .high) {
            await self.loadModels()
        }
    }
}

