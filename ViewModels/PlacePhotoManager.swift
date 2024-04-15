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
    var cancellables: Set<AnyCancellable> = []
    private let apiKey = ProcessInfo.processInfo.environment["GOOGLE_PLACE_API_KEY"]

    func fetchImages(placeId: String) {
        if (apiKey != nil) {
            guard let url = URL(string: "https://maps.googleapis.com/maps/api/place/details/json?placeid=\(placeId)&key=\(apiKey!)") else {
                print("Invalid URL")
                return
            }
            print("url: \(url)")
            URLSession.shared.dataTaskPublisher(for: url)
                .map { $0.data }
                .decode(type: PlaceDetailsResponse.self, decoder: JSONDecoder())
                .map { response in
                    print("response.result.photos?.map { $0.photoReference } ?? []: \(response.result.photos?.map { $0.photoReference } ?? [])")
                    return response.result.photos?.map { $0.photoReference } ?? []
                }
                .replaceError(with: [])
                .receive(on: DispatchQueue.main)
                .assign(to: \.photoReferences, on: self)
                .store(in: &cancellables)
        }
    }
    
    func makeImageUrl(photoReference: String, maxWidth: Int = 400) -> URL? {
        if (apiKey != nil) {
            let urlString = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=\(maxWidth)&photo_reference=\(photoReference)&key=\(apiKey!)"
            print(urlString)
            return URL(string: urlString)
        }
        return nil
    }
}
