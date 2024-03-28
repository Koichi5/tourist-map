//
//  AppPhase.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/03/25.
//

import Foundation
import OSLog

public enum AppPhase: String, Codable, Sendable, Equatable {
    case startingUp
    case loadingAssets
    case waitingToStart
    case map
    case onPinTap
    
    var isImmersed: Bool {
        switch self {
        case .startingUp, .loadingAssets, .waitingToStart, .map, .onPinTap:
            return false
        }
    }
    
    func canProgress(to phase: AppPhase) -> Bool {
        switch self {
        case .startingUp:
            return phase == .loadingAssets
        case .loadingAssets:
            return phase == .waitingToStart
        case .waitingToStart:
            return phase == .map
        case .map:
            return phase == .onPinTap
        case .onPinTap:
            return true
        }
    }
    
    @discardableResult
    mutating public func transition(to newPhase: AppPhase) -> Bool {
        logger.info("Phase change to \(newPhase.rawValue)")
        guard self != newPhase else {
            logger.debug("Attempting to change phase to \(newPhase.rawValue) but already in that state. Trrating as a no-op.")
            return false
        }
        self = newPhase
        return true
    }
}

let logger = Logger()
