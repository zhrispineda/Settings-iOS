//
//  AirDropView.swift
//  Preferences
//
//  Settings > General > AirDrop
//

import SwiftUI

struct AirDropView: View {
    @AppStorage("AirDropSelection") private var selection = "Receiving Off"
    @AppStorage("AirDropNearbySharing") private var nearbySharingEnabled = true
    @AppStorage("AirDropCellularUsage") private var cellularUsageEnabled = true
    @State private var showingSheet = false
    let options = ["Receiving Off", "Contacts Only", "Everyone for 10 Minutes"]
    let path = "/System/Library/PreferenceBundles/AirDropSettings.bundle"
    
    var body: some View {
        CustomList(title: "AirDrop".localized(path: path)) {
            // AirDrop Visibility Picker Section
            Section {
                Picker("AirDrop Visibility".localized(path: path), selection: $selection) {
                    ForEach(options, id: \.self) { option in
                        Text(option.localized(path: path))
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } footer: {
                Text(.init("AirDrop Learn More Footer WIFI".localized(path: path).replacing("airDropSettingsOBK", with: "pref")))
            }
            
            if UIDevice.iPhone {
                // Start Sharing By Section
                Section {
                    Toggle("Bringing Devices Together".localized(path: path), isOn: $nearbySharingEnabled)
                } header: {
                    Text("Start Sharing By".localized(path: path))
                } footer: {
                    Text("Easily swap numbers with NameDrop, share photos, and more by holding the top of your iPhone close to another iPhone.".localized(path: path))
                }
                
                // Out of Range Section
                Section {
                    Toggle("Use Cellular Data".localized(path: path), isOn: $cellularUsageEnabled)
                } header: {
                    Text("Out of Range".localized(path: path))
                } footer: {
                    Text("Continue to send and receive content when Wi-Fi is not available during AirDrop.".localized(path: path))
                }
                
            }
            
            Section {
                // Missing entitlements to open: contacts-sensitive:///list/other-known
                Button("Manage Known AirDrop Contacts".localized(path: path)) {}
            } footer: {
                Text("You will automatically appear for 30 days to people you have shared a one-time code with.".localized(path: path))
            }
        }
        .onOpenURL { url in
            if url.absoluteString == "pref://" {
                showingSheet = true
            }
        }
        .sheet(isPresented: $showingSheet) {
            OnBoardingKitView(bundleID: "com.apple.onboarding.airdrop")
                .ignoresSafeArea()
        }
    }
}

#Preview {
    NavigationStack {
        AirDropView()
    }
}
