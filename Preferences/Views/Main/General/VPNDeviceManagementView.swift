//
//  VPNDeviceManagementView.swift
//  Preferences
//
//  Settings > General > VPN & Device Management
//

import SwiftUI

struct VPNDeviceManagementView: View {
    let path = "/System/Library/PrivateFrameworks/ManagedConfigurationUI.framework"

    var body: some View {
        ControllerBridgeView(
            "\(path)/ManagedConfigurationUI",
            controller: "MCUIListController",
            title: "DEVICE_MANAGEMENT_VPN".localized(
                path: path,
                table: "ManagedConfigurationUI"
            )
        )
    }
}

#Preview {
    NavigationStack {
        VPNDeviceManagementView()
    }
}
