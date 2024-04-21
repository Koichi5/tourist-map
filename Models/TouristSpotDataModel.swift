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
final class TouristSpotDataModel: Codable {
    enum CodingKeys: CodingKey {
        case placeId,
             latitude,
             longitude,
             name,
             spotDescription,
             thumbnailImageUrl
    }
    
    @Attribute(.unique) let id: UUID
    var placeId: String?
    var latitude: Float? = 0.0
    var longitude: Float? = 0.0
    var name: String?
    var spotDescription: String?
    var thumbnailImageUrl: String?
    
    init(
        latitude: Float,
        longitude: Float,
        name: String,
        placeId: String,
        spotDescription: String,
        thumbnailImageUrl: String
    ) {
        self.id = UUID()
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
        self.placeId = placeId
        self.spotDescription = spotDescription
        self.thumbnailImageUrl = thumbnailImageUrl
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = UUID()
        latitude = try container.decode(Float.self, forKey: .latitude)
        longitude = try container.decode(Float.self, forKey: .longitude)
        name = try container.decode(String.self, forKey: .name)
        placeId = try container.decode(String.self, forKey: .placeId)
        spotDescription = try container.decode(String.self, forKey: .spotDescription)
        thumbnailImageUrl = try container.decode(String.self, forKey: .thumbnailImageUrl)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
        try container.encode(name, forKey: .name)
        try container.encode(placeId, forKey: .placeId)
        try container.encode(spotDescription, forKey: .spotDescription)
        try container.encode(thumbnailImageUrl, forKey: .thumbnailImageUrl)
    }
}
