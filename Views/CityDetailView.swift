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
    @Environment(\.dismissWindow) private var dismissWindow
    
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
                CityPopulationTrendsView(populationTrendData: populationViewModel.populationTrendsLineData, prefecture: cityInfoDataModel.prefecture)
            case .touristSpot:
                CityTouristSpotsView(touristSpots: cityInfoDataModel.touristSpots)
            case .inductory:
                IndustryDataView(
                    cityInfoDataModel: cityInfoDataModel, prefecture: cityInfoDataModel.prefecture
                )
            case nil:
                Text("データの読み込みに失敗しました")
            }
        }
        .ornament(attachmentAnchor: .scene(.bottom)) {
            Button {
                dismissWindow(id: ViewIDs.cityView)
            } label: {
                Image(systemName: "xmark")
                Text("閉じる")
            }
        }
        .onAppear {
            populationViewModel.fetchPopulationData(prefCode: cityInfoDataModel.prefecture?.code ?? -1) { result in
                debugPrint(result ?? "")
            }
        }
    }
}
