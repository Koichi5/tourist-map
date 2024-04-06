//
//  SplashScreenView.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/03/26.
//

import SwiftUI

struct SplashScreenView: View {
    @Environment(AppState.self) var appState
    
    var body: some View {
        VStack {
            Text("Tourist Map")
                .font(.extraLargeTitle2)
                .fontWeight(.bold)
            Text("Let't see japanese sightseeing spots")
                .font(.system(size: 18))
                .fontWeight(.bold)
                .padding(.top, 30)
                .padding(.bottom, 30)
            
            
            Button("Start map") {
                appState.startMap()
            }
            .accessibilityElement()
            
        }
        .offset(y: 100)
        .frame(maxWidth: 600, maxHeight: 440, alignment: .center)
        .background {
            Image("Home")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .offset(y: -110)
        }
    }
}

#Preview {
    SplashScreenView()
}
