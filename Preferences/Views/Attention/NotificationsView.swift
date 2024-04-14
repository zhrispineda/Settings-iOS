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
            Section(content: {
                EmptyView()
            }, header: {
                Text("\n\nDisplay As")
            }, footer: {
                Text("Choose the default for how notifications appear.")
            })
            
            Section {
                CustomNavigationLink(title: "Scheduled Summary", status: "Off", destination: EmptyView())
                CustomNavigationLink(title: "Show Previews", status: "Off", destination: EmptyView())
                CustomNavigationLink(title: "Screen Sharing", status: "Notifications Off", destination: EmptyView())
            }
            
            Section(content: {
                CustomNavigationLink(title: "Announce Notifications", status: "Off", destination: EmptyView())
                NavigationLink("Siri Suggestions", destination: {})
            }, header: {
                Text("Siri")
            })
            
            Section(content: {
                EmptyView()
            }, header: {
                Text("Notification Style")
            })
            
            Section(content: {
                Toggle("AMBER Alerts", isOn: $amberAlertsEnabled)
                CustomNavigationLink(title: "Emergency Alerts", status: "On", destination: EmptyView())
                Toggle("Public Safety Alerts", isOn: $publicSafetyAlertsEnabled)
                Toggle("Test Alerts", isOn: $testAlertsEnabled)
            }, header: {
                Text("Government Alerts")
            })
        }
    }
}

#Preview {
    NavigationStack {
        NotificationsView()
    }
}
