//
//  SettingsGroup.swift
//  Preferences
//
//  Settings
//

import SwiftUI

/// Settings Sidebar Template
struct SettingsGroup: View {
    @AppStorage("AirplaneMode") private var airplaneModeEnabled = false
    @AppStorage("WiFi") private var wifiEnabled = true
    @AppStorage("Bluetooth") private var bluetoothEnabled = true
    @Environment(PrimarySettingsListModel.self) private var model
    @State private var showingSignInError = false
    @State private var showingSignInSheet = false
    let group: [SettingsItem]
    
    init(_ item: [SettingsItem]) {
        self.group = item
    }
    
    var body: some View {
        Section {
            ForEach(group) { setting in
                if setting.type == .iCloud {
                    Button {
                        if model.isConnected {
                            showingSignInSheet.toggle()
                        } else {
                            SettingsLogger.info("Presenting Network Alert.")
                            showingSignInError.toggle()
                        }
                    } label: {
                        NavigationLink {} label: {
                            SLabel(setting.title, icon: setting.icon)
                        }
                        .navigationLinkIndicatorVisibility(UIDevice.iPad && !model.isCompact ? .hidden : .visible)
                    }
                    .padding(.vertical, -5)
                    .alert(.connectToTheInternetToSignInToYourDevice, isPresented: $showingSignInError) {
                        Button(.ok) {}
                    }
                    .sheet(isPresented: $showingSignInSheet) {
                        NavigationStack {
                            SelectSignInOptionView()
                                .interactiveDismissDisabled()
                        }
                    }
                } else if requiredCapabilities(capabilities: setting.capabilities) {
                    switch setting.kind {
                    case .link:
                        if UIDevice.iPhone || model.isCompact {
                            NavigationLink {
                                setting.destination
                            } label: {
                                SLabel(
                                    setting.title,
                                    icon: setting.icon,
                                    status: status(for: setting),
                                    badgeCount: setting.badgeCount,
                                    selected: false
                                )
                            }
                            .accessibilityIdentifier("com.apple.settings.\(setting.type)")
                            .navigationLinkIndicatorVisibility(.visible)
                            .foregroundStyle(.primary)
                            .padding(.vertical, -5)
                        } else {
                            Button {
                                if model.selection != setting {
                                    model.selection = setting
                                } else {
                                    model.path = []
                                }
                            } label: {
                                SLabel(
                                    setting.title,
                                    icon: setting.icon,
                                    status: status(for: setting),
                                    badgeCount: setting.badgeCount,
                                    selected: isSelected(setting)
                                )
                            }
                            .foregroundStyle(model.selection == setting ? .blue : .primary)
                            .modifier(listRowBackgroundEffect(
                                isActive: UIDevice.iPad && !model.isCompact,
                                isSelected: model.selection == setting
                            ))
                        }
                    case .toggle(let key):
                        IconToggle(
                            setting.title,
                            isOn: appStorageBinding(forKey: key),
                            icon: setting.icon
                        )
                    }
                } else {
                    let _ = SettingsLogger.log("Not including \(setting.type) due to being hidden.")
                }
            }
        }
    }
    
    private func status(for setting: SettingsItem) -> String {
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
    
    private func isSelected(_ setting: SettingsItem) -> Bool {
        switch setting.type {
        case .wifi:
            return model.selection?.type == .wifi
        case .bluetooth:
            return model.selection?.type == .bluetooth
        default:
            return false
        }
    }
    
    private func appStorageBinding(forKey key: String) -> Binding<Bool> {
        Binding(
            get: { UserDefaults.standard.bool(forKey: key) },
            set: { UserDefaults.standard.set($0, forKey: key) }
        )
    }
    
    private func requiredCapabilities(capabilities: [Capabilities]) -> Bool {
        if capabilities.isEmpty { return true }
        
        return capabilities.allSatisfy { requiredCapability in
            hasCapability(requiredCapability)
        }
    }

    private func hasCapability(_ capability: Capabilities) -> Bool {
        switch capability {
        case .none:
            return true
        case .actionButton:
            return UIDevice.ActionModeCapability
        case .cellular:
            return UIDevice.CellularTelephonyCapability || configuration.forceCellular
        case .ethernet:
            return false
        case .faceID:
            return UIDevice.PearlIDCapability
        case .hotspot:
            return UIDevice.CellularTelephonyCapability || configuration.forceCellular
        case .vpn:
            return false
        case .phone:
            return UIDevice.iPhone
        case .tablet:
            return UIDevice.iPad
        case .satellite:
            return false
        case .siri:
            return !UIDevice.IntelligenceCapability
        case .sounds:
            return UIDevice.iPad
        case .soundsHaptics:
            return UIDevice.iPhone
        case .touchID:
            return !UIDevice.PearlIDCapability
        case .appleIntelligence:
            return UIDevice.IntelligenceCapability
        case .isInternal:
            return false
        case .isPhysical:
            return !UIDevice.IsSimulator || configuration.forcePhysical
        case .developerMode:
            return UIDevice.IsSimulator || configuration.developerMode
        case .isSimulator:
            return UIDevice.IsSimulator
        case .carrierInstall:
            return false
        case .faceTimeDebugging:
            return model.showingFaceTimeDebugging
        case .iMessageDebugging:
            return model.showingMessageDebugging
        case .continuityDebugging:
            return model.showingContinuityDebugging
        case .accessoryDeveloper:
            return model.showingAccessoryDeveloper
        }
    }
}

private struct listRowBackgroundEffect: ViewModifier {
    let isActive: Bool
    let isSelected: Bool
    
    func body(content: Content) -> some View {
        if isActive {
            content
                .listRowBackground(
                    Color(isSelected ? (UIDevice.IsSimulator ? .blue : Color(UIColor.systemFill)) : .clear)
                        .clipShape(RoundedRectangle(cornerRadius: 30, style: .circular))
                )
        } else {
            content
        }
    }
}

#Preview {
    ContentView()
        .environment(PrimarySettingsListModel())
}
