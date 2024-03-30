//
//  PopulationTrendData.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/03/30.
//

import Foundation

struct PopulationTrendsLineData: Identifiable, Equatable, Hashable {
    var id = UUID()
    var year: Int
    var population: Int
}

let tokyoLineData: [PopulationTrendsLineData] = [
    .init(year: 2015, population: 13131172),
    .init(year: 2016, population: 13207000),
    .init(year: 2017, population: 13273000),
    .init(year: 2018, population: 13340000),
    .init(year: 2019, population: 13405000),
    .init(year: 2020, population: 13484028),
    .init(year: 2021, population: 13459000),
    .init(year: 2022, population: 13443000),
]

let osakaLineData: [PopulationTrendsLineData] = [
    .init(year: 2015, population: 8683865),
    .init(year: 2016, population: 8672000),
    .init(year: 2017, population: 8657000),
    .init(year: 2018, population: 8639000),
    .init(year: 2019, population: 8623000),
    .init(year: 2020, population: 8595483),
    .init(year: 2021, population: 8565000),
    .init(year: 2022, population: 8524000),
]
