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
    @State private var showHomeControls = true
    
    var body: some View {
        CustomList(title: "Control Center") {
            Section(content: {}, footer: {
                Text("Swipe down from the top-right edge to open Control Center.")
            })
            
            Section(content: {
                Toggle("Access Within Apps", isOn: $accessWithinAppsEnabled)
            }, footer: {
                Text("Allow access to Control Center within apps. When disabled, you can still access Control Center from the Home Screen.")
            })
            
            Section(content: {
                Toggle("Show Home Controls", isOn: $showHomeControls)
            }, footer: {
                Text("Include recommended controls for Home accessories and scenes.")
            })
            
            Section(content: {}, header: {
                Text("Included Controls")
            })
            
            Section(content: {}, header: {
                Text("More Controls")
            })
        }
    }
}

#Preview {
    NavigationStack {
        ControlCenterView()
    }
}
