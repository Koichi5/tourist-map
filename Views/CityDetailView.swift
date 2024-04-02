//
//  CityDetailView.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/03/29.
//

import SwiftUI

struct CityDetailView: View {
    let cityInfo: CityInfo
    @Environment(AppState.self) private var appState
    @State private var selectedCityDetailInfo: CityDetailInfoMenu? = .basicInfo
    
    var body: some View {
        NavigationSplitView {
            List(CityDetailInfoMenu.allCases, id: \.self, selection: $selectedCityDetailInfo) { info in
                HStack {
                    NavigationLink(info.rawValue, value: info)
                    Spacer()
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    switch info {
                    case .basicInfo:
                        appState.cityBasicInfo()
                    case .populationTrends:
                        appState.cityPopulationTrends()
                    case .touristSpot:
                        appState.cityTouristSpots()
                    case .inductory:
                        appState.cityIndustry()
                    }
                }
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
                CityIndustryView(primaryCityIndustryData: cityInfo.cityIndustryDataSet.primary, secondaryAndTertiaryCityIndustryData: cityInfo.cityIndustryDataSet.secondaryAndTertiary)
            case nil:
                Text("何も表示されない")
            }
        }
    }
}
