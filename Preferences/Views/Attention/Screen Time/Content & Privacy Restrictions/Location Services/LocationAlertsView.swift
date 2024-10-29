//
//  LocationAlertsView.swift
//  Preferences
//
//  Settings > Screen Time > Content & Privacy Restrictions > Location Alerts
//

import SwiftUI

struct LocationAlertsView: View {
    // Variables
    @State private var showMapLocationAlertsEnabled = true
    let table = "Location Services"
    
    var body: some View {
        CustomList(title: "PRIVACY_ALERTS".localize(table: table)) {
            Section {
                Toggle("MAP_DISPLAY".localize(table: table), isOn: $showMapLocationAlertsEnabled)
            }
        }
    }
}

#Preview {
    NavigationStack {
        LocationAlertsView()
    }
}
