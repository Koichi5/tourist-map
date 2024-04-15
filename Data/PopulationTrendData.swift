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
