//
//  TouristSpotDetailView.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/03/31.
//

import SwiftUI

struct TouristSpotDetailView: View {
    @Environment(\.openWindow) internal var openWindow
    let touristSpot: TouristSpot
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ScrollView {
                VStack {
                    PhotoListView(touristSpot: touristSpot)
                    Text(touristSpot.description)
                        .padding()
                }
            }
            Button {
//                openWindow(id: ViewID.lookAroundView, value: touristSpot)
            } label: {
                Image(systemName: "map")
            }
            .padding()
        }
            .navigationTitle(touristSpot.name ?? "")
    }
    
    func calculateFontSize(forWidth width: CGFloat) -> CGFloat {
        let baseWidth: CGFloat = 600
        let baseFontSize: CGFloat = 20
        let scaleFactor = width / baseWidth
        return baseFontSize * scaleFactor
    }
}
