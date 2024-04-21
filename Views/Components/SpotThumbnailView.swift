//
//  SpotThumbnailView.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/04/21.
//

import SwiftUI
import Combine

struct SpotThumbnailView: View {
    @ObservedObject var photoManager: PlacePhotoManager
    let placeId: String
    let adjustedWidth: Double
    @State private var imageUrl: URL?

    init(placeId: String, adjustedWidth: Double) {
        self.placeId = placeId
        self.adjustedWidth = adjustedWidth
        self.photoManager = PlacePhotoManager()
    }

    var body: some View {
        VStack {
            if let imageUrl = imageUrl {
                AsyncImage(url: imageUrl) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: adjustedWidth, height: adjustedWidth * 2/3)
                            .cornerRadius(20)
                            .clipped()
                    case .failure:
                        Text("画像を読み込めませんでした。")
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                Text("画像がありません") // URLがnilの場合の表示
                    .foregroundColor(.gray)
            }
        }
        .onAppear {
            photoManager.fetchImageUrlFromPlaceId(placeId: placeId) { url in
                self.imageUrl = url
            }
        }
    }
}
