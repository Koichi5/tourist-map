//
//  TouristSpotDataModel.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/04/14.
//
//

import Foundation
import SwiftData

@Model
final class TouristSpotDataModel {
    @Attribute(.unique) var placeId: String?
    var latitude: Float? = 0.0
    var longitude: Float? = 0.0
    var name: String?
    var spotDescription: String?
    var thumbnailImageUrl: String?
    
//    @Relationship(deleteRule: .cascade, inverse: \CityInfoDataModel.touristSpots)
//    var cityInfoDataModel: CityInfoDataModel?

    init(
        latitude: Float,
        longitude: Float,
        name: String,
        placeId: String,
        spotDescription: String,
        thumbnailImageUrl: String
//        cityInfoDataModel: CityInfoDataModel?
    ) {
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
        self.placeId = placeId
        self.spotDescription = spotDescription
        self.thumbnailImageUrl = thumbnailImageUrl
//        self.cityInfoDataModel = cityInfoDataModel
    }
}
