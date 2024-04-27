//
//  IndustryManager.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/04/11.
//

import Foundation

class IndustryDataManager: ObservableObject {
    @Published var industryData: [IndustryData] = []
    
//    private let apiKey = ProcessInfo.processInfo.environment["RESAS_API_KEY"]!

    func fetchIndustryData(prefCode: Int) {
        if(prefCode == -1) {
            return
        }
        let urlString = "https://opendata.resas-portal.go.jp/api/v1/industry/power/forIndustry?cityCode=-&year=2016&prefCode=\(prefCode)&sicCode=-"
        guard let url = URL(string: urlString) else { return }
        guard let resasKey = APIKeyManager.shared.apiKey(for: "RESAS_API_KEY") else {
            debugPrint("API Key not found")
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue(resasKey, forHTTPHeaderField: "X-API-KEY")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else { return }
            
            do {
                let decodedResponse = try JSONDecoder().decode(IndustryDataResponse.self, from: data)
                DispatchQueue.main.async {
                    self.industryData = decodedResponse.result.data.sorted { $0.value > $1.value }
                }
            } catch {
                debugPrint("Decoding error: \(error)")
            }
        }.resume()
    }
}
