//
//  PlaceImage.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/04/12.
//

import Foundation

struct PlaceDetailsResponse: Decodable {
    let result: PlaceResult
}

struct PlaceResult: Decodable {
    let photos: [Photo]?
}

struct Photo: Decodable {
    let photoReference: String
    let height: Int
    let width: Int

    enum CodingKeys: String, CodingKey {
        case photoReference = "photo_reference"
        case height, width
    }
}
