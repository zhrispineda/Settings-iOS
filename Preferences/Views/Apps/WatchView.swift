//
//  WatchView.swift
//  Preferences
//
//  Settings > Apps > Watch
//

import SwiftUI

struct WatchView: View {
    var body: some View {
        CustomList(title: "Watch", topPadding: true) {
            PermissionsView(appName: "Watch", liveActivityToggle: true, location: false, cellularEnabled: .constant(true))
        }
    }
}

#Preview {
    NavigationStack {
        WatchView()
    }
}
