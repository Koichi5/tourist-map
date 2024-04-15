//
//  PhotoListView.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/04/13.
//

import SwiftUI

struct PhotoListView: View {
    @ObservedObject var imageManager = PlacePhotoManager()
    let touristSpot: TouristSpot
    
    var body: some View {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(imageManager.photoReferences, id: \.self) { photoRef in
                        PhotoView(
                            photoReference: photoRef
                        )
                    }
                }
            }
        .onAppear {
            imageManager.fetchImages(placeId: touristSpot.placeId ?? "")
        }
    }
}
