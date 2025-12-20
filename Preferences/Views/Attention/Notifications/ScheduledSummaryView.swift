//
//  ScheduledSummaryView.swift
//  Preferences
//

import SwiftUI

/// View for Settings > Notifications > Scheduled Summary, which is bridged to `NCScheduledDeliverySettingsController`.
struct ScheduledSummaryView: View {
    let path = "/System/Library/PreferenceBundles/NotificationsSettings.bundle"
    let table = "NotificationsSettings"
    
    var body: some View {
        ControllerBridgeView(
            "NotificationsSettings",
            controller: "NCScheduledDeliverySettingsController",
            title: "SCHEDULED_DELIVERY".localized(path: path, table: table)
        )
    }
}

#Preview {
    NavigationStack {
        ScheduledSummaryView()
    }
}
