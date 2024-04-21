//
//  CityTouristSpotsView.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/03/31.
//

import SwiftUI

struct CityTouristSpotsView: View {
    let touristSpots: [TouristSpotDataModel]
    @State private var path: [TouristSpotDataModel] = []
    @ObservedObject var imageManager = PlacePhotoManager()
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                GeometryReader { geometry in
                    createGrid(geometry: geometry)
                }
            }
            .padding(.horizontal)
            .navigationTitle("観光地")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    private func createGrid(geometry: GeometryProxy) -> some View {
        let width = geometry.size.width
        let spacing: CGFloat = 20
        let maxColumns = 3
        let numberOfColumns = min(max(Int(width / 200), 2), maxColumns)
        let columns = Array(repeating: GridItem(.flexible(), spacing: spacing), count: numberOfColumns)
        
        let totalSpacing = spacing * CGFloat(numberOfColumns - 1)
        let adjustedWidth = (width - totalSpacing) / CGFloat(numberOfColumns)
        return LazyVGrid(columns: columns, spacing: spacing) {
            ForEach(touristSpots, id: \.name) { spot in
                VStack(alignment: .leading) {
                    if (spot.thumbnailImageUrl != "") {
                        AsyncImage(url: URL(string: spot.thumbnailImageUrl!)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: adjustedWidth, height: adjustedWidth * 2/3)
                                .cornerRadius(20)
                                .clipped()
                        } placeholder: {
                            ProgressView()
                        }
                    } else {
                        SpotThumbnailView(placeId: spot.placeId ?? "", adjustedWidth: adjustedWidth)
                    }
//                    if let url = imageManager.makeImageUrl(photoReference: imageManager.photoReferences.first ?? "") {
//                        AsyncImage(url: url) { image in
//                            image
//                                .resizable()
//                                .scaledToFill()
//                                .frame(width: adjustedWidth, height: adjustedWidth * 2/3)
//                                .cornerRadius(20)
//                                .clipped()
//                        } placeholder: {
//                            ProgressView()
//                        }
//                    }
                    Text(spot.name ?? "")
                        .lineLimit(1)
                        .padding()
                    Spacer()
                }
//                .onAppear {
//                    imageManager.fetchPhotoReferences(placeId: spot.placeId ?? "")
//                }
                .padding(.bottom, 10)
                .onTapGesture {
                    path.append(spot)
                }
                .navigationDestination(for: TouristSpotDataModel.self) { spot in
                    TouristSpotDetailView(touristSpot: spot)
                }
            }
        }
    }
}
