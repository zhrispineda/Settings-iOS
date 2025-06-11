//
//  NewsView.swift
//  Preferences
//
//  Settings > Apps > News
//

import SwiftUI

struct NewsView: View {
    // Variables
    @State private var gameCenterEnabled = true
    @State private var restrictStoriesTodayEnabled = false
    @State private var showingRestrictDialog = false
    @State private var showingRestrictAlert = false
    @State private var resetIdentifierEnabled = false
    @State private var showingSheet = false
    let table = "NewsSettings"
    
    var body: some View {
        CustomList(title: "NEWS_SETTINGS_TITLE".localize(table: table), topPadding: true) {
            if UIDevice.IsSimulator {
                PermissionsView(appName: "NEWS_SETTINGS_TITLE".localize(table: table), background: true, cellular: false, liveActivityToggle: true, location: false, notifications: false, cellularEnabled: .constant(true))
            } else {
                PermissionsView(appName: "NEWS_SETTINGS_TITLE".localize(table: table), background: true, cellular: true, liveActivityToggle: true, location: true, notifications: true, cellularEnabled: .constant(true))
            }
            
            Section {
                Link("SUBSCRIBE_NEWS_PLUS_TITLE".localize(table: table), destination: URL(string: "applenews://subscription")!)
                NavigationLink("AUTOMATIC_DOWNLOADS_LINK_TITLE".localize(table: table)) {}
                    .disabled(true)
            } header: {
                Text("NEWS_PLUS_OFFLINE_MODE_GROUP_TITLE", tableName: table)
            } footer: {
                Text("NEWS_PLUS_OFFLINE_MODE_GROUP_DESCRIPTION_NON_SUBSCRIBER", tableName: table)
            }
            
            Section {
                Toggle("GAME_CENTER_ENABLED_TITLE".localize(table: table), isOn: $gameCenterEnabled)
            } header: {
                Text("GAME_CENTER_GROUP_TITLE", tableName: table)
            } footer: {
                Text("\("GAME_CENTER_ENABLED_DESCRIPTION".localize(table: table)) [\("GAME_CENTER_SETTINGS_GROUP_FOOTER_LINK".localize(table: table))](#)")
            }
            
            Section {
                Toggle("RESTRICT_STORIES_TITLE".localize(table: table), isOn: $restrictStoriesTodayEnabled)
                    .alert("RESTRICT_STORIES_ALERT_TITLE_IPAD".localize(table: table), isPresented: $showingRestrictAlert) {
                        Button("RESTRICT_STORIES_ALERT_TURN_ON_TITLE_IPAD".localize(table: table)) {}
                        Button("RESTRICT_STORIES_ALERT_CANCEL_TITLE".localize(table: table), role: .cancel) {
                            restrictStoriesTodayEnabled.toggle()
                        }
                    } message: {
                        Text("RESTRICT_STORIES_ALERT_DESCRIPTION", tableName: table)
                    }
                    .confirmationDialog("RESTRICT_STORIES_ALERT_DESCRIPTION".localize(table: table), isPresented: $showingRestrictDialog, titleVisibility: .visible) {
                        Button("RESTRICT_STORIES_ALERT_TITLE_IPHONE".localize(table: table)) {}
                        Button("RESTRICT_STORIES_ALERT_CANCEL_TITLE".localize(table: table), role: .cancel) {
                            restrictStoriesTodayEnabled.toggle()
                        }
                    }
                    .onChange(of: restrictStoriesTodayEnabled) {
                        if restrictStoriesTodayEnabled {
                            UIDevice.iPhone ? showingRestrictDialog.toggle() : showingRestrictAlert.toggle()
                        }
                    }
            } header: {
                Text("TODAY_FEED_GROUP_TITLE", tableName: table)
            } footer: {
                Text("RESTRICT_STORIES_DESCRIPTION", tableName: table)
            }
            
            Section {
                Button("PRIVACY_TITLE".localize(table: table)) {
                    showingSheet = true
                }
                Toggle("RESET_IDENTIFIER_TITLE".localize(table: table), isOn: $resetIdentifierEnabled)
            } header: {
                Text("PRIVACY_GROUP_TITLE", tableName: table)
            } footer: {
                Text("RESET_IDENTIFIER_DESCRIPTION", tableName: table)
            }
        }
        .background {
            OBCombinedSplashView(["com.apple.onboarding.news", "com.apple.onboarding.newsletter", "com.apple.onboarding.mysports", "com.apple.onboarding.gamecenter"], showingSheet: $showingSheet)
        }
    }
}

#Preview {
    NavigationStack {
        NewsView()
    }
}
