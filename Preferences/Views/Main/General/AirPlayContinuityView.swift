//
//  AirPlayContinuityView.swift
//  Preferences
//
//  Settings > General > AirPlay & Continuity
//

import SwiftUI

struct AirPlayContinuityView: View {
    // Variables
    @State private var transferHomePod = false
    @State private var handoffEnabled = true
    @State private var cursorKeyboardEnabled = true
    @State private var continuityCameraEnabled = false
    @State private var airPlayReceiverEnabled = false
    @State private var requirePassword = false
    
    var body: some View {
        CustomList(title: "AirPlay & Continuity") {
            Section {
                CustomNavigationLink(title: "Automatically AirPlay", status: "Never", destination: EmptyView())
            }
            
            if UIDevice.iPhone {
                Section {
                    Toggle("Transfer to HomePod", isOn: $transferHomePod)
                } footer: {
                    Text("When playing media, bring iPhone close to the top of HomePod to transfer what‘s playing.")
                }
            }
            
            Section {
                Toggle("Handoff", isOn: $handoffEnabled)
            } footer: {
                Text("Handoff lets you start something on one device and instantly pick it up on other devices using your iCloud account. The app you need appears in the app switcher and in the Dock on a Mac.")
            }
            
            if UIDevice.iPad {
                Section {
                    Toggle("Cursor and Keyboard", isOn: $cursorKeyboardEnabled)
                } footer: {
                    Text("Allow your cursor and keyboard to be used on any nearby Mac signed in to your iCloud account.")
                }
            }
            
            Section {
                Toggle("Continuity Camera", isOn: $continuityCameraEnabled)
            } footer: {
                if UIDevice.iPhone {
                    Text("Use your iPhone as a webcam for your Mac when both devices are near each other.")
                } else {
                    Text("Use your iPad as a webcam for your Apple TV when both devices are near each other.")
                }
            }
            
            Section {
                Toggle("AirPlay Receiver", isOn: $airPlayReceiverEnabled)
                if airPlayReceiverEnabled {
                    CustomNavigationLink(title: "Allow AirPlay For", status: "Current User", destination: EmptyView())
                }
            } header: {
                Text("AirPlay Receiver")
            } footer: {
                Text("Stream or share content from Apple Vision Pro to your \(UIDevice.current.model).")
            }
            
            if airPlayReceiverEnabled {
                Toggle("Require Password", isOn: $requirePassword)
                if requirePassword {
                    Button("Set AirPlay Password") {}
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AirPlayContinuityView()
    }
}
