//
//  CityInfo.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/03/31.
//

import Foundation
import SwiftUI

let cities = [
    CityInfo(
        name: "Tokyo",
        imageName: "tokyo",
        basicInfo: BasicInfo(
            capitalLocation: "東京",
            population: 14105098,
            area: 2191
        ),
        populationTrendData: tokyoLineData,
        touristSpots: tokyoTouristSpots,
        cityIndustryDataSet: CityIndustryDataSet(
            primary: tokyoPrimaryData,
            secondaryAndTertiary: tokyoSecondaryData
        )
    ),
    CityInfo(
        name: "Osaka",
        imageName: "osaka",
        basicInfo: BasicInfo(
            capitalLocation: "大阪",
            population: 8768019,
            area: 225
        ),
        populationTrendData: osakaLineData,
        touristSpots: osakaTouristSpots,
        cityIndustryDataSet: CityIndustryDataSet(
            primary: osakaPrimaryData,
            secondaryAndTertiary: osakaSecondaryData
        )
    ),
]

// 都市の情報を格納するための構造体
struct CityInfo: Hashable {
    let name: String
    let imageName: String
    let basicInfo: BasicInfo
    let populationTrendData: [PopulationTrendsLineData]
    let touristSpots: [TouristSpot]
    let cityIndustryDataSet: CityIndustryDataSet
    
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
