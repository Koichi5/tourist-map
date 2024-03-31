//
//  CityInfo.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/03/31.
//

import Foundation
import SwiftUI

let cities = [
    CityInfo(name: "Tokyo", description: "東京は日本の首都で、世界最大の都市の一つです。...", imageName: "tokyo", basicInfo: BasicInfo(capitalLocation: "東京", population: 14105098, area: 2191), populationTrendData: tokyoLineData, touristSpots: tokyoTouristSpots),
    CityInfo(name: "Osaka", description: "日本の第2の都市です。...", imageName: "osaka", basicInfo: BasicInfo(capitalLocation: "大阪", population: 8768019, area: 225), populationTrendData: osakaLineData, touristSpots: osakaTouristSpots),
]

// 都市の情報を格納するための構造体
struct CityInfo: Hashable {
    let name: String
    let description: String
    let imageName: String
    let basicInfo: BasicInfo
    let populationTrendData: [PopulationTrendsLineData]
    let touristSpots: [TouristSpot]
    
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
