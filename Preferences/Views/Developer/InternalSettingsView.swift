//
//  InternalSettingsView.swift
//  Preferences
//

import SwiftUI

struct InternalSettingsView: View {
    var body: some View {
        CustomList(title: "Internal Settings", topPadding: true) {
            Section("Device Info") {
                NavigationLink("About") {}
                Button("Set Up VPN") {}
            }
            
            Section("General Debugging") {
                NavigationLink("Application Debugging") {}
                NavigationLink("Installed App Info") {}
                NavigationLink("Logging") {}
                NavigationLink("Power HUD") {}
                NavigationLink("UI Debugging") {}
                NavigationLink("Auto Bug Capture") {}
                NavigationLink("Prototyping") {}
            }
            
            Section("Demo Helpers") {
                NavigationLink("Networking") {}
                NavigationLink("TetheredDemo") {}
            }
            
            Section("SpringBoard") {
                NavigationLink("Features") {}
                NavigationLink("SpringBoard") {}
                NavigationLink("Status Bar Overrides") {}
            }
        }
    }
}

#Preview {
    NavigationStack {
        InternalSettingsView()
    }
}
