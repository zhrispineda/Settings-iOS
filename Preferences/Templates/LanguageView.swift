//
//  LanguageView.swift
//  Preferences
//
//  Settings > Apps > [App]
//

import SwiftUI

struct LanguageView: View {
    // Variables
    let table = "PSSystemPolicy"
    
    var body: some View {
        Section {
            SettingsLink(color: .blue, icon: "globe", id: "LANGUAGE".localize(table: table), status: "English") {}
        } header: {
            Text("PREFERRED_LANGUAGE", tableName: table)
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
