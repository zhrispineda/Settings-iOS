//
//  TrackingView.swift
//  Preferences
//
//  Settings > Privacy & Security > Tracking
//

import SwiftUI

struct TrackingView: View {
    @State private var allowAppsRequestTrackingEnabled = true
    @State private var showingSheet = false
    let privacy = "/System/Library/PrivateFrameworks/Settings/PrivacySettingsUI.framework"
    let table = "Privacy"
    
    var body: some View {
        CustomList(title: "Tracking".localized(path: privacy)) {
            Section {
                Toggle("ALLOW_ASK".localized(path: privacy, table: table), isOn: $allowAppsRequestTrackingEnabled)
            } footer: {
                Text(.init("APP_TRACKING_HEADER_TEXT".localized(path: privacy, table: table) + " [\("APP_TRACKING_LINK_TEXT".localized(path: privacy, table: table))](pref://privacy)"))
            }
            
            Section {} footer: {
                Text("TRACKING_HEADER".localized(path: privacy, table: table))
            }
        }
        .onOpenURL { url in
            if url.absoluteString == "pref://privacy" {
                showingSheet = true
            }
        }
        .sheet(isPresented: $showingSheet) {
            CustomViewController("/System/Library/PrivateFrameworks/Settings/PrivacySettingsUI.framework/PrivacySettingsUI", controller: "PSTrackingWelcomeController")
                .ignoresSafeArea()
        }
    }
}

#Preview {
    NavigationStack {
        TrackingView()
    }
}
