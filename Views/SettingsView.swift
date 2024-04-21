//
//  SettingView.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/04/21.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var localizationManager = LocalizationManager.shared
    @State private var selectedSettingsMenu: SettingsMenu? = .languages

    var body: some View {
        NavigationSplitView {
            List(SettingsMenu.allCases, id: \.self, selection: $selectedSettingsMenu) { settingMenu in
                NavigationLink(settingMenu.rawValue, value: settingMenu)
            }
        } detail: {
            switch selectedSettingsMenu {
            case .languages:
                LanguagesSettingView()
            case .privacyPolicy:
                PrivacyPolicyView()
            case nil:
                Text("データの読み込みに失敗しました")
            }
        }
        // ユーザーに言語を選択させるUIを提供
        Picker("Select Language", selection: $localizationManager.locale) {
            Text("English").tag(Locale(identifier: "en"))
            Text("Japanese").tag(Locale(identifier: "ja"))
            // その他のサポートされる言語
        }
        .pickerStyle(SegmentedPickerStyle())
        .onChange(of: localizationManager.locale) { _, newLocale in
            localizationManager.setLocale(newLocale: newLocale)
        }
    }
}

enum SettingsMenu: String, Hashable, CaseIterable {
    case languages = "言語設定"
    case privacyPolicy = "プライバシーポリシー"
}
