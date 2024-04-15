//
//  ImageViewer.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/04/13.
//

import SwiftUI

struct PhotoView: View {
    var photoReference: String
    @ObservedObject var viewModel = PlacePhotoManager()
    
    var body: some View {
        if let url = viewModel.makeImageUrl(photoReference: photoReference) {
            AsyncImage(url: url) { image in
                image
                    .resizable()
            } placeholder: {
                ProgressView()
            }
            .aspectRatio(contentMode: .fit)
            .clipped()
        } else {
            Text("Invalid image URL")
        }
    }
}

