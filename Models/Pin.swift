//
//  Pin.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/03/25.
//

import Foundation

public struct Pin: Identifiable {
    public var id: UUID
    public var name: String
    public var locationX: Float
    public var locationZ: Float
    public var key: PinKey
    public var city: City
    
    init(name: String, locationX: Float, locationZ: Float, key: PinKey, city: City) {
        self.name = name
        self.locationX = locationX
        self.locationZ = locationZ
        self.key = key
        self.city = city
        self.id = UUID()
    }
}

public enum PinKey: String, CaseIterable, Codable, Sendable {
    case tokyo = "tokyo"
    case osaka = "osaka"
}

