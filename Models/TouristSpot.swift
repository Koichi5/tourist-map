////
////  TouristSpot.swift
////  TouristMap
////
////  Created by Koichi Kishimoto on 2024/03/31.
////
//
import Foundation

struct TouristSpot: Hashable, Codable {
    let name: String
    let description: String
    let latitude: Float
    let longitude: Float
    let thumbnailImageUrl: String
    let placeId: String
}
