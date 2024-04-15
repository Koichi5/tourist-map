//
//  TouristMapApp.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/03/25.
//

import SwiftUI
import SwiftData

@main
@MainActor
struct TouristMapApp: App {
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissWindow) var dismissWindow
    
    @State private var appState = AppState()
    @State private var immersionStyle: ImmersionStyle = .mixed
    var body: some Scene {
        WindowGroup(id: ViewID.touristMap) {
            SwiftDataSampleView()
                .modelContainer(for: [CityInfoDataModel.self, TouristSpotDataModel.self])
//            ContentView()
//                .environment(appState)
//                .onChange(of: appState.phase.isImmersed) { _, showMRView in
//                    if showMRView {
//                        Task {
//                            appState.isImmersiveViewShown = true
//                            await openImmersiveSpace(id: "ImmersiveSpace")
//                            dismissWindow(id: "TouristMap")
//                        }
//                    }
//                }
        }
        .windowStyle(.plain)
        .windowResizability(.contentSize)
        
        WindowGroup(id: ViewID.cityView, for: String.self) { value in
            CityView(cityName: value.wrappedValue!)
                .environment(appState)
        }
        .defaultSize(CGSize(width: 600, height: 400))
        
//        WindowGroup(id: ViewID.lookAroundView, for: TouristSpot.self) { value in
//            LookAroundView(touristSpot: value.wrappedValue!)
//        }
        
        ImmersiveSpace(id: ViewID.immersive) {
            ImmersiveView()
                .environment(appState)
        }
        .immersionStyle(selection: .constant(.full), in: .full)
    }
}


struct ViewID {
    static let cityView = "CityViewId"
    static let touristMap = "TouristMapId"
    static let lookAroundView = "LookAroundViweId"
    static let immersive = "ImmersiveSpaceId"
}
