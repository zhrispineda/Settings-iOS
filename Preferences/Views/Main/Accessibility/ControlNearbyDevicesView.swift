//
//  ControlNearbyDevicesView.swift
//  Preferences
//
//  Settings > Accessibility > Control Nearby Devices
//

import SwiftUI

struct ControlNearbyDevicesView: View {
    let path = "/System/Library/PreferenceBundles/AccessibilitySettings.bundle"
    let table = "Accessibility"
    
    var body: some View {
        CustomList(title: "CONTROL_NEARBY_DEVICES".localized(path: path, table: table)) {
            Section {
                Button("CONTROL_NEARBY_DEVICES_BUTTON".localized(path: path, table: table)) {}
            } footer: {
                Text("CONTROL_NEARBY_DEVICES_FOOTER".localized(path: path, table: table))
            }
        }
    }
}

#Preview {
    NavigationStack {
        ControlNearbyDevicesView()
    }
}
