//
//  InternalSettingsView.swift
//  Preferences
//

import SwiftUI

struct InternalSettingsView: View {
    var body: some View {
        CustomList(title: "Internal Settings", topPadding: true) {
            Section("Device Info") {
                NavigationLink("About", destination: InternalAboutView())
                Button("Set Up VPN") {}
            }
            
            Section("General Debugging") {
                NavigationLink("Application Debugging") {}
                NavigationLink("Installed App Info") {}
                NavigationLink("Logging") {}
                NavigationLink("Power HUD") {}
                NavigationLink("HangTracer HUD") {}
                NavigationLink("Process Terminations HUD") {}
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
            
            Section("System") {
                NavigationLink("Feature Flags") {}
                NavigationLink("Carry") {}
                NavigationLink("Software Update Self Services") {}
                NavigationLink("Device Management") {}
                NavigationLink("Keyboards") {}
                NavigationLink("Text") {}
                NavigationLink("Media") {}
                NavigationLink("Battery Center") {}
                NavigationLink("Pasteboard") {}
                NavigationLink("Localization") {}
            }
            
            Section("Low Level") {
                NavigationLink("Accessories") {}
                NavigationLink("Accessories Firmware Update") {}
                NavigationLink("AFC") {}
                NavigationLink("BackgroundTaskAgent") {}
                NavigationLink("Baseband") {}
                NavigationLink("Core OS") {}
                NavigationLink("Display Port") {}
                NavigationLink("Location") {}
                NavigationLink("Power") {}
                NavigationLink("Radios") {}
            }
            
            Section {
                Button("Kill SpringBoard") {}
                Button("Reboot Device") {}
                Button("Erase All Content and Settings", role: .destructive) {}
            } footer: {
                Text("Note: Erasing All Content and Settings this way will NOT disassociate this device from Find My iPhone.")
            }
            
            Section("Applications") {
                NavigationLink("Phone") {}
                NavigationLink("Settings App") {}
                NavigationLink("RemoteUI") {}
                NavigationLink("Clock App") {}
                NavigationLink("International 🇺🇳") {}
            }
        }
    }
}

#Preview {
    NavigationStack {
        InternalSettingsView()
    }
}
