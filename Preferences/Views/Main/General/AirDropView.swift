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
    @State private var nearbySharingEnabled = true
    @State private var cellularUsageEnabled = true
    let options = ["Receiving Off", "Contacts Only", "Everyone for 10 Minutes"]
    let table = "AirDropSettings"
    
    var body: some View {
        CustomList(title: "AirDrop".localize(table: table)) {
            Section {
                Picker("", selection: $selection) {
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
                Section {
                    Toggle("Bringing Devices Together".localize(table: table), isOn: $nearbySharingEnabled)
                } header: {
                    Text("Start Sharing By", tableName: table)
                } footer: {
                    Text("Easily swap numbers with NameDrop, share photos, and more by holding the top of your iPhone close to another iPhone.", tableName: table)
                }
                
                Section {
                    Toggle("Use Cellular Data".localize(table: table), isOn: $cellularUsageEnabled)
                } header: {
                    Text("Out of Range", tableName: table)
                } footer: {
                    Text("Continue to send and receive content when Wi-Fi is not available during AirDrop.", tableName: table)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AirDropView()
    }
}
