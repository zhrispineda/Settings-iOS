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
        CustomList(title: "CONTROLCENTER") {
            Section {} footer: {
                Text(Device().hasHomeButton ? "SWIPE_BOTTOM_INSTRUCTIONS" : "SWIPE_TOPRIGHT_EDGE_INSTRUCTIONS")
            }
            
            Section {
                Toggle("ALLOWED_WITHIN_APPS", isOn: $allowControlCenterInApps)
            } footer: {
                Text("ALLOWED_WITHIN_APPS_FOOTER")
            }
        }
    }
}

#Preview {
    NavigationStack {
        ControlCenterView()
    }
}
