//
//  Population.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/04/10.
//

import Foundation

struct PopulationResponse: Decodable {
    let message: String?
    let result: PopulationResult
}

struct PopulationResult: Decodable {
    let boundaryYear: Int
    let data: [PopulationData]
}

struct PopulationData: Decodable {
    let label: String
    let data: [YearlyData]
}

struct YearlyData: Decodable {
    let year: Int
    let value: Int
}
