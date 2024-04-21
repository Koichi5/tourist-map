//
//  PlacePhotoManager.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/04/12.
//

import SwiftUI
import Combine

class PlacePhotoManager: ObservableObject {
    @Published var photoReferences: [String] = []
    @Published var landscapePhotoReferences: [String] = []
    var cancellables: Set<AnyCancellable> = []
    private let apiKey = ProcessInfo.processInfo.environment["GOOGLE_PLACE_API_KEY"]

    func fetchPhotoReferences(placeId: String) {
        print("----- fetch images fired -----")
        if (apiKey != nil) {
            guard let url = URL(string: "https://maps.googleapis.com/maps/api/place/details/json?placeid=\(placeId)&key=\(apiKey!)") else {
                print("Invalid URL")
                return
            }
            URLSession.shared.dataTaskPublisher(for: url)
                .map { $0.data }
                .decode(type: PlaceDetailsResponse.self, decoder: JSONDecoder())
                .map { response in
                    return response.result.photos?.map { $0.photoReference } ?? []
                }
                .replaceError(with: [])
                .receive(on: DispatchQueue.main)
                .assign(to: \.photoReferences, on: self)
                .store(in: &cancellables)
        }
    }
    
    func fetchLandscapePhotoReferences(placeId: String) {
        print("----- fetch landscape images fired -----")
        if let apiKey = apiKey, let url = URL(string: "https://maps.googleapis.com/maps/api/place/details/json?placeid=\(placeId)&key=\(apiKey)") {
            URLSession.shared.dataTaskPublisher(for: url)
                .map { $0.data }
                .decode(type: PlaceDetailsResponse.self, decoder: JSONDecoder())
                .map { response in
                    response.result.photos?.compactMap { photo -> String? in
                        return (photo.width > photo.height) ? photo.photoReference : nil
                    } ?? []
                }
                .replaceError(with: [])
                .receive(on: DispatchQueue.main)
                .assign(to: \.landscapePhotoReferences, on: self)
                .store(in: &cancellables)
        } else {
            print("Invalid API key or URL")
        }
    }

    
    func makeImageUrl(photoReference: String, maxWidth: Int = 1200) -> URL? {
        print("----- make image url fired -----")
        if (apiKey != nil) {
            let urlString = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=\(maxWidth)&photo_reference=\(photoReference)&key=\(apiKey!)"
            return URL(string: urlString)
        }
        return nil
    }
}
