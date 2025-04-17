/*
Abstract:
A View container for displaying options regarding Siri Suggestions and apps.
*/

import SwiftUI

/// A `View` container for displaying options regarding Siri Suggestions and apps.
///
/// ```swift
/// SiriDetailView(appName: "News", title: "News")
/// ```
///
/// - Parameter appName: The `String` to display as the app name for the `View`.
/// - Parameter title: The `String` of the navigation title.
struct SiriDetailView: View {
    // Variables
    @State private var learnFromAppEnabled = true
    @State private var suggestInAppEnabled = true
    @State private var showHomeScreenEnabled = true
    @State private var suggestAppEnabled = true
    @State private var suggestNotificationsEnabled = true
    var appName = ""
    var title = UIDevice.IntelligenceCapability ? "Apple Intelligence & Siri" : "Siri"
    let table = "AssistantSettings"
    let showInAppApps: Set<String> = ["Calendar", "Contacts", "Maps", "Messages", "News", "Reminders", "Safari"]
    
    var body: some View {
        CustomList(title: title) {
            Section {
                Toggle("SIRIANDSEARCH_PERAPP_INAPP_LEARNFROMAPP_TOGGLE".localize(table: table, appName), isOn: $learnFromAppEnabled)
            } footer: {
                Text("SIRIANDSEARCH_PERAPP_INAPP_FOOTER".localize(table: table, appName))
            }
            
            Section {
                if showInAppApps.contains(appName) {
                    Toggle("Suggest in App", isOn: $suggestInAppEnabled)
                }
                
                Toggle("Suggest on Home Screen", isOn: $showHomeScreenEnabled)
                Toggle("SIRIANDSEARCH_PERAPP_SUGGESTIONS_SUGGESTAPP_TOGGLE".localize(table: table), isOn: $suggestAppEnabled)
                Toggle("Suggest Notifications", isOn: $suggestNotificationsEnabled)
            } header: {
                Text("SIRIANDSEARCH_PERAPP_SUGGESTIONS_HEADER", tableName: table)
            } footer: {
                Text("\(showInAppApps.contains(appName) ? "SIRIANDSEARCH_PERAPP_SUGGESTIONS_FOOTER_CONTACTSAPP_NONOTIFICATIONS" : "SIRIANDSEARCH_PERAPP_SUGGESTIONS_FOOTER_NOSHOW_NONOTIFICATIONS")".localize(table: table, appName))
            }
        }
    }
}

#Preview {
    NavigationStack {
        SiriDetailView(appName: "News")
    }
}
