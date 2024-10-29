//
//  ScreenDistanceView.swift
//  Preferences
//
//  Settings > Screen Time > Screen Distance
//

import SwiftUI

struct ScreenDistanceView: View {
    // Variables
    @State private var screenDistanceEnabled = false
    let table = "ScreenTimeSettingsUI"
    
    var body: some View {
        CustomList(title: "ScreenDistanceEDUFeatureTitle".localize(table: table)) {
            Section {
                Toggle("ScreenDistanceEDUFeatureTitle".localize(table: table), isOn: $screenDistanceEnabled)
            } footer: {
                Text("ScreenDistanceEnableFeatureGroupSpecifierFooterText", tableName: table)
            }
        }
    }
}

#Preview {
    NavigationStack {
        ScreenDistanceView()
    }
}
