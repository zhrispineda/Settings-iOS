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
    
    var body: some View {
        CustomList(title: "Location Alerts") {
            Section {
                Toggle("Show Map in Location Alerts", isOn: $showMapLocationAlertsEnabled)
            }
        }
    }
}

#Preview {
    LocationAlertsView()
}
