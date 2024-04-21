//
//  IndustryDataView.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/04/11.
//

import SwiftUI

struct IndustryDataView: View {
    let cityInfoDataModel: CityInfoDataModel
    let prefecture: Prefecture?
    @ObservedObject var dataManager = IndustryDataManager()

    var body: some View {
        if(dataManager.industryData.isEmpty) {
            VStack {
                HStack {
                    Text("産業の情報を取得できませんでした。\n再度お試しください。")
                }
            }
        }
        List(dataManager.industryData, id: \.simcCode) { item in
            VStack(alignment: .leading) {
                Text(item.simcName).font(.headline)
                Text("特化係数: \(item.value)").font(.subheadline)
            }
        }
        .onAppear {
            dataManager.fetchIndustryData(prefCode: prefecture?.code ?? -1)
        }
        .navigationTitle("産業特化係数")
    }
}
