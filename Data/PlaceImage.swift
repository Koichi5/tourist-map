//
//  PlaceImage.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/04/12.
//

import Foundation

// APIレスポンス全体を表す構造体
struct PlaceDetailsResponse: Decodable {
    let result: PlaceResult
}

// "result" キーの内容を表す構造体
struct PlaceResult: Decodable {
    let photos: [Photo]?
}

// "photos" キー内の個々のデータを表す構造体
struct Photo: Decodable {
    let photoReference: String

    enum CodingKeys: String, CodingKey {
        case photoReference = "photo_reference"
    }
}
