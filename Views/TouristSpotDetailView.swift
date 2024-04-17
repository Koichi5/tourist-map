//
//  TouristSpotDetailView.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/03/31.
//

import SwiftUI

struct TouristSpotDetailView: View {
    @Environment(\.openWindow) internal var openWindow
    let touristSpot: TouristSpotDataModel
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ScrollView {
                VStack {
                    PhotoListView(touristSpot: touristSpot)
                    Text(touristSpot.spotDescription ?? "")
                        .padding()
                }
            }
            Button {
                openWindow(id: ViewID.lookAroundView, value: touristSpot)
            } label: {
                Image(systemName: "map")
            }
            .padding()
        }
            .navigationTitle(touristSpot.name ?? "")
    }
}
