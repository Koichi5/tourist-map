//
//  CityInfoDataModel.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/04/14.
//
//

import Foundation
import SwiftData

@Model
final class CityInfoDataModel {
    var imageName: String?
    var name: String?
    var prefecture: Prefecture?
    @Relationship(deleteRule: .cascade)
    var touristSpots: [TouristSpotDataModel] = []

    init(
        imageName: String,
        name: String,
        prefecture: Prefecture
    ) {
        self.imageName = imageName
        self.name = name
        self.prefecture = prefecture
    }
}
