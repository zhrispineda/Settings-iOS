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
    @AppStorage("Handoff") private var handoffEnabled = true
    @AppStorage("CursorKeyboard") private var cursorKeyboardEnabled = true
    @AppStorage("ContinuityCamera") private var continuityCameraEnabled = true
    @AppStorage("AirPlayReceiver") private var airPlayReceiverEnabled = false
    @State private var requirePassword = false
    let table = "AirPlayAndHandoffSettings"
    
    var body: some View {
        CustomList(title: "AirPlay & Continuity".localize(table: table)) {
            Section {
                CustomNavigationLink("Automatically AirPlay".localize(table: table), status: "Automatic".localize(table: table), destination: EmptyView())
            }
            
            if UIDevice.iPhone {
                Section {
                    Toggle("Transfer to HomePod".localize(table: table), isOn: $transferHomePod)
                } footer: {
                    Text("When playing media, bring iPhone close to the top of HomePod to transfer what’s playing.", tableName: table)
                }
            }
            
            Section {
                Toggle("Handoff".localize(table: table), isOn: $handoffEnabled)
            } footer: {
                Text("Handoff lets you start something on one device and instantly pick it up on other devices using your iCloud account. The app you need appears in the app switcher and in the Dock on a Mac.", tableName: table)
            }
            
            if UIDevice.iPad {
                Section {
                    Toggle("Cursor and Keyboard".localize(table: table), isOn: $cursorKeyboardEnabled)
                } footer: {
                    Text("Allow your cursor and keyboard to be used on any nearby Mac signed in to your iCloud account.", tableName: table)
                }
            }
            
            Section {
                Toggle("Continuity Camera".localize(table: table), isOn: $continuityCameraEnabled)
            } footer: {
                Text("Use your Device as a webcam for your Mac when both devices are near each other.", tableName: table)
            }
            
            Section {
                Toggle("AirPlay Receiver".localize(table: table), isOn: $airPlayReceiverEnabled)
                if airPlayReceiverEnabled {
                    CustomNavigationLink("Allow AirPlay For".localize(table: table), status: "Current User".localize(table: table), destination: EmptyView())
                }
            } header: {
                Text("AirPlay Receiver", tableName: table)
            } footer: {
                Text("Stream or share content from your Device to your Device.", tableName: table)
            }
            
            if airPlayReceiverEnabled {
                Toggle("Require Password".localize(table: table), isOn: $requirePassword)
                if requirePassword {
                    Button("Set AirPlay Password".localize(table: table)) {}
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
