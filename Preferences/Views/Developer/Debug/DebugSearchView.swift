//
//  DebugSearchView.swift
//  Preferences
//
//  Settings > Debug > Search
//

import SwiftUI

struct DebugSearchView: View {
    @State private var linkIndexNextLaunch = false
    @State private var manifestIndexNextLaunch = false
    @State private var alwaysIndexOnLaunch = false
    @State private var neverIndex = false
    @State private var forceQueryError = false
    
    var body: some View {
        CustomList(title: "Search", topPadding: true) {
            Section("Link Indexer") {
                LabeledContent("Last Index Date", value: "None")
                Toggle("Needs Index On Next Launch", isOn: $linkIndexNextLaunch)
            }
            
            Section("Manifest Indexer") {
                LabeledContent("Last Index Date", value: "None")
                Toggle("Needs Index On Next Launch", isOn: $manifestIndexNextLaunch)
                Toggle("Always Index On Launch", isOn: $alwaysIndexOnLaunch)
                Toggle("Never Index", isOn: $neverIndex)
            }
            
            Section("Query") {
                Toggle("Force Throw Querying Error", isOn: $forceQueryError)
            }
        }
    }
}

#Preview {
    NavigationStack {
        DebugSearchView()
    }
}
