//
//  CameraControlView.swift
//  Preferences
//
//  Settings > Camera > Camera Control
//

import SwiftUI

struct CameraControlView: View {
    var body: some View {
        ControllerBridgeView(
            "CameraSettings",
            controller: "CameraButtonSettingsController",
            title: "CAMERA_BUTTON_TITLE".localized(
                path: "/System/Library/PreferenceBundles/CameraSettings.bundle",
                table: "CameraSettings-CameraButton"
            )
        )
    }
}

#Preview {
    NavigationStack {
        CameraControlView()
    }
}
