//
//  TrackingView.swift
//  Preferences
//
//  Settings > Privacy & Security > Tracking
//

import SwiftUI

struct TrackingView: View {
    // Variables
    @State private var allowAppsRequestTrackingEnabled = true
    let table = "Privacy"
    
    var body: some View {
        CustomList(title: "TRACKERS".localize(table: table)) {
            Section {
                Toggle("ALLOW_ASK".localize(table: table), isOn: $allowAppsRequestTrackingEnabled)
            } footer: {
                Text(.init("APP_TRACKING_HEADER_TEXT".localize(table: table) + " [\("APP_TRACKING_LINK_TEXT".localize(table: table))](#)"))
            }
            
            Section {} footer: {
                Text("TRACKING_HEADER", tableName: table)
            }
        }
    }
}

#Preview {
    NavigationStack {
        TrackingView()
    }
}
