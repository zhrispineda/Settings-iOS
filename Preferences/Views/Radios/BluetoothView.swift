//
//  BluetoothView.swift
//  Preferences
//
//  Settings > Bluetooth
//

import SwiftUI

struct BluetoothView: View {
    // Variables
    @State private var bluetoothEnabled = true
    
    var body: some View {
        CustomList(title: "Bluetooth") {
            Section {
                SectionHelp(title: "Bluetooth", color: Color.blue, icon: "bluetooth", description: "Wirelessly connect accessories like keyboards, headphones, and speakers. [Learn more...](https://support.apple.com/guide/\(DeviceInfo().isPhone ?  "iphone/bluetooth-accessories-iph3c50f191/ios" : "ipad/bluetooth-accessories-ipad997da4cf/ipados"))")
                Toggle("Bluetooth", isOn: $bluetoothEnabled.animation())
            } footer: {
                if bluetoothEnabled {
                    Text("This \(UIDevice().localizedModel) is discoverable as \u{201C}\(UIDevice().localizedModel)\u{201D} while Bluetooth Settings is open.")
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
