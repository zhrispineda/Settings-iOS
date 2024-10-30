//
//  AppleAdvertisingView.swift
//  Preferences
//
//  Settings > Privacy & Security > Apple Advertising
//

import SwiftUI

struct AppleAdvertisingView: View {
    // Variables
    let table = "AppleAdvertising"
    
    var body: some View {
        CustomList(title: "ADVERTISING".localize(table: "Privacy"), topPadding: true) {
            Section {} header: {
                Text("APPLE_DELIVERED_ADVERTISING", tableName: table)
            } footer: {
                Text(.init("AD_PRIVACY_FOOTER".localize(table: table, "[\("AD_PRIVACY_FOOTER_LINK".localize(table: table))](#)")))
            }
            
            Section {
                Button("VIEW_AD_TARGETING_INFORMATION".localize(table: table)) {}
            } footer: {
                Text("VIEW_AD_TARGETING_INFORMATION_FOOTER", tableName: table)
            }
            
            Section {} footer: {
                Text("PERSONALIZED_ADS_NO_CONSENT", tableName: table)
            }
        }
    }
}

#Preview {
    NavigationStack {
        AppleAdvertisingView()
    }
}
