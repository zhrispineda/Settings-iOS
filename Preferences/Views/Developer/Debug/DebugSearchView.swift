//
//  DebugSearchView.swift
//  Preferences
//
//  Settings > Debug > Search
//

import SwiftUI

struct DebugSearchView: View {
    @AppStorage("LinkIndexNextLaunch") private var linkIndexNextLaunch = false
    @AppStorage("ManifestIndexNextLaunch") private var manifestIndexNextLaunch = false
    @AppStorage("AlwaysIndexLaunch") private var alwaysIndexOnLaunch = false
    @AppStorage("NeverIndex") private var neverIndex = false
    @AppStorage("ForceQueryError") private var forceQueryError = false
    
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
