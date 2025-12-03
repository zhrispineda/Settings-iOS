//
//  CalendarView.swift
//  Preferences
//
//  Settings > Apps > Calendar
//

import SwiftUI

struct CalendarView: View {
    var body: some View {
        ControllerBridgeView(
            "MobileCalSettings",
            controller: "CalendarSettingsPlugin",
            title: "CalendarSettingsPlacard_Calendar".localized(
                path: "/System/Library/PreferenceBundles/MobileCalSettings.bundle",
                table: "MobileCalSettings"
            )
        )
    }
}

#Preview {
    NavigationStack {
        CalendarView()
    }
}
