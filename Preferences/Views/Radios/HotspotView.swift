//
//  HotspotView.swift
//  Preferences
//
//  Settings > Personal Hotspot
//

import SwiftUI

/// A view controller bridge for `WirelessModemController`, from `WirelessModemSettings`.
///
/// - Warning: The classes from this bundle do not exist in Simulator. This will result in a blank view.
///
/// - Warning: This bridge is not functional, missing entitlements including `com.apple.wifi.manager-access`.
///
/// - Note: This bundle contains an incomplete catalog of localized strings.
/// If the system language is set to English, it will cause `.localizedString` to fall back to the last item. (`ur.lproj`, Urdu in this case)
struct HotspotView: View {
    var body: some View {
        BundleControllerView(
            "WirelessModemSettings",
            controller: "WirelessModemController",
            title: "MAIN_SPEC_PROVISIONED".localized(
                path: "/System/Library/PreferenceBundles/WirelessModemSettings.bundle",
                table: "WirelessModemSettings"
            )
        )
    }
}

#Preview {
    NavigationStack {
        HotspotView()
    }
}
