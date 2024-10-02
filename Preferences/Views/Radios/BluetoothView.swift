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
    @AppStorage("DeviceName") private var deviceName = UIDevice.current.model
    @State private var opacity: Double = 0
    @State private var frameY: Double = 0
    let table = "Devices"
    
    var body: some View {
        CustomList {
            Section {
                SectionHelp(title: "BLUETOOTH".localize(table: table), color: Color.blue, icon: "bluetooth", description: "\("BLUETOOTHPLACARDINFO".localize(table: table)) [\("LEARN_MORE".localize(table: table))](https://support.apple.com/guide/\(UIDevice.iPhone ?  "iphone/bluetooth-accessories-iph3c50f191/ios" : "ipad/bluetooth-accessories-ipad997da4cf/ipados"))")
                    .overlay { // For calculating opacity of the principal toolbar item
                        GeometryReader { geo in
                            Color.clear
                                .onChange(of: geo.frame(in: .scrollView).minY) {
                                    frameY = geo.frame(in: .scrollView).minY
                                    opacity = frameY / -30
                                }
                        }
                    }
                Toggle("BLUETOOTH".localize(table: table), isOn: $bluetoothEnabled.animation())
            } footer: {
                if bluetoothEnabled {
                    Text("DISCOVERABLE".localize(table: table, deviceName))
                } else {
                    Text("POWER_OFF_WARNING", tableName: table)
                }
            }
            
            if bluetoothEnabled {
                Section {
                    EmptyView()
                } header: {
                    HStack {
                        Text("DEVICES", tableName: table)
                        ProgressView()
                            .padding(.horizontal, 1)
                    }
                } footer: {
                    if UIDevice.iPhone {
                        Text(.init("APPLE_WATCH_FOOTER_TEXT".localize(table: table, "[\("APPLE_WATCH_APP_LINK".localize(table: table))](itms-watchs://)")))
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("\("BLUETOOTH".localize(table: "table"))")
                    .fontWeight(.semibold)
                    .font(.subheadline)
                    .opacity(frameY < 50.0 ? opacity : 0) // Only fade when passing the help section title at the top
            }
        }
    }
}

#Preview {
    NavigationStack {
        BluetoothView()
    }
}
