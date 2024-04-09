//
//  LookAroundView.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/03/26.
//

import SwiftUI
import MapKit

struct LookAroundView: View {
    let touristSpot: TouristSpot
    @State private var position: MapCameraPosition = .region(.init(
        center: .init(latitude: 35.681236, longitude: 139.767125),
        span: .init(latitudeDelta: 0.005, longitudeDelta: 0.005)
    ))
    @State private var lookAroundScene: MKLookAroundScene?
    @State private var isLookAroundPreviewShown = false
    
    var body: some View {
        MapReader { mapProxy in
            Map(position: $position)
                .onTapGesture { location in
                    guard let selectedLocation = mapProxy.convert(location, from: .local) else { return }
                    requestLookAroundScene(selectedLocation: selectedLocation)
                    isLookAroundPreviewShown = true
                }
        }
        .lookAroundViewer(
            isPresented: $isLookAroundPreviewShown,
            scene: $lookAroundScene
        )
        .onAppear {
            position = .region(.init(
                center: .init(latitude: CLLocationDegrees(touristSpot.latitude), longitude: CLLocationDegrees(touristSpot.longitude)),
                span: .init(latitudeDelta: 0.005, longitudeDelta: 0.005)
            ))
        }
    }
    
    func requestLookAroundScene(selectedLocation: CLLocationCoordinate2D) {
        Task {
            let request = MKLookAroundSceneRequest(coordinate: selectedLocation)
            lookAroundScene = try? await request.scene
        }
    }
}
