//
//  SiriSearchDetailView.swift
//  Preferences
//
//  Settings > [App] > Siri & Search
//  Settings > Siri & Search > [App]
//

import SwiftUI

struct SiriSearchDetailView: View {
    // Variables
    @State private var learnFromAppEnabled = true
    @State private var showAppInSearchEnabled = true
    @State private var showContentInSearchEnabled = true
    @State private var suggestInAppEnabled = true
    @State private var showHomeScreenEnabled = true
    @State private var suggestAppEnabled = true
    @State private var suggestNotificationsEnabled = true
    var appName: String = String()
    
    let showInAppApps = ["Safari", "Calendar", "Maps", "News"]
    
    var body: some View {
        CustomList(title: "Siri & Search") {
            Section(content: {
                Toggle("Learn from this App", isOn: $learnFromAppEnabled)
            }, footer: {
                Text("Allow Siri to learn from how you use “\(appName)“ to make suggestions across apps.")
            })
            
            Section(content: {
                Toggle("Show App in Search", isOn: $showAppInSearchEnabled)
                if showAppInSearchEnabled {
                    Toggle("Show Content in Search", isOn: $showContentInSearchEnabled)
                }
            }, header: {
                Text("While Searching")
            }, footer: {
                Text("Allow “\(appName)“ the app and its content to appear in Search.")
            })
            
            Section(content: {
                if showInAppApps.contains(appName) {
                    Toggle("Suggest in App", isOn: $suggestInAppEnabled)
                }
                Toggle("Suggest on Home Screen", isOn: $showHomeScreenEnabled)
                Toggle("Suggest App", isOn: $suggestAppEnabled)
                Toggle("Suggest Notifications", isOn: $suggestNotificationsEnabled)
            }, header: {
                Text("Suggestions")
            }, footer: {
                Text("Allow suggestions and content from “\(appName)“ and Shortcuts for the app to appear \(showInAppApps.contains(appName) ? "in the app, in Search, in widgets, and as notifications" : "in Search and in widgets"). These suggestions and Shortcuts are based on how you use the app.")
            })
        }
    }
}

#Preview {
    SiriSearchDetailView()
}
