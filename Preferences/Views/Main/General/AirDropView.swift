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
    
    var body: some View {
        CustomList(title: "AirDrop") {
            Section {
                Picker("", selection: $selection) {
                    ForEach(options, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } footer: {
                Text("AirDrop lets you share instantly with people nearby. You can be discoverable in AirDrop to receive from everyone or only people in your contacts. [Learn More...](#)")
            }
            
            if UIDevice.iPhone {
                Section {
                    Toggle("Bringing Devices Together", isOn: $nearbySharingEnabled)
                } header: {
                    Text("Start Sharing By")
                } footer: {
                    Text("Easily swap numbers with NameDrop, share photos, and more by holding the top of your iPhone close to another iPhone.")
                }
                
                Section {
                    Toggle("Use Cellular Data", isOn: $cellularUsageEnabled)
                } header: {
                    Text("Out of Range")
                } footer: {
                    Text("Continue to send and receive content when Wi-Fi is not available during AirDrop.")
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
