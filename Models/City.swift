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

enum CityDescription: String {
    case tokyo = "日本の首都"
    case osaka = "日本の第2の都市"
}

// 都市の情報を格納するための構造体
struct CityInfo {
    let name: String
    let description: String
    let imageName: String

    // 画像を取得するためのcomputed property
    var image: Image {
        Image(imageName)
    }
    
    var nightImage: Image {
        Image(imageName+"Night")
    }
}

// 都市のデータを管理するためのサンプルデータ
struct CitiesData {
    static let cities = [
        CityInfo(name: "Tokyo", description: "東京は日本の首都で、世界最大の都市の一つです。...", imageName: "tokyo"),
        CityInfo(name: "Osaka", description: "日本の第2の都市です。...", imageName: "osaka"),
    ]
}
