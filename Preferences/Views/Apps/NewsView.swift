//
//  NewsView.swift
//  Preferences
//
//  Settings > Apps > News
//

import SwiftUI

struct NewsView: View {
    @State private var gameCenterEnabled = true
    @State private var restrictStoriesTodayEnabled = false
    @State private var showingRestrictDialog = false
    @State private var showingRestrictAlert = false
    @State private var resetIdentifierEnabled = false
    @State private var showingSheet = false
    let path = "/System/Library/PreferenceBundles/NewsSettings.bundle"
    let table = "NewsSettings"
    
    var body: some View {
        CustomList(title: "NEWS_SETTINGS_TITLE".localized(path: path), topPadding: true) {
            if UIDevice.IsSimulator {
                PermissionsView(appName: "NEWS_SETTINGS_TITLE".localized(path: path), background: true, cellular: false, liveActivityToggle: true, location: false, notifications: false, cellularEnabled: .constant(true))
            } else {
                PermissionsView(appName: "NEWS_SETTINGS_TITLE".localized(path: path), background: true, cellular: false, liveActivityToggle: true, location: false, notifications: false, cellularEnabled: .constant(true))
            }
            
            Section {
                Link("SUBSCRIBE_NEWS_PLUS_TITLE".localized(path: path), destination: URL(string: "applenews://subscription")!)
                NavigationLink("AUTOMATIC_DOWNLOADS_LINK_TITLE".localized(path: path)) {}
                    .disabled(true)
            } header: {
                Text("NEWS_PLUS_OFFLINE_MODE_GROUP_TITLE".localized(path: path))
            } footer: {
                Text("NEWS_PLUS_OFFLINE_MODE_GROUP_DESCRIPTION_NON_SUBSCRIBER".localized(path: path))
            }
            
            Section {
                Toggle("RESTRICT_STORIES_TITLE".localized(path: path), isOn: $restrictStoriesTodayEnabled)
                    .alert("RESTRICT_STORIES_ALERT_TITLE_IPAD".localized(path: path), isPresented: $showingRestrictAlert) {
                        Button("RESTRICT_STORIES_ALERT_TURN_ON_TITLE_IPAD".localized(path: path)) {}
                        Button("RESTRICT_STORIES_ALERT_CANCEL_TITLE".localized(path: path), role: .cancel) {
                            restrictStoriesTodayEnabled.toggle()
                        }
                    } message: {
                        Text("RESTRICT_STORIES_ALERT_DESCRIPTION".localized(path: path))
                    }
                    .confirmationDialog("RESTRICT_STORIES_ALERT_DESCRIPTION".localized(path: path), isPresented: $showingRestrictDialog, titleVisibility: .visible) {
                        Button("RESTRICT_STORIES_ALERT_TITLE_IPHONE".localized(path: path)) {}
                        Button("RESTRICT_STORIES_ALERT_CANCEL_TITLE".localized(path: path), role: .cancel) {
                            restrictStoriesTodayEnabled.toggle()
                        }
                    }
                    .onChange(of: restrictStoriesTodayEnabled) {
                        if restrictStoriesTodayEnabled {
                            UIDevice.iPhone ? showingRestrictDialog.toggle() : showingRestrictAlert.toggle()
                        }
                    }
            } header: {
                Text("TODAY_FEED_GROUP_TITLE".localized(path: path))
            } footer: {
                Text("RESTRICT_STORIES_DESCRIPTION".localized(path: path))
            }
            
            Section {
                Button("PRIVACY_TITLE".localized(path: path)) {
                    showingSheet = true
                }
                Toggle("RESET_IDENTIFIER_TITLE".localized(path: path), isOn: $resetIdentifierEnabled)
            } header: {
                Text("PRIVACY_GROUP_TITLE".localized(path: path))
            } footer: {
                Text("RESET_IDENTIFIER_DESCRIPTION".localized(path: path))
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
