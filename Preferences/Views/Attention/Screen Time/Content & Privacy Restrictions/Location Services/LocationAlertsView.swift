//
//  LocationAlertsView.swift
//  Preferences
//
//  Settings > Screen Time > Content & Privacy Restrictions > Location Alerts
//

import SwiftUI

struct LocationAlertsView: View {
    @State private var showMapLocationAlertsEnabled = true
    let path = "/System/Library/PrivateFrameworks/Settings/PrivacySettingsUI.framework"
    let table = "Location Services"
    
    var body: some View {
        CustomList(title: "PRIVACY_ALERTS".localized(path: path, table: table)) {
            Section {
                Toggle("MAP_DISPLAY".localized(path: path, table: table), isOn: $showMapLocationAlertsEnabled)
            }
        }
    }
}

#Preview {
    NavigationStack {
        LocationAlertsView()
    }
}
