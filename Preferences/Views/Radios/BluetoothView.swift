//
//  BluetoothView.swift
//  Preferences
//
//  Settings > Bluetooth
//

import SwiftUI

struct BluetoothView: View {
    // Variables
    @AppStorage("bluetooth") private var bluetoothEnabled = true
    
    var body: some View {
        CustomList(title: "Bluetooth") {
            Section {
                SectionHelp(title: "Bluetooth", color: Color.blue, icon: "bluetooth", description: "Connect to accessories you can use for activities such as streaming music, making phone calls, and gaming. [Learn more...](https://support.apple.com/guide/\(Device().isPhone ?  "iphone/bluetooth-accessories-iph3c50f191/ios" : "ipad/bluetooth-accessories-ipad997da4cf/ipados"))")
                Toggle("Bluetooth", isOn: $bluetoothEnabled.animation())
            } footer: {
                if bluetoothEnabled {
                    Text("This \(Device().model) is discoverable as \u{201C}\(Device().model)\u{201D} while Bluetooth Settings is open.")
                } else {
                    Text("AirDrop, AirPlay, Find My, and Location Services use Bluetooth.")
                }
            }
            
            if bluetoothEnabled {
                Section {
                    EmptyView()
                } header: {
                    HStack {
                        Text("Devices")
                        ProgressView()
                            .padding(.horizontal, 1)
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        BluetoothView()
    }
}
