//
//  LanguagesSettingView.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/04/21.
//

import SwiftUI

struct LanguagesSettingView: View {
    var body: some View {
        List(Languages.allCases, id: \.self) {_ in
            
        }
    }
}

enum Languages: String, Hashable, CaseIterable {
    case japanese = "日本語"
    case english = "English"
}

#Preview {
    LanguagesSettingView()
}
