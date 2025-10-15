//
//  SettingsLinkSection.swift
//  Preferences
//
//  Settings
//

import SwiftUI

/// Settings Link for iOS
struct SettingsLinkSection: View {
    @AppStorage("AirplaneMode") private var airplaneModeEnabled = false
    @AppStorage("WiFi") private var wifiEnabled = true
    @AppStorage("Bluetooth") private var bluetoothEnabled = true
    @Environment(StateManager.self) private var stateManager
    @State private var showingSignInSheet = false
    var item: [SettingsItem]
    
    var body: some View {
        Section {
            ForEach(item) { setting in
                if setting.type == .icloud {
                    Button {
                        showingSignInSheet.toggle()
                    } label: {
                        SLink(setting.title, color: setting.color, icon: setting.icon) {
                            setting.destination
                        }
                    }
                    .accessibilityLabel(setting.title)
                    .foregroundStyle(.primary)
                    .sheet(isPresented: $showingSignInSheet) {
                        NavigationStack {
                            SelectSignInOptionView()
                                .interactiveDismissDisabled()
                        }
                    }
                } else if !stateManager.tabletOnly.contains(setting.title) && requiredCapabilities(capability: setting.capability) {
                    switch setting.kind {
                    case .link:
                        SLink(setting.title, color: setting.color, icon: setting.icon, status: status(for: setting)) {
                            setting.destination
                        }
                        .accessibilityLabel(setting.title)
                    case .toggle(let key):
                        IconToggle(
                            setting.title,
                            isOn: appStorageBinding(forKey: key),
                            icon: setting.icon
                        )
                    }
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
    
    private func appStorageBinding(forKey key: String) -> Binding<Bool> {
        Binding(
            get: { UserDefaults.standard.bool(forKey: key) },
            set: { UserDefaults.standard.set($0, forKey: key) }
        )
    }
}

