//
//  SettingView.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/04/21.
//

import SwiftUI

struct SettingsView: View {
    @State private var selectedSettingsMenu: SettingsMenu? = .privacyPolicy

    var body: some View {
        NavigationSplitView {
            List(SettingsMenu.allCases, id: \.self, selection: $selectedSettingsMenu) { settingMenu in
                NavigationLink(settingMenu.rawValue, value: settingMenu)
            }
            .navigationTitle("設定")
        } detail: {
            switch selectedSettingsMenu {
            case .privacyPolicy:
                PrivacyPolicyView()
            case nil:
                Text("データの読み込みに失敗しました")
            }
        }
    }
}

enum SettingsMenu: String, Hashable, CaseIterable {
    case privacyPolicy = "プライバシーポリシー"
}
