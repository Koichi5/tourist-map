//
//  CityTouristSpotsView.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/03/31.
//

import SwiftUI

struct CityTouristSpotsView: View {
    let touristSpots: [TouristSpot]
    @State private var path: [TouristSpot] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                GeometryReader { geometry in
                    let width = geometry.size.width
                    let maxColumns = 3
                    let spacing: CGFloat = 20
                    let numberOfColumns = min(max(Int(width / 200), 2), maxColumns)
                    let columns = Array(repeating: GridItem(.flexible(), spacing: spacing), count: numberOfColumns)
                    
                    let totalSpacing = spacing * CGFloat(numberOfColumns - 1)
                    let adjustedWidth = (width - totalSpacing) / CGFloat(numberOfColumns)
                    
                    LazyVGrid(columns: columns, spacing: spacing) {
                        ForEach(touristSpots, id: \.name) { spot in
                            VStack(alignment: .leading) {
                                Image(spot.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(20)
                                    .frame(width: adjustedWidth, height: adjustedWidth * 2/3)
                                Text(spot.name)
                                    .lineLimit(1)
                                    .padding()
                                Spacer()
                            }
                            .padding(.bottom, 10)
                            .onTapGesture {
                                path.append(spot)
                            }
                            .navigationDestination(for: TouristSpot.self) { spot in
                                TouristSpotDetailView(touristSpot: spot)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
            .navigationTitle("観光地")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
