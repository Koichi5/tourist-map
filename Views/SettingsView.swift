//
//  SettingView.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/04/21.
//

import SwiftUI

struct SettingsView: View {
    @State private var selectedSettingsMenu: SettingsMenu? = .privacyPolicy
    @Environment(\.dismissWindow) private var dismissWindow

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
            case .termsOfService:
                TermsOfServiceView()
            case nil:
                Text("データの読み込みに失敗しました")
            }
        }
        .ornament(attachmentAnchor: .scene(.bottom)) {
            Button {
                dismissWindow(id: ViewIDs.settingsView)
            } label: {
                Image(systemName: "xmark")
                Text("閉じる")
            }
        }
    }
}

enum SettingsMenu: String, Hashable, CaseIterable {
    case privacyPolicy = "プライバシーポリシー"
    case termsOfService = "利用規約"
}
