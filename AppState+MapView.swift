//
//  AppState+MapView.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/03/25.
//

import Foundation
import RealityKit

extension AppState {
    public func add(template: Entity) {
        pinTemplates.append(template)
    }
    
    @MainActor func updateEntityVisibility(for searchText: String) {
        self.root.children.forEach { entity in
            if let identifiableComponent = entity.components[IdentifiableComponent.self] {
                let searchTextLowercased = searchText.lowercased()
                let idLowercased = identifiableComponent.id.lowercased()
                let idDisplayName = identifiableComponent.displayName
                
                if searchText.isEmpty {
                    entity.isEnabled = true
                    // デフォルトのピンの大きさ
                    entity.scale = self.defaultPinScale
                } else {
                    // searchTextによるフィルタリング（現在キーボードは日本語対応していないが、displayName 検索にも対応）
                    entity.isEnabled = idLowercased.contains(searchTextLowercased) || idDisplayName.contains(searchText)
                    entity.scale = self.largePinScale
                }
            }
        }
    }
}
