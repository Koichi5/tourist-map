//
//  CityInfoManageer.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/04/10.
//

import Foundation

class CityInfoManager: Observable {
    static let shared = CityInfoManager()

    private let apiKey = ProcessInfo.processInfo.environment["RESAS_API_KEY"]
    private let session = URLSession.shared

    private init() {}

    func fetchCityInfo(
//        with parameters: [String: String],
        completion: @escaping (Result<String, Error>) -> Void) {
        /// 人口構成API https://opendata.resas-portal.go.jp/docs/api/v1/population/composition/perYear.html
            let components = URLComponents(string: "https://opendata.resas-portal.go.jp/api/v1/population/composition/perYear?cityCode=11362&prefCode=11")!

        guard let url = components.url else {
            completion(.failure(NSError(domain: "InvalidURL", code: -1, userInfo: nil)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "X-API-KEY")

        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NSError(domain: "InvalidResponse", code: -1, userInfo: nil)))
                return
            }

            if let mimeType = httpResponse.mimeType, mimeType == "application/json",
               let data = data,
               let dataString = String(data: data, encoding: .utf8) {
                completion(.success(dataString))
                print("data: \(data)")
            } else {
                completion(.failure(NSError(domain: "InvalidData", code: -1, userInfo: nil)))
            }
        }

        task.resume()
    }
}
