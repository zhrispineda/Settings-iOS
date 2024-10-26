//
//  ControlNearbyDevicesView.swift
//  Preferences
//
//  Settings > Accessibility > Control Nearby Devices
//

import SwiftUI

struct ControlNearbyDevicesView: View {
    // Variables
    let table = "Accessibility"
    
    var body: some View {
        CustomList(title: "CONTROL_NEARBY_DEVICES".localize(table: table)) {
            Section {
                Button("CONTROL_NEARBY_DEVICES_BUTTON".localize(table: table)) {}
            } footer: {
                Text("CONTROL_NEARBY_DEVICES_FOOTER", tableName: table)
            }
        }
    }
}

#Preview {
    NavigationStack {
        ControlNearbyDevicesView()
    }
}
