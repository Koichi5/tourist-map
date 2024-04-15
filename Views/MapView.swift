//
//  MapView.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/03/26.
//

import SwiftUI
import RealityKit

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
                        appState.updateEntityVisibility(for: searchText)
                    }
            }
        }
        .ornament(attachmentAnchor: .scene(.bottom)) {
            Button {
                isSearchFieldShown.toggle()
                appState.updateEntityVisibility(for: "")
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
}

#Preview {
    MapView()
}
