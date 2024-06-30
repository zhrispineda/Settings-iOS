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
        CustomList(title: "Notifications") {
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
            
            Section {} header: {
                Text("Notification Style")
            }
            
            if Device().isPhone {
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
