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
            Section(content: {
                Toggle("Bluetooth", isOn: $bluetoothEnabled.animation())
            }, footer: {
                if bluetoothEnabled {
                    Text("This \(UIDevice().localizedModel) is discoverable as \u{201C}\(UIDevice().localizedModel)\u{201D} while Bluetooth Settings is open.")
                } else {
                    Text("AirDrop, AirPlay, Find My, and Location Services use Bluetooth.")
                }
            })
            
            if bluetoothEnabled {
                Section(content: {
                    EmptyView()
                }, header: {
                    HStack {
                        Text("Devices")
                        ProgressView()
                            .padding(.horizontal, 1)
                    }
                })
            }
        }
    }
}

#Preview {
    NavigationStack {
        BluetoothView()
    }
}
