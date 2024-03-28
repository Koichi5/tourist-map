//
//  AppState+Phases.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/03/25.
//

import Foundation

extension AppState {
    public func finishedStartingUp() {
        phase.transition(to: .loadingAssets)
    }
    
    public func finishedLoadingAssets() {
        phase.transition(to: .waitingToStart)
    }
    
    public func startMap() {
        phase.transition(to: .map)
        guard let mapModel = mapModel else {
            fatalError("Map model not loaded.")
        }
        for pin in pinTemplates {
            root.addChild(pin)
        }
        root.addChild(mapModel)
    }
    
    public func onPinTap() {
        phase.transition(to: .onPinTap)
    }
}
