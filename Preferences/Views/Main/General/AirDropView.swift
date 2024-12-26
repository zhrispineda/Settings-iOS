//
//  AirDropView.swift
//  Preferences
//
//  Settings > General > AirDrop
//

import SwiftUI

struct AirDropView: View {
    // Variables
    @AppStorage("AirDropSelection") private var selection = "Receiving Off"
    @AppStorage("AirDropNearbySharing") private var nearbySharingEnabled = true
    @AppStorage("AirDropCellularUsage") private var cellularUsageEnabled = true
    @State private var showingSheet = false
    let options = ["Receiving Off", "Contacts Only", "Everyone for 10 Minutes"]
    let table = "AirDropSettings"
    
    var body: some View {
        CustomList(title: "AirDrop".localize(table: table)) {
            // AirDrop Visibility Picker Section
            Section {
                Picker("AirDrop Visibility", selection: $selection) {
                    ForEach(options, id: \.self) { option in
                        Text(option.localize(table: table))
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } footer: {
                Text("AirDrop Learn More Footer WIFI", tableName: table)
            }
            
            if UIDevice.iPhone {
                // Start Sharing By Section
                Section {
                    Toggle("Bringing Devices Together".localize(table: table), isOn: $nearbySharingEnabled)
                } header: {
                    Text("Start Sharing By", tableName: table)
                } footer: {
                    Text("Easily swap numbers with NameDrop, share photos, and more by holding the top of your iPhone close to another iPhone.", tableName: table)
                }
                
                // Out of Range Section
                Section {
                    Toggle("Use Cellular Data".localize(table: table), isOn: $cellularUsageEnabled)
                } header: {
                    Text("Out of Range", tableName: table)
                } footer: {
                    Text("Continue to send and receive content when Wi-Fi is not available during AirDrop.", tableName: table)
                }
            }
        }
        .onOpenURL { url in
            if url.scheme == "airDropSettingsOBK" {
                showingSheet = true
            }
        }
        .sheet(isPresented: $showingSheet) {
            OnBoardingView(table: "AirDrop")
        }
    }
}

#Preview {
    NavigationStack {
        AirDropView()
    }
}
