//
//  SplashScreenView.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/03/26.
//

import SwiftUI

struct SplashScreenView: View {
    @Environment(AppState.self) var appState
    @ObservedObject var viewModel = PlacePhotoManager()
    
    var body: some View {
        VStack {
            Text("Tourist Map")
                .font(.extraLargeTitle2)
                .fontWeight(.bold)
                .padding(.vertical)
            Text("Let't see japanese sightseeing spots")
                .font(.system(size: 18))
                .fontWeight(.bold)
                .padding(.bottom)
            
            Button("Start map") {
                appState.startMap()
            }
            .accessibilityElement()
        }
        .offset(y: 130)
        .frame(maxWidth: 500, maxHeight: 470, alignment: .center)
        .background {
            Image("home")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .offset(y: -100)
        }
    }
}
