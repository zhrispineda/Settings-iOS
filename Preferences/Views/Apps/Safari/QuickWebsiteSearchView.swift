//
//  QuickWebsiteSearchView.swift
//  Preferences
//
//  Settings > Safari > Quick Website Search
//

import SwiftUI

struct QuickWebsiteSearchView: View {
    // Variables
    @State private var quickWebsiteSearchEnabled = true
    
    var body: some View {
        CustomList(title: "Quick Website Search") {
            Section {
                Toggle("Quick Website Search", isOn: $quickWebsiteSearchEnabled)
            } footer: {
                Text("Use the Smart Search Field to search within websites by typing the website name as part of your search.\n\nFor example, type “wiki einstein“ to show search results for “einstein“.")
            }
            
            Section {} footer: {
                Text("Quick website search shortcuts are added automatically by searching within a website.")
            }
        }
        .toolbar {
            EditButton()
                .disabled(true)
        }
    }
}

#Preview {
    NavigationStack {
        QuickWebsiteSearchView()
    }
}
