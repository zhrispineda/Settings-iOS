//
//  SiriDetailView.swift
//  Preferences
//

import SwiftUI

/// A `CustomList` container for displaying options regarding Siri Suggestions and apps.
///
/// ```swift
/// SiriDetailView(appName: "News", title: "News")
/// ```
///
/// - Parameter appName: The `String` app name.
/// - Parameter title: The `String` navigation title.
struct SiriDetailView: View {
    @State private var learnFromAppEnabled = true
    @State private var suggestInAppEnabled = true
    @State private var showHomeScreenEnabled = true
    @State private var suggestAppEnabled = true
    @State private var suggestNotificationsEnabled = true
    var appName = ""
    var title = UIDevice.IntelligenceCapability ? "Apple Intelligence & Siri" : "Siri"
    let path = "/System/Library/PrivateFrameworks/AssistantSettingsSupport.framework"
    let table = "AssistantSettings"
    let showInAppApps: Set<String> = ["Calendar", "Contacts", "Maps", "Messages", "News", "Reminders", "Safari"]
    
    var body: some View {
        CustomList(title: title) {
            Section {
                Toggle("SIRIANDSEARCH_PERAPP_INAPP_LEARNFROMAPP_TOGGLE".localized(path: path, table: table), isOn: $learnFromAppEnabled)
            } footer: {
                Text("SIRIANDSEARCH_PERAPP_INAPP_FOOTER".localized(path: path, table: table, appName))
            }
            
            Section {
                if showInAppApps.contains(appName) {
                    switch appName {
                    case "Contacts":
                        Toggle("SIRIANDSEARCH_PERAPP_SUGGESTIONS_SHOWINAPP_TOGGLE_CONTACTSAPP".localized(path: path, table: table), isOn: $suggestInAppEnabled)
                    case "Phone":
                        Toggle("SIRIANDSEARCH_PERAPP_SUGGESTIONS_SHOWINAPP_TOGGLE_PHONEAPP".localized(path: path, table: table), isOn: $suggestInAppEnabled)
                    default:
                        Toggle("SIRIANDSEARCH_PERAPP_SUGGESTIONS_SHOWINAPP_TOGGLE".localized(path: path, table: table), isOn: $suggestInAppEnabled)
                    }
                }
                
                Toggle("SIRIANDSEARCH_PERAPP_SUGGESTIONS_SHOWONHOMESCREEN_TOGGLE".localized(path: path, table: table), isOn: $showHomeScreenEnabled)
                Toggle("SIRIANDSEARCH_PERAPP_SUGGESTIONS_SUGGESTAPP_TOGGLE".localized(path: path, table: table), isOn: $suggestAppEnabled)
                Toggle("SIRIANDSEARCH_PERAPP_SUGGESTIONS_SUGGESTION_NOTIFICATIONS_TOGGLE".localized(path: path, table: table), isOn: $suggestNotificationsEnabled)
            } header: {
                Text("SIRIANDSEARCH_PERAPP_SUGGESTIONS_HEADER".localized(path: path, table: table))
            } footer: {
                Text("\(showInAppApps.contains(appName) ? "SIRIANDSEARCH_PERAPP_SUGGESTIONS_FOOTER_CONTACTSAPP_NONOTIFICATIONS" : "SIRIANDSEARCH_PERAPP_SUGGESTIONS_FOOTER_NOSHOW_NONOTIFICATIONS")".localized(path: path, table: table, appName))
            }
        }
    }
}

#Preview {
    NavigationStack {
        SiriDetailView(appName: "News")
    }
}
