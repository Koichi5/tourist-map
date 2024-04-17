//
//  Pin.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/03/25.
//

import Foundation

public struct Pin: Identifiable {
    public var id: UUID
    var prefecture: Prefecture
    public var locationX: Float
    public var locationZ: Float
    
    init(prefecture: Prefecture, locationX: Float, locationZ: Float) {
        self.prefecture = prefecture
        self.locationX = locationX
        self.locationZ = locationZ
        self.id = UUID()
    }
}
