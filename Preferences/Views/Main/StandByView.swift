//
//  StandByView.swift
//  Preferences
//
//  Settings > StandBy
//

import SwiftUI

struct StandByView: View {
    // Variables
    @State private var standByEnabled = true
    @State private var nightModeEnabled = true
    @State private var showNotificationsEnabled = true
    @State private var showPreviewsTapOnlyEnabled = false
    
    var body: some View {
        CustomList(title: "StandBy") {
            Section {
                Toggle("StandBy", isOn: $standByEnabled.animation())
            } footer: {
                Text("StandBy will turn on when iPhone is placed on its side, while charging to show information like widgets, photo frames, or clocks.")
            }
            
            if standByEnabled {
                if Device().hasAlwaysOnDisplay {
                    NavigationLink("Display", destination: DisplayView())
                } else {
                    Section {
                        Toggle("Night Mode", isOn: $nightModeEnabled)
                    } header: {
                        Text("Display")
                    } footer: {
                        Text("StandBy displays with a red tint in low ambient lighting.")
                    }
                }
                
                Section {
                    Toggle("Show Notifications", isOn: $showNotificationsEnabled.animation())
                } header: {
                    Text("Notifications")
                } footer: {
                    Text("Critical notifications will still be shown in StandBy if this switch is off.")
                }
                
                if showNotificationsEnabled {
                    Section {
                        Toggle("Show Preview on Tap Only", isOn: $showPreviewsTapOnlyEnabled)
                    } footer: {
                        Text("StandBy can hide the preview of a notification until you tap on it.")
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        StandByView()
    }
}
