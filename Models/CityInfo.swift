////
////  CityInfo.swift
////  TouristMap
////
////  Created by Koichi Kishimoto on 2024/03/31.
////
//
import Foundation
import SwiftUI

struct CityInfo: Hashable {
    let name: String
    let imageName: String
    let touristSpots: [TouristSpot]
    let prefecture: Prefecture

    var image: Image {
        Image(imageName)
    }

    var nightImage: Image {
        Image(imageName+"Night")
    }
}

enum CityDetailInfoMenu: String, Hashable, CaseIterable {
    case basicInfo = "基本情報"
    case populationTrends = "人口推移"
    case touristSpot = "観光地"
    case inductory = "産業"
}
