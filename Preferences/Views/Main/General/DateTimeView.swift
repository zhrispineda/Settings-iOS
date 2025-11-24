//
//  DateTimeView.swift
//  Preferences
//
//  Settings > General > Date & Time
//

import SwiftUI

struct DateTimeView: View {
    var body: some View {
        BundleControllerView(
            "DateAndTime",
            controller: "DateAndTime.DateAndTimeSettingsController",
            title: "Date & Time".localized(path: "/System/Library/PreferenceBundles/DateAndTime.bundle")
        )
    }
}

#Preview {
    NavigationStack {
        DateTimeView()
    }
}
