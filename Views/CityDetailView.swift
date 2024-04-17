//
//  CityDetailView.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/03/29.
//

import SwiftUI

struct CityDetailView: View {
    let cityInfoDataModel: CityInfoDataModel
    @Environment(AppState.self) private var appState
    @ObservedObject var populationViewModel = PopulationManager()
    @State private var selectedCityDetailInfo: CityDetailInfoMenu? = .basicInfo
    
    var body: some View {
        NavigationSplitView {
            List(CityDetailInfoMenu.allCases, id: \.self, selection: $selectedCityDetailInfo) { info in
                HStack {
                    NavigationLink(info.rawValue, value: info)
                    Spacer()
                }
                .contentShape(Rectangle())
            }
            .navigationSplitViewColumnWidth(min: 100, ideal: 150, max: 200)
        } detail: {
            switch selectedCityDetailInfo {
            case .basicInfo:
                CityBasicInfoView(prefecture: cityInfoDataModel.prefecture)
            case .populationTrends:
                CityPopulationTrendsView(populationTrendData: populationViewModel.populationTrendsLineData)
            case .touristSpot:
                CityTouristSpotsView(touristSpots: cityInfoDataModel.touristSpots)
            case .inductory:
                IndustryDataView()
            case nil:
                Text("何も表示されない")
            }
        }
        .onAppear {
            populationViewModel.fetchPopulationData(prefCode: 13) { result in
                print(result ?? "")
            }
        }
    }
}
