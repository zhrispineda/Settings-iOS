//
//  SiriDetailView.swift
//  Preferences
//
//  Settings > [App] > Siri & Search
//  Settings > Siri & Search > [App]
//

import SwiftUI

/// A ``View`` template for displaying options regarding Siri Suggestions and apps.
/// ```swift
/// SiriDetailView(appName: "News", title: "News")
/// ```
/// - Parameter appName: The ``String`` to display as the app name for the ``View``.
/// - Parameter title: The ``String``to display as the title of the ``View``.
struct SiriDetailView: View {
    // Variables
    @State private var learnFromAppEnabled = true
    @State private var suggestInAppEnabled = true
    @State private var showHomeScreenEnabled = true
    @State private var suggestAppEnabled = true
    @State private var suggestNotificationsEnabled = true
    var appName: String = String()
    var title: String = "Siri & Search"
    
    let showInAppApps = ["Calendar", "Contacts", "Maps", "Messages", "News", "Reminders", "Safari"]
    
    var body: some View {
        CustomList(title: title) {
            Section {
                Toggle("Learn from this App", isOn: $learnFromAppEnabled)
            } footer: {
                Text("Allow Siri to learn from how you use “\(appName)“ to make suggestions across apps.")
            }
            
            Section {
                if showInAppApps.contains(appName) {
                    Toggle("Suggest in App", isOn: $suggestInAppEnabled)
                }
                Toggle("Suggest on Home Screen", isOn: $showHomeScreenEnabled)
                Toggle("Suggest App", isOn: $suggestAppEnabled)
                Toggle("Suggest Notifications", isOn: $suggestNotificationsEnabled)
            } header: {
                Text("Suggestions")
            } footer: {
                Text("Allow suggestions and content from “\(appName)“ and Shortcuts for the app to appear \(showInAppApps.contains(appName) ? "in the app, in Search, in widgets, and as notifications" : "in Search and in widgets"). These suggestions and Shortcuts are based on how you use the app.")
            }
        }
    }
}

#Preview {
    NavigationStack {
        SiriDetailView()
    }
}
