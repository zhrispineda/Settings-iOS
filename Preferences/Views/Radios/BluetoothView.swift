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
    @State private var frameY = 0.0
    @State private var opacity = 0.0
    @State private var showingHelpSheet = false
    let table = "Devices"
    
    var body: some View {
        CustomList {
            Section {
                Placard(title: "BLUETOOTH".localize(table: table), color: Color.blue, icon: "bluetooth", description: "\("BLUETOOTHPLACARDINFO".localize(table: table)) [\("LEARN_MORE".localize(table: table))](pref://helpkit)", frameY: $frameY, opacity: $opacity)
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
        .onOpenURL { url in
            if url.absoluteString == "pref://helpkit" {
                showingHelpSheet = true
            }
        }
        .sheet(isPresented: $showingHelpSheet) {
            HelpKitView(topicID: UIDevice.iPhone ? "iph3c50f191" : "ipad997da4cf")
                .ignoresSafeArea(edges: .bottom)
                .interactiveDismissDisabled()
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("BLUETOOTH", tableName: table)
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
