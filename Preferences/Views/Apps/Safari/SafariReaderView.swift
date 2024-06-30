//
//  SafariReaderView.swift
//  Preferences
//
//  Settings > Safari > Reader
//

import SwiftUI

struct SafariReaderView: View {
    // Variables
    @State private var allWebsitesEnabled = false
    
    var body: some View {
        CustomList(title: "Reader") {
            Section {
                Toggle("All Websites", isOn: $allWebsitesEnabled)
            } header: {
                Text("Automatically Use Reader On")
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
        SafariReaderView()
    }
}
