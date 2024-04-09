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
    @State var searchText = ""
    @State private var isSearchFieldShown = false
    
    enum AttachmentIDs: Int {
        case editMenu = 100
    }
    var body: some View {
        ZStack(alignment: .topLeading) {
            RealityView { content, attachments in
                content.add(appState.root)
            }
        attachments: {
            Attachment(id: AttachmentIDs.editMenu) {
                Text("Edit Attachment")
            }
        }
        .gesture(
            SpatialTapGesture()
                .targetedToAnyEntity()
                .onEnded { value in
                    self.onPinTap(value: value)
                }
        )
            if(isSearchFieldShown) {
                TextField("都道府県名", text: $searchText)
                    .padding(.top, 50)
                    .padding(.leading, 50)
                    .onChange(of: searchText) {
                        updateEntityVisibility(for: searchText)
                    }
            }
        }
        .ornament(attachmentAnchor: .scene(.bottom)) {
            Button {
                isSearchFieldShown.toggle()
                updateEntityVisibility(for: "")
            } label: {
                isSearchFieldShown ? HStack {
                    Image(systemName: "xmark")
                    Text("やめる")
                } :
                HStack {
                    Image(systemName: "magnifyingglass")
                    Text("検索")
                }
                
            }
        }
    }
    
    @MainActor func updateEntityVisibility(for searchText: String) {
        appState.root.children.forEach { entity in
            if let identifiableComponent = entity.components[IdentifiableComponent.self] {
                let searchTextLowercased = searchText.lowercased()
                let idLowercased = identifiableComponent.id.lowercased()
                let idDisplayName = identifiableComponent.displayName
                
                if searchText.isEmpty {
                    entity.isEnabled = true
                    // デフォルトのピンの大きさ
                    entity.scale = SIMD3<Float>(0.03, 0.03, 0.03)
                } else {
                    // searchTextによるフィルタリング（現在キーボードは日本語対応していないが、displayName 検索にも対応）
                    entity.isEnabled = idLowercased.contains(searchTextLowercased) || idDisplayName.contains(searchText)
                    entity.scale = SIMD3<Float>(0.08, 0.08, 0.08)
                }
            }
        }
    }
    
}

#Preview {
    MapView()
}
