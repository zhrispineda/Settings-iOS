//
//  SiriAppClipsView.swift
//  Preferences
//
//  Settings > Siri > App Clips
//

import SwiftUI

struct SiriAppClipsView: View {
    // Variables
    @State private var learnAppClipsEnabled = true
    @State private var showSearchEnabled = true
    @State private var suggestAppClipsEnabled = true
    let table = "AssistantSettings"
    
    var body: some View {
        CustomList(title: "APP_CLIPS".localize(table: table), topPadding: true) {
            Section {
                Toggle("APP_CLIPS_LEARN_FROM_APP_CLIPS".localize(table: table), isOn: $learnAppClipsEnabled)
            } header: {
                Text("APP_CLIPS_IN_APP_CLIPS_HEADER", tableName: table)
            } footer: {
                Text("APP_CLIPS_IN_APP_CLIPS_FOOTER", tableName: table)
            }
            
            Section {
                Toggle("APP_CLIPS_SHOW_IN_SEARCH".localize(table: table), isOn: $showSearchEnabled)
                Toggle("APP_CLIPS_SUGGEST_APP_CLIPS".localize(table: table), isOn: $suggestAppClipsEnabled)
            } header: {
                Text("SIRIANDSEARCH_PERAPP_ONHOMESCREEN_HEADER", tableName: table)
            } footer: {
                Text("APP_CLIPS_IN_SEARCH_FOOTER", tableName: table)
            }
        }
    }
}

#Preview {
    NavigationStack {
        SiriAppClipsView()
    }
}
