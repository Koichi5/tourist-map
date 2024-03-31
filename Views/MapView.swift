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
                        self.openWindow(id: ViewID.cityViewId, value: idComponent.id)
                    }
                }
        )
    }
    
// map entity without loading
    
//    var body: some View {
//        RealityView { content in
//            if let mapEntity = try? await Entity(named: "Map", in: realityKitContentBundle) {
//                mapEntity.scale = SIMD3<Float>(repeating: 0.05)
//                content.add(mapEntity)
//            }
//        }
//    }
}

#Preview {
    MapView()
}
