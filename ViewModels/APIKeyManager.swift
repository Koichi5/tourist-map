//
//  APIKeyManager.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/04/26.
//

import Foundation

class APIKeyManager {
    static let shared = APIKeyManager()
    
    private init() {} // プライベートイニシャライザ

    func apiKey(for service: String) -> String? {
        guard let keys = Bundle.main.infoDictionary?["APIKeys"] as? [String: Any],
              let key = keys[service] as? String else {
            return nil
        }
        return key
    }
}
