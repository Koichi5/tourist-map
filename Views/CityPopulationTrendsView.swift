//
//  CityPopulationTrendsView.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/03/30.
//

import SwiftUI
import Charts

struct CityPopulationTrendsView: View {
    let populationTrendData: [PopulationTrendsLineData]
    @State private var minYearXValue: Int = 0
    @State private var maxYearXValue: Int = 0
    @State private var minPopulationYValue: Int = 0
    @State private var maxPopulationYValue: Int = 0
    
    var body: some View {
        Chart(populationTrendData) { dataRow in
            LineMark(x: .value("Year", dataRow.year), y: .value("Population", dataRow.population))
        }
        .chartXScale(domain: minYearXValue...maxYearXValue)
        .chartYScale(domain: minPopulationYValue...maxPopulationYValue)
        .onAppear {
            minYearXValue = (populationTrendData.min { $0.year < $1.year }?.year ?? 0) - 1
            maxYearXValue = (populationTrendData.max { $0.year < $1.year }?.year ?? 0) + 1
            minPopulationYValue = (populationTrendData.min { $0.population < $1.population }?.population ?? 0) - 100000
            maxPopulationYValue = (populationTrendData.max {$0.population < $1.population }?.population ?? 0) + 100000
            print("minYearXValue: \(minYearXValue)")
            print("maxYearXValue: \(maxYearXValue)")
        }
    }
}

