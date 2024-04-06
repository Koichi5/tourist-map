//
//  ContentView.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/03/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    
    @Environment(AppState.self) private var appState
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false
    
    var body: some View {
        @Bindable var appState = appState
        switch appState.phase {
        case .startingUp, .waitingToStart:
            Spacer()
            SplashScreenView()
                .onAppear {
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
                        return
                    }
                    
                    windowScene.requestGeometryUpdate(.Vision(resizingRestrictions: UIWindowScene.ResizingRestrictions.none))
                }
                .glassBackgroundEffect()
        case .loadingAssets:
            ModelLoadingView()
        case .map, .city, .cityBasicInfo, .cityPopulationTrends, .cityTouristSpots, .cityIndustry:
            Spacer()
            MapView()
        }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
