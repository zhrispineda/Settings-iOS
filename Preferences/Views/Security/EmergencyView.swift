//
//  EmergencyView.swift
//  Preferences
//
//  Settings > Emergency SOS
//

import SwiftUI

struct EmergencyView: View {
    // Variables
    @State private var callHoldRelease = true
    @State private var callButtonPresses = false
    @State private var callQuietly = false
    
    var body: some View {
        CustomList(title: "EMERGENCY_SOS".localize(table: "SOS")) {
            Section {
                Text("")
            } footer: {
                Text("PHONE_TRIGGER_ANIMATION_VOLUME_LOCK_HOLD_FOOTER_REQUIRE_SIM", tableName: "SOS")
            }
            
            Section {
                Toggle("CALL_WITH_HOLD_AND_RELEASE".localize(table: "SOS"), isOn: $callHoldRelease.animation())
            } footer: {
                Text("CALL_WITH_HOLD_FOOTER", tableName: "SOS")
            }
            
            Section {
                Toggle("CALL_WITH_FIVE_PRESSES".localize(table: "SOS"), isOn: $callButtonPresses)
            } footer: {
                Text("CALL_WITH_FIVE_PRESSES_FOOTER", tableName: "SOS")
            }
            
            if callHoldRelease {
                Section {
                    Toggle("ALARM_SOUND".localize(table: "SOS"), isOn: $callQuietly)
                } footer: {
                    Text("ALARM_SOUND_RELEASE_TO_CALL_FIVE_PRESSES_FOOTER", tableName: "SOS")
                }
            }
            
            Section {
                Button("OPEN_HEALTH_NO_EMERGENCY_CONTACTS".localize(table: "SOS")) {}
            } footer: {
                Text(.init("SOS_PRIVACY_NO_EMERGENCY_CONTACTS".localize(table: "SOS", "[\("SOS_PRIVACY_LINK".localize(table: "SOS"))](#)")))
            }
        }
    }
}

#Preview {
    NavigationStack {
        EmergencyView()
    }
}
