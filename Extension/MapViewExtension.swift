//
//  MapViewExtension.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/04/02.
//

import SwiftUI
import RealityKit

extension MapView {
    @MainActor
    public func onPinTap(value: EntityTargetValue<SpatialTapGesture.Value>) {
        appState.phase.transition(to: .city)
        if let idComponent = value.entity.components[IdentifiableComponent.self] {
            print("Entity ID: \(idComponent.id)")
            self.openWindow(id: ViewID.cityView, value: idComponent.id)
        }
    }
}
