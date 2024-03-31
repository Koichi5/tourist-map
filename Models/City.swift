//
//  City.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/03/25.
//

import Foundation
import SwiftUI

public struct City: Identifiable {
    public var id: UUID
    public var name: String
    public var displayName: String
    public var description: String
    public var latitude: Double
    public var longitude: Double
    
    init(name: String,
         displayName: String,
         description: String,
         latitude: Double,
         longitude: Double) {
        self.name = name
        self.displayName = displayName
        self.description = description
        self.latitude = latitude
        self.longitude = longitude
        self.id = UUID()
    }
}
