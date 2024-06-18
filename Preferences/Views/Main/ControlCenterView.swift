//
//  ControlCenterView.swift
//  Preferences
//
//  Settings > Control Center
//

import SwiftUI

struct ControlCenterView: View {
    // Variables
    @State private var accessWithinAppsEnabled = true
    
    var body: some View {
        CustomList(title: "Control Center") {
            Section {} footer: {
                Text("Swipe \(Device().hasHomeButton ? "up from the bottom of the screen to view" : "down from the top-right edge to open") Control Center.")
            }
            
            Section {
                Toggle("Access Within Apps", isOn: $accessWithinAppsEnabled)
            } footer: {
                Text("Allow access to Control Center within apps. When disabled, you can still access Control Center from the Home Screen.")
            }
        }
    }
}

#Preview {
    NavigationStack {
        ControlCenterView()
    }
}
