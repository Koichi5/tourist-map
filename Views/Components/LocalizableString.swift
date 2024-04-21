//
//  LocalizableString.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/04/21.
//

import SwiftUI

struct LocalizableString: View {
    @ObservedObject var localizationManager = LocalizationManager.shared
    var key: String
    
    var body: some View {
        Text(LocalizedStringKey(key), bundle: .main, comment: "")
            .environment(\.locale, localizationManager.locale)
    }
}
