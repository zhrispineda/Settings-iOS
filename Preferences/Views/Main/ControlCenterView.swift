//
//  ControlCenterView.swift
//  Preferences
//
//  Settings > Control Center
//

import SwiftUI

struct ControlCenterView: View {
    // Variables
    @AppStorage("allowControlCenterInApps") private var allowControlCenterInApps = true
    
    var body: some View {
        CustomList(title: String(localized: "CONTROLCENTER", table: "ControlCenterSettings")) {
            Section {} footer: {
                Text(Device().hasHomeButton ? "SWIPE_BOTTOM_INSTRUCTIONS" : "SWIPE_TOPRIGHT_EDGE_INSTRUCTIONS", tableName: "ControlCenterSettings")
            }
            
            Section {
                Toggle(String(localized: "ALLOWED_WITHIN_APPS", table: "ControlCenterSettings"), isOn: $allowControlCenterInApps)
            } footer: {
                Text("ALLOWED_WITHIN_APPS_FOOTER", tableName: "ControlCenterSettings")
            }
        }
    }
}

#Preview {
    NavigationStack {
        ControlCenterView()
    }
}
