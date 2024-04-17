//
//  AppState.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/03/25.
//

import Foundation
import SwiftUI
import RealityKit

@Observable
@MainActor
public class AppState {
    
    var phase: AppPhase = .startingUp
    
    var isImmersiveViewShown = false
    
    // Cityの「産業」タブ
    var isCityIndustryShown = false
    var isPrimaryIndustryDataShown = true
    
    var pinTemplates = [Entity]()
    
    public var defaultPinScale = SIMD3<Float>(0.03, 0.03, 0.03)
    public var largePinScale = SIMD3<Float>(0.08, 0.08, 0.08)
    
    public var root = Entity()
    
    public var mapModel: Entity?
    
    public var standByMapModel: Entity?
    
    public var animationPlayer: AnimationPlaybackController?
    
    public var pins = [
        // locationX: 左から右にプラス
        // locationZ: 上から下にプラス
        Pin(prefecture: Prefecture.hokkaido, locationX: 0.10, locationZ: -0.16),
        Pin(prefecture: Prefecture.aomori, locationX: 0.07, locationZ: -0.09),
        Pin(prefecture: Prefecture.iwate, locationX: 0.08, locationZ: -0.06),
        Pin(prefecture: Prefecture.akita, locationX: 0.06, locationZ: -0.06),
        Pin(prefecture: Prefecture.yamagata, locationX: 0.05, locationZ: -0.03),
        Pin(prefecture: Prefecture.miyagi, locationX: 0.07, locationZ: -0.03),
        Pin(prefecture: Prefecture.fukushima, locationX: 0.06, locationZ: 0),
        
        Pin(prefecture: Prefecture.niigata, locationX: 0.03, locationZ: 0),
        Pin(prefecture: Prefecture.ibaraki, locationX: 0.055, locationZ: 0.04),
        Pin(prefecture: Prefecture.tochigi, locationX: 0.045, locationZ: 0.025),
        Pin(prefecture: Prefecture.gunma, locationX: 0.025, locationZ: 0.025),
        Pin(prefecture: Prefecture.saitama, locationX: 0.035, locationZ: 0.045),
        Pin(prefecture: Prefecture.chiba, locationX: 0.055, locationZ: 0.06),
        Pin(prefecture: Prefecture.kanagawa, locationX: 0.035, locationZ: 0.055),
        Pin(prefecture: Prefecture.yamanashi, locationX: 0.02, locationZ: 0.052),
        
        Pin(prefecture: Prefecture.shizuoka, locationX: 0.01, locationZ: 0.07),
        Pin(prefecture: Prefecture.aichi, locationX: -0.01, locationZ: 0.07),
        Pin(prefecture: Prefecture.nagano, locationX: 0.005, locationZ: 0.04),
        Pin(prefecture: Prefecture.toyama, locationX: -0.01, locationZ: 0.025),
        Pin(prefecture: Prefecture.gifu, locationX: -0.015, locationZ: 0.055),
        Pin(prefecture: Prefecture.ishikawa, locationX: -0.025, locationZ: 0.03),
        Pin(prefecture: Prefecture.fukui, locationX: -0.03, locationZ: 0.045),
        
        Pin(prefecture: Prefecture.shiga, locationX: -0.035, locationZ: 0.065),
        Pin(prefecture: Prefecture.mie, locationX: -0.03, locationZ: 0.085),
        Pin(prefecture: Prefecture.nara, locationX: -0.042, locationZ: 0.085),
        Pin(prefecture: Prefecture.wakayama, locationX: -0.05, locationZ: 0.1),
        Pin(prefecture: Prefecture.osaka, locationX: -0.05, locationZ: 0.078),
        Pin(prefecture: Prefecture.kyoto, locationX: -0.05, locationZ: 0.065),
        Pin(prefecture: Prefecture.hyogo, locationX: -0.065, locationZ: 0.07),
        
        Pin(prefecture: Prefecture.tottori, locationX: -0.085, locationZ: 0.06),
        Pin(prefecture: Prefecture.shimane, locationX: -0.11, locationZ: 0.065),
        Pin(prefecture: Prefecture.okayama, locationX: -0.09, locationZ: 0.075),
        Pin(prefecture: Prefecture.hiroshima, locationX: -0.11, locationZ: 0.085),
        Pin(prefecture: Prefecture.yamaguchi, locationX: -0.14, locationZ: 0.09),
        
        Pin(prefecture: Prefecture.kagawa, locationX: -0.085, locationZ: 0.09),
        Pin(prefecture: Prefecture.tokushima, locationX: -0.08, locationZ: 0.1),
        Pin(prefecture: Prefecture.kochi, locationX: -0.1, locationZ: 0.11),
        Pin(prefecture: Prefecture.ehime, locationX: -0.11, locationZ: 0.105),

        Pin(prefecture: Prefecture.fukuoka, locationX: -0.16, locationZ: 0.11),
        Pin(prefecture: Prefecture.saga, locationX: -0.175, locationZ: 0.115),
        Pin(prefecture: Prefecture.nagasaki, locationX: -0.18, locationZ: 0.125),
        Pin(prefecture: Prefecture.oita, locationX: -0.14, locationZ: 0.12),
        Pin(prefecture: Prefecture.kumamoto, locationX: -0.16, locationZ: 0.14),
        Pin(prefecture: Prefecture.miyazaki, locationX: -0.145, locationZ: 0.145),
        Pin(prefecture: Prefecture.kagoshima, locationX: -0.155, locationZ: 0.16),
        Pin(prefecture: Prefecture.okinawa, locationX: -0.165, locationZ: 0.19),

        
        // locationX: 左から右にプラス, 右から左にマイナス
        // locationZ: 上から下にプラス, 下から上にマイナス
        Pin(prefecture: Prefecture.tokyo, locationX: 0.043, locationZ: 0.049),
    ]
        
    init() {
        Task.detached(priority: .high) {
            await self.loadModels()
        }
    }
}


