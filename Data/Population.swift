//
//  Population.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/04/10.
//

import Foundation

// APIレスポンス全体を表す構造体
struct PopulationResponse: Decodable {
    let message: String?
    let result: PopulationResult
}

// "result" キーの内容を表す構造体
struct PopulationResult: Decodable {
    let boundaryYear: Int
    let data: [PopulationData]
}

// "data" キー内の個々のデータを表す構造体
struct PopulationData: Decodable {
    let label: String
    let data: [YearlyData]
}

struct YearlyData: Decodable {
    let year: Int
    let value: Int
}
