//
//  CityIndustryData.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/03/31.
//

import Foundation

struct CityIndustryDataSet: Equatable, Hashable {
    let primary: CityIndustryData
    let secondaryAndTertiary: CityIndustryData
}

struct CityIndustryData: Equatable, Hashable {
    let imageName: String
    let sourceUrl: String
    let sourceDescription: String
}

let tokyoPrimaryData: CityIndustryData = CityIndustryData(imageName: "tokyoPrimary", sourceUrl: "https://resas.go.jp/data-analysis-support/primary-industry/#/agriculture-all/13/-", sourceDescription: "農林水産省「都道府県別農業産出額及び生産農業所得」")

let tokyoSecondaryData: CityIndustryData = CityIndustryData(imageName: "tokyoSecondary", sourceUrl: "https://resas.go.jp/data-analysis-support/#/industry-overview/13/-/2/-", sourceDescription: "総務省「経済センサス－基礎調査」再編加工、総務省・経済産業省「経済センサス－活動調査」再編加工")

let osakaPrimaryData: CityIndustryData = CityIndustryData(imageName: "osakaPrimary", sourceUrl: "https://resas.go.jp/data-analysis-support/primary-industry/#/agriculture-all/27/-", sourceDescription: "農林水産省「都道府県別農業産出額及び生産農業所得」")

let osakaSecondaryData: CityIndustryData = CityIndustryData(imageName: "osakaSecondary", sourceUrl: "https://resas.go.jp/data-analysis-support/#/industry-overview/27/-/2/-", sourceDescription: "総務省「経済センサス－基礎調査」再編加工、総務省・経済産業省「経済センサス－活動調査」再編加工")
