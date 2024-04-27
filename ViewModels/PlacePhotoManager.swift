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
    
    func fetchPhotoReferences(placeId: String) {
        debugPrint("----- fetch images fired -----")
        guard let googlePlacesKey = APIKeyManager.shared.apiKey(for: "GOOGLE_PLACE_API_KEY") else {
            debugPrint("API Key not found")
            return
        }
        let urlString = "https://maps.googleapis.com/maps/api/place/details/json?placeid=\(placeId)&fields=photos&key=\(googlePlacesKey)"
        guard let url = URL(string: urlString) else {
            debugPrint("Invalid URL")
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
    
    func fetchLandscapePhotoReferences(placeId: String) {
        debugPrint("----- fetch landscape images fired -----")
        guard let googlePlacesKey = APIKeyManager.shared.apiKey(for: "GOOGLE_PLACE_API_KEY") else {
            debugPrint("API Key not found")
            return
        }
        let urlString = "https://maps.googleapis.com/maps/api/place/details/json?placeid=\(placeId)&fields=photos&key=\(googlePlacesKey)"
        guard let url = URL(string: urlString) else {
            debugPrint("Invalid URL")
            return
        }
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
    }
        
    func fetchFirstPhotoReference(placeId: String, completion: @escaping (String?) -> Void) {
        debugPrint("----- fetchFirstPhotoReference fired -----")
        guard let googlePlacesKey = APIKeyManager.shared.apiKey(for: "GOOGLE_PLACE_API_KEY") else {
            debugPrint("API Key not found")
            completion(nil)
            return
        }
        let urlString = "https://maps.googleapis.com/maps/api/place/details/json?placeid=\(placeId)&fields=photos&key=\(googlePlacesKey)"
        guard let url = URL(string: urlString) else {
            debugPrint("Invalid URL")
            return
        }
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: PlaceDetailsResponse.self, decoder: JSONDecoder())
            .map { response -> String? in
                return response.result.photos?.first?.photoReference
            }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: completion)
            .store(in: &cancellables)
    }
    
    func makeImageUrl(photoReference: String, maxWidth: Int = 1200) -> URL? {
        debugPrint("----- make image url fired -----")
        guard let googlePlacesKey = APIKeyManager.shared.apiKey(for: "GOOGLE_PLACE_API_KEY") else {
            debugPrint("API Key not found")
            return nil
        }
        let urlString = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=\(maxWidth)&photo_reference=\(photoReference)&key=\(googlePlacesKey)"
        guard let url = URL(string: urlString) else {
            debugPrint("Invalid URL")
            return nil
        }
        return url
    }
    
    func fetchImageUrlFromPlaceId(placeId: String, completion: @escaping (URL?) -> Void) {
        debugPrint("----- fetchImageUrlFromPlaceId fired -----")
        fetchFirstPhotoReference(placeId: placeId) { [weak self] photoReference in
            guard let photoReference = photoReference else {
                debugPrint("No photo reference found.")
                completion(nil)
                return
            }
            let url = self?.makeImageUrl(photoReference: photoReference)
            completion(url)
        }
    }
}
