//
//  RequestDesktopWebsiteView.swift
//  Preferences
//
//  Settings > Safari > Request Desktop Website
//

import SwiftUI

struct RequestDesktopWebsiteView: View {
    // Variables
    @State private var allWebsitesEnabled = false
    
    var body: some View {
        CustomList(title: "Request Desktop Website") {
            Section(content: {
                Toggle("All Websites", isOn: $allWebsitesEnabled)
            }, header: {
                Text("\n\nRequest Desktop Website On")
            })
        }
        .toolbar {
            EditButton()
                .disabled(true)
        }
    }
}

#Preview {
    NavigationStack {
        RequestDesktopWebsiteView()
    }
}
