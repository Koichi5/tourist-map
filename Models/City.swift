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

// 都市のデータを管理するためのサンプルデータ
let cities = [
    CityInfo(name: "Tokyo", description: "東京は日本の首都で、世界最大の都市の一つです。...", imageName: "tokyo", basicInfo: BasicInfo(capitalLocation: "東京", population: 14105098, area: 2191), populationTrendData: tokyoLineData),
    CityInfo(name: "Osaka", description: "日本の第2の都市です。...", imageName: "osaka", basicInfo: BasicInfo(capitalLocation: "大阪", population: 8768019, area: 225), populationTrendData: osakaLineData),
]

// 都市の情報を格納するための構造体
struct CityInfo: Hashable {
    let name: String
    let description: String
    let imageName: String
    let basicInfo: BasicInfo
    let populationTrendData: [PopulationTrendsLineData]
    
    // 画像を取得するためのcomputed property
    var image: Image {
        Image(imageName)
    }
    
    var nightImage: Image {
        Image(imageName+"Night")
    }
}

struct BasicInfo: Equatable, Hashable {
    var capitalLocation: String
    var population: Int
    var area: Double
    var populationDensity: Double { Double(population) / area }
}

enum CityDetailInfoMenu: String, Hashable, CaseIterable {
    case basicInfo = "基本情報"
    case populationTrends = "人口推移"
    case touristSpot = "観光地"
    case inductory = "産業"
}
