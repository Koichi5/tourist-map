//
//  AppState+Phases.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/03/25.
//

import Foundation
import SwiftUI
import RealityKit

extension AppState {
    public func finishedStartingUp() async {
        phase.transition(to: .loadingAssets)
        // ローディングを見るためにあえて処理を遅く設定
        try? await Task.sleep(nanoseconds: 4_000_000_000)
    }
    
    public func finishedLoadingAssets() {
        phase.transition(to: .waitingToStart)
    }
    
    public func startMap() {
        phase.transition(to: .map)
        self.addMapEntityToScene()
        self.addMapPinEntitiesToScene()
        self.rotateRoot()
    }
    
    public func onPinTap() {
        phase.transition(to: .city)
    }
    
    public func cityBasicInfo() {
        phase.transition(to: .cityBasicInfo)
        isCityIndustryShown = false
    }
    
    public func cityPopulationTrends() {
        phase.transition(to: .cityPopulationTrends)
        isCityIndustryShown = false
    }
    
    public func cityTouristSpots() {
        phase.transition(to: .cityTouristSpots)
        isCityIndustryShown = false
    }
    
    public func cityIndustry() {
        phase.transition(to: .cityIndustry)
        isCityIndustryShown = true
    }
}
