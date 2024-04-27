//
//  PopulationManager.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/04/10.
//

import Foundation

class PopulationManager: ObservableObject {
    @Published var populationData: [PopulationData] = []
    @Published var populationTrendsLineData: [PopulationTrendsLineData] = []
        
    func fetchPopulationData(prefCode: Int, completion: @escaping (PopulationResult?) -> Void) {
        if (prefCode == -1) {
            return
        }
        let urlString = "https://opendata.resas-portal.go.jp/api/v1/population/composition/perYear?cityCode=-&prefCode=\(prefCode)"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        guard let resasKey = APIKeyManager.shared.apiKey(for: "RESAS_API_KEY") else {
            debugPrint("API Key not found")
            return
        }
        var request = URLRequest(url: url)
        request.addValue(resasKey, forHTTPHeaderField: "X-API-KEY")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(PopulationResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(decodedResponse.result)
                    self.populationData = decodedResponse.result.data
                    debugPrint("data: \(data)")
                    debugPrint("decodedResponse: \(decodedResponse)")
                    if let totalPopulationData = decodedResponse.result.data.first(where: { $0.label == "総人口" }) {
                        debugPrint("totalPopulationData: \(totalPopulationData)")
                        for yearlyData in totalPopulationData.data {
                            self.populationTrendsLineData.append(.init(year: yearlyData.year, population: yearlyData.value))
                        }
                    }
                    debugPrint("populationTrendsLineData: \(self.populationTrendsLineData)")
                }
            } catch {
                debugPrint("Decoding failed: \(error)")
                completion(nil)
            }
        }
        
        task.resume()
    }

}
