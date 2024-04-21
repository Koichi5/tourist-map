//
//  Industry.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/04/11.
//

import Foundation

struct IndustryDataResponse: Codable {
    let message: String?
    let result: IndustryResult
}

struct IndustryResult: Codable {
    let prefName: String
    let prefCode: Int
    let sicCode: String
    let sicName: String
    let data: [IndustryData]
}

struct IndustryData: Codable {
    let simcCode: String
    let simcName: String
    let value: Double
    let employee: Double
    let labor: Double
}
