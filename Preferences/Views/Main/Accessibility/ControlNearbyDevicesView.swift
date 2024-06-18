//
//  ControlNearbyDevicesView.swift
//  Preferences
//
//  Settings > Accessibility > Control Nearby Devices
//

import SwiftUI

struct ControlNearbyDevicesView: View {
    var body: some View {
        CustomList(title: "Control Nearby Devices") {
            Section {
                Button("Control Nearby Devices") {}
            } footer: {
                Text("Control Nearby Devices allows you to use another device on the same iCloud account from this iPhone. For example, you can start and stop media, activate buttons, or interact with Siri.")
            }
        }
    }
}

#Preview {
    ControlNearbyDevicesView()
}
