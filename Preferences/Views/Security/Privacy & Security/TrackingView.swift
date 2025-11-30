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
    let path = "/System/Library/PrivateFrameworks/Settings/PrivacySettingsUI.framework"
    let table = "Privacy"
    
    var body: some View {
        CustomList(title: "Tracking".localized(path: path)) {
            Section {
                Toggle("ALLOW_ASK".localized(path: path, table: table), isOn: $allowAppsRequestTrackingEnabled)
            } footer: {
                PSFooterHyperlinkView(
                    footerText: "\("APP_TRACKING_HEADER_TEXT".localized(path: path, table: table)) \("APP_TRACKING_LINK_TEXT".localized(path: path, table: table))",
                    linkText: "APP_TRACKING_LINK_TEXT".localized(path: path, table: table),
                    onLinkTap: {
                        showingSheet = true
                    }
                )
            }
            
            Section {} footer: {
                Text("TRACKING_HEADER".localized(path: path, table: table))
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
