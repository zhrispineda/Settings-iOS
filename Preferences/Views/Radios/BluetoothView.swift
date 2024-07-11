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
    @AppStorage("DeviceName") private var deviceName = Device().model
    
    var body: some View {
        CustomList(title: "BLUETOOTH".localize(table: "BluetoothSettings")) {
            Section {
                SectionHelp(title: "BLUETOOTH".localize(table: "BluetoothSettings"), color: Color.blue, icon: "bluetooth", description: "\("BLUETOOTHPLACARDINFO".localize(table: "BluetoothSettings")) [\("LEARN_MORE".localize(table: "BluetoothSettings"))](https://support.apple.com/guide/\(Device().isPhone ?  "iphone/bluetooth-accessories-iph3c50f191/ios" : "ipad/bluetooth-accessories-ipad997da4cf/ipados"))")
                Toggle("BLUETOOTH".localize(table: "BluetoothSettings"), isOn: $bluetoothEnabled.animation())
            } footer: {
                if bluetoothEnabled {
                    Text("DISCOVERABLE".localize(table: "BluetoothSettings", deviceName))
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
                        Text(.init("APPLE_WATCH_FOOTER_TEXT".localize(table: "BluetoothSettings", "[\("APPLE_WATCH_APP_LINK".localize(table: "BluetoothSettings"))](itms-watchs://)")))
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
