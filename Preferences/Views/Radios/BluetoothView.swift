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
        CustomList(title: String(localized: "BLUETOOTH", table: "BluetoothSettings")) {
            Section {
                SectionHelp(title: String(localized: "BLUETOOTH", table: "BluetoothSettings"), color: Color.blue, icon: "bluetooth", description: "\(String(localized: "BLUETOOTHPLACARDINFO", table: "BluetoothSettings")) [\(String(localized: "LEARN_MORE", table: "BluetoothSettings"))](https://support.apple.com/guide/\(Device().isPhone ?  "iphone/bluetooth-accessories-iph3c50f191/ios" : "ipad/bluetooth-accessories-ipad997da4cf/ipados"))")
                Toggle(String(localized: "BLUETOOTH", table: "BluetoothSettings"), isOn: $bluetoothEnabled.animation())
            } footer: {
                if bluetoothEnabled {
                    Text(String.localizedStringWithFormat(NSLocalizedString("DISCOVERABLE", tableName: "BluetoothSettings", comment: ""), UIDevice().model))
                } else {
                    Text("POWER_OFF_WARNING", tableName: "BluetoothSettings")
                }
            }
            
            if bluetoothEnabled {
                Section {
                    EmptyView()
                } header: {
                    HStack {
                        Text("DEVICES", tableName: "BluetoothSettings")
                        ProgressView()
                            .padding(.horizontal, 1)
                    }
                } footer: {
                    if Device().isPhone {
                        Text(String.localizedStringWithFormat(NSLocalizedString("APPLE_WATCH_FOOTER_TEXT", tableName: "BluetoothSettings", comment: ""), "Apple Watch app"))
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
