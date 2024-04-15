//
//  PrefectureManager.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/04/10.
//

import Foundation

class PrefectureManager: ObservableObject {
    @Published var prefectures: [PrefectureWithCode] = []
    
    static let shared = PrefectureManager()
    private let apiKey = ProcessInfo.processInfo.environment["RESAS_API_KEY"]
    private let session = URLSession.shared
    
    private init() {}
    
    func fetchPrefectures() {
        let urlString = "https://opendata.resas-portal.go.jp/api/v1/prefectures"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "X-API-KEY")
        
        // URLセッションでリクエストを送信
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else { return }
            
            // JSONデータをデコードして構造体のインスタンスに変換
            do {
                let response = try JSONDecoder().decode(PrefecturesResponse.self, from: data)
                // デコードしたデータを使用（例：コンソールに出力）
                self.prefectures = response.result
            } catch {
                print(error)
            }
        }.resume()
    }

}
