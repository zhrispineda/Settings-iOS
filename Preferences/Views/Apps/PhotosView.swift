//
//  PhotosView.swift
//  Preferences
//
//  Settings > Apps > Photos
//

import SwiftUI

/// A bridge for the settings controller from Photos.
/// - Warning: This view will not load in Xcode Previews because the app cannot prompt for photo permissions.
///
/// **Workaround:** Use the app in Simulator or a physical device.
struct PhotosView: View {
    var body: some View {
        ControllerBridgeView(
            "MobileSlideShowSettings",
            controller: "SettingsBaseController",
            title: "PHOTOS_SETTINGS_TITLE".localized(
                path: "/System/Library/PreferenceBundles/MobileSlideShowSettings.bundle",
                table: "Photos"
            )
        )
    }
}
