//
//  ZoomView.swift
//  Preferences
//
//  Settings > Accessibility > Zoom
//

import SwiftUI

struct ZoomView: View {
    // Variables
    @AppStorage("ZoomToggle") private var zoomEnabled = false
    @AppStorage("FollowFocusToggle") private var followFocusEnabled = true
    @AppStorage("SmartTypingToggle") private var smartTypingEnabled = false
    @AppStorage("ShowMirroringToggle") private var showMirroringEnabled = false
    @AppStorage("MaxZoomLevelValue") private var maxZoomLevel = 5.0
    let accTable = "Accessibility"
    let table = "ZoomSettings"
    
    var body: some View {
        CustomList(title: "ZOOM_TITLE".localize(table: table)) {
            // Zoom
            Section {
                Toggle("ZOOM_TITLE".localize(table: table), isOn: $zoomEnabled)
            } footer: {
                VStack(alignment: .leading) {
                    Text("ZOOM_INTRO".localize(table: table)).bold()
                    Text("ZOOM_INSTRUCTIONS".localize(table: table))
                    Text("PAN_INSTRUCTIONS".localize(table: table))
                    Text("ADJUST_MAG_INSTRUCTIONS".localize(table: table))
                }
            }
            
            // Follow Focus & Smart Typing
            Section {
                Toggle("ZOOM_FOLLOW_FOCUS_TITLE".localize(table: table), isOn: $followFocusEnabled.animation())
                if followFocusEnabled {
                    Toggle("ZOOM_USE_WINDOW_FOR_TYPING_TITLE".localize(table: table), isOn: $smartTypingEnabled)
                }
            } footer: {
                if followFocusEnabled {
                    Text("ZOOM_USE_WINDOW_FOR_TYPING_INSTRUCTIONS".localize(table: table))
                }
            }
            
            Section {
                // Keyboard Shortcuts
                SettingsLink("ZOOM_KEYBOARD_SHORTCUTS_SETTINGS".localize(table: table), status: "ON".localize(table: accTable), destination: EmptyView())
                // Zoom Controller
                SettingsLink("ZOOM_SLUG_SETTINGS".localize(table: table), status: "OFF".localize(table: accTable), destination: EmptyView())
                // Zoom Region
                SettingsLink("ZOOM_LENS_MODE_TITLE".localize(table: table), status: "ZOOM_LENS_MODE_FULLSCREEN".localize(table: table), destination: EmptyView())
                // Zoom Filter
                SettingsLink("ZOOM_FILTER_TITLE".localize(table: table), status: "NONE", destination: EmptyView())
            }
            
            Section {
                // Show while Mirroring
                Toggle("ZOOM_ALLOWS_MIRRORING_TITLE".localize(table: table), isOn: $showMirroringEnabled)
            } footer: {
                Text("ZOOM_ALLOWS_MIRRORING_FOOTER", tableName: table)
            }
            
            Section {
                HStack {
                    Slider(value: $maxZoomLevel, in: 1.2...15.0, step: 0.2)
                    Text("\(maxZoomLevel.formatted(.number.precision(.fractionLength(1))))x")
                        .monospacedDigit()
                        .foregroundStyle(.secondary)
                }
            } header: {
                Text("MAX_PREFERRED_ZOOM_LEVEL_TITLE_FOOTER", tableName: table)
            }
        }
        .animation(.default, value: followFocusEnabled)
    }
}

#Preview {
    NavigationStack {
        ZoomView()
    }
}
