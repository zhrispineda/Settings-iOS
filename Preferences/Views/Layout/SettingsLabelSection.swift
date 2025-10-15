//
//  SettingsLabelSection.swift
//  Preferences
//
//  Settings
//

import SwiftUI

/// Settings Sidebar Label for iPadOS
struct SettingsLabelSection: View {
    @AppStorage("AirplaneMode") private var airplaneModeEnabled = false
    @AppStorage("WiFi") private var wifiEnabled = true
    @AppStorage("Bluetooth") private var bluetoothEnabled = true
    @Environment(StateManager.self) private var stateManager
    @Binding var selection: SettingsItem?
    @State private var showingSignInSheet = false
    let item: [SettingsItem]
    
    var body: some View {
        Section {
            ForEach(item) { setting in
                if setting.type == .icloud {
                    Button {
                        showingSignInSheet.toggle()
                    } label: {
                        SLabel(setting.title, color: setting.color, icon: setting.icon)
                    }
                    .foregroundStyle(.primary)
                    .sheet(isPresented: $showingSignInSheet) {
                        NavigationStack {
                            SelectSignInOptionView()
                                .interactiveDismissDisabled()
                        }
                    }
                } else if !stateManager.phoneOnly.contains(setting.title) && requiredCapabilities(capability: setting.capability) {
                    Button {
                        if selection != setting {
                            selection = setting
                        } else {
                            stateManager.path = []
                        }
                    } label: {
                        SLabel(
                            setting.title,
                            icon: setting.icon,
                            status: status(for: setting),
                            selected: isSelected(setting)
                        )
                    }
                    .foregroundStyle(selection == setting ? .blue : .primary)
                    .listRowBackground(
                        Color(selection == setting ? (UIDevice.IsSimulator ? .blue : .selected) : .clear)
                            .clipShape(RoundedRectangle(cornerRadius: 30, style: .circular))
                    )
                }
            }
        }
    }
    
    func status(for setting: SettingsItem) -> String {
        switch setting.type {
        case .wifi:
            return (wifiEnabled && !airplaneModeEnabled) ? "Not Connected" : "Off"
        case .bluetooth:
            return bluetoothEnabled ? "On" : "Off"
        case .cellular:
            return airplaneModeEnabled ? "Airplane Mode" : ""
        default:
            return ""
        }
    }
    
    func isSelected(_ setting: SettingsItem) -> Bool {
        switch setting.type {
        case .wifi:
            return stateManager.selection?.type == .wifi
        case .bluetooth:
            return stateManager.selection?.type == .bluetooth
        default:
            return false
        }
    }
}
