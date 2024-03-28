//
//  MapView.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/03/26.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct MapView: View {
    @Environment(AppState.self) var appState
    @Environment(\.dismiss) internal var dismiss
    @Environment(\.openWindow) internal var openWindow
    
    enum AttachmentIDs: Int {
        case editMenu = 100
    }
    var body: some View {
        RealityView { content, attachments in
            content.add(appState.root)
        } attachments: {
            Attachment(id: AttachmentIDs.editMenu) {
                Text("Edit Attachment")
            }
        }
        .gesture(
            SpatialTapGesture()
                .targetedToAnyEntity()
                .onEnded { value in
                    if let idComponent = value.entity.components[IdentifiableComponent.self] {
                        print("Entity ID: \(idComponent.id)")
                        self.openWindow(id: ViewID.detailViewId, value: idComponent.id)
                    }
                }
        )
    }
}

#Preview {
    MapView()
}
