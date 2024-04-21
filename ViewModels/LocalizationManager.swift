//
//  LocalizationManager.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/04/21.
//

import Foundation

class LocalizationManager: ObservableObject {
    static let shared = LocalizationManager()
    @Published var locale: Locale
    
    init(locale: Locale = .current) {
        self.locale = locale
    }
    
    func setLocale(newLocale: Locale) {
        locale = newLocale
        UserDefaults.standard.set(newLocale.identifier, forKey: "selectedLanguage")
    }
}
