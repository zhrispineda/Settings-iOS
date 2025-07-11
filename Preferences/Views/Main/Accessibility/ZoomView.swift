//
//  ZoomView.swift
//  Preferences
//
//  Settings > Accessibility > Zoom
//

import SwiftUI

struct ZoomView: View {
    @AppStorage("ZoomToggle") private var zoomEnabled = false
    @AppStorage("FollowFocusToggle") private var followFocusEnabled = true
    @AppStorage("SmartTypingToggle") private var smartTypingEnabled = false
    @AppStorage("ShowMirroringToggle") private var showMirroringEnabled = false
    @AppStorage("MaxZoomLevelValue") private var maxZoomLevel = 5.0
    let path = "/System/Library/PreferenceBundles/AccessibilitySettings.bundle"
    let accTable = "Accessibility"
    let table = "ZoomSettings"
    let titles = "AccessibilityTitles"
    
    var body: some View {
        CustomList(title: "ZOOM_TITLE".localized(path: path, table: titles)) {
            // Zoom
            Section {
                Toggle("ZOOM_TITLE".localized(path: path, table: titles), isOn: $zoomEnabled)
            } footer: {
                VStack(alignment: .leading) {
                    Text("ZOOM_INTRO".localized(path: path, table: table)).bold()
                    Text("ZOOM_INSTRUCTIONS".localized(path: path, table: table))
                    Text("PAN_INSTRUCTIONS".localized(path: path, table: table))
                    Text("ADJUST_MAG_INSTRUCTIONS".localized(path: path, table: table))
                }
            }
            
            // Follow Focus & Smart Typing
            Section {
                Toggle("ZOOM_FOLLOW_FOCUS_TITLE".localized(path: path, table: table), isOn: $followFocusEnabled.animation())
                if followFocusEnabled {
                    Toggle("ZOOM_USE_WINDOW_FOR_TYPING_TITLE".localized(path: path, table: table), isOn: $smartTypingEnabled)
                }
            } footer: {
                if followFocusEnabled {
                    Text("ZOOM_USE_WINDOW_FOR_TYPING_INSTRUCTIONS".localized(path: path, table: table))
                }
            }
            
            Section {
                // Keyboard Shortcuts
                SettingsLink("ZOOM_KEYBOARD_SHORTCUTS_SETTINGS".localized(path: path, table: table), status: "ON".localized(path: path, table: accTable), destination: EmptyView())
                // Zoom Controller
                SettingsLink("ZOOM_SLUG_SETTINGS".localized(path: path, table: table), status: "OFF".localized(path: path, table: accTable), destination: EmptyView())
                // Zoom Region
                SettingsLink("ZOOM_LENS_MODE_TITLE".localized(path: path, table: table), status: "ZOOM_LENS_MODE_FULLSCREEN".localized(path: path, table: table), destination: EmptyView())
                // Zoom Filter
                SettingsLink("ZOOM_FILTER_TITLE".localized(path: path, table: table), status: "None".localized(path: path), destination: EmptyView())
            }
            
            Section {
                // Show while Mirroring
                Toggle("ZOOM_ALLOWS_MIRRORING_TITLE".localized(path: path, table: table), isOn: $showMirroringEnabled)
            } footer: {
                Text("ZOOM_ALLOWS_MIRRORING_FOOTER".localized(path: path, table: table))
            }
            
            Section {
                HStack {
                    Slider(value: $maxZoomLevel, in: 1.2...15.0, step: 0.2)
                    Text("\(maxZoomLevel.formatted(.number.precision(.fractionLength(1))))x")
                        .monospacedDigit()
                        .foregroundStyle(.secondary)
                }
            } header: {
                Text("MAX_PREFERRED_ZOOM_LEVEL_TITLE_FOOTER".localized(path: path, table: table))
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
