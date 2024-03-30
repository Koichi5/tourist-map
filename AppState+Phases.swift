//
//  AppState+Phases.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/03/25.
//

import Foundation
import SwiftUI

extension AppState {
    public func finishedStartingUp() {
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
        phase.transition(to: .onPinTap)
    }
}
