//
//  CityIndustryView.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/03/31.
//

import SwiftUI

struct CityIndustryView: View {
    let primaryCityIndustryData: CityIndustryData
    var secondaryAndTertiaryCityIndustryData: CityIndustryData
    @State private var showSecondaryData: Bool = false
    var body: some View {
        VStack(alignment: .leading) {
            Image(showSecondaryData ? secondaryAndTertiaryCityIndustryData.imageName : primaryCityIndustryData.imageName)
                .resizable()
                .scaledToFit()
        }
        .navigationTitle(showSecondaryData ? "第二、三次産業" : "第一次産業")
    }
}
