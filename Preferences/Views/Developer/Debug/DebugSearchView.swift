//
//  DebugSearchView.swift
//  Preferences
//
//  Settings > Debug > Search
//

import SwiftUI

struct DebugSearchView: View {
    @State private var indexing = false
    
    var body: some View {
        CustomList(title: "Search") {
            Section("Quick Actions") {
                Button("Force Reindex") {}
            }
            
            Section("Index State") {
                LabeledContent("Indexing In Progress", value: "No")
            }
        }
    }
}

#Preview {
    NavigationStack {
        DebugSearchView()
    }
}
