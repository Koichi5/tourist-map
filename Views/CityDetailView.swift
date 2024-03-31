//
//  CityDetailView.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/03/29.
//

import SwiftUI

struct CityDetailView: View {
    let cityInfo: CityInfo
    @State private var selectedCityDetailInfo: CityDetailInfoMenu?
    
    var body: some View {
        NavigationSplitView {
            List(CityDetailInfoMenu.allCases, id: \.self, selection: $selectedCityDetailInfo) { info in
                NavigationLink(info.rawValue, value: info)
            }
            .navigationSplitViewColumnWidth(min: 100, ideal: 150, max: 200)
        } detail: {
            switch selectedCityDetailInfo {
            case .basicInfo:
                CityBasicInfoView(basicInfo: cityInfo.basicInfo)
            case .populationTrends:
                CityPopulationTrendsView(populationTrendData: cityInfo.populationTrendData)
            case .touristSpot:
                CityTouristSpotsView(touristSpots: cityInfo.touristSpots)
            case .inductory:
                Text("産業")
            case nil:
                Text("何も表示されない")
            }
        }
    }
}
