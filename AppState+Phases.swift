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
    }
    
    public func cityPopulationTrends() {
        phase.transition(to: .cityPopulationTrends)
    }
    
    public func cityTouristSpots() {
        phase.transition(to: .cityTouristSpots)
    }
    
    public func cityIndustry() {
        phase.transition(to: .cityIndustry)
    }
}
