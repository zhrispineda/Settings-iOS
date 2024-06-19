//
//  LanguageView.swift
//  Preferences
//
//  Settings > Apps > [App]
//

import SwiftUI

struct LanguageView: View {
    var body: some View {
        Section {
            SettingsLink(color: .blue, icon: "globe", id: "Language", status: "English") {}
        } header: {
            Text("Preferred Language")
        }
    }
}

#Preview {
    NavigationStack {
        List {
            LanguageView()
        }
    }
}
