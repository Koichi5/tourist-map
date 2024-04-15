//
//  IndustryDataView.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/04/11.
//

import SwiftUI

struct IndustryDataView: View {
    @ObservedObject var dataManager = IndustryDataManager()

    var body: some View {
        List(dataManager.industryData, id: \.simcCode) { item in
            VStack(alignment: .leading) {
                Text(item.simcName).font(.headline)
                Text("特化係数: \(item.value)").font(.subheadline)
            }
        }
        .onAppear {
            dataManager.fetchIndustryData(prefCode: 11)
        }
        .navigationTitle("産業特化係数")
    }
}
