//
//  NotificationsView.swift
//  Preferences
//
//  Settings > Notifications
//

import SwiftUI

struct NotificationsView: View {
    // Variables
    @State private var amberAlertsEnabled = true
    @State private var publicSafetyAlertsEnabled = true
    @State private var testAlertsEnabled = false
    
    var body: some View {
        CustomList(title: "Notifications", topPadding: true) {
            Section {
                EmptyView()
            } header: {
                Text("Display As")
            } footer: {
                Text("Choose the default for how notifications appear.")
            }
            
            Section {
                CustomNavigationLink(title: "Scheduled Summary", status: "Off", destination: EmptyView())
                CustomNavigationLink(title: "Show Previews", status: "Off", destination: EmptyView())
                CustomNavigationLink(title: "Screen Sharing", status: "Notifications Off", destination: EmptyView())
            }
            
            Section {
                CustomNavigationLink(title: "Announce Notifications", status: "Off", destination: EmptyView())
                NavigationLink("Siri Suggestions") {}
            } header: {
                Text("Siri")
            }
            
            Section {
                SettingsLink(icon: "applePhotos", id: "Photos", subtitle: "Banners, Sounds, Badges") {}
            } header: {
                Text("Notification Style")
            }
            
            if UIDevice.iPhone {
                Section {
                    Toggle("AMBER Alerts", isOn: $amberAlertsEnabled)
                    CustomNavigationLink(title: "Emergency Alerts", status: "On", destination: EmptyView())
                    Toggle("Public Safety Alerts", isOn: $publicSafetyAlertsEnabled)
                    Toggle("Test Alerts", isOn: $testAlertsEnabled)
                } header: {
                    Text("Government Alerts")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        NotificationsView()
    }
}
