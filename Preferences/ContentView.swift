//
//  ContentView.swift
//  Preferences
//
//  Settings
//

import SwiftUI

struct ContentView: View {
    @AppStorage("FollowUpDismissed") private var followUpDismissed = false
    @AppStorage("AirplaneMode") private var airplaneModeEnabled = false
    @AppStorage("WiFi") private var wifiEnabled = true
    @AppStorage("Bluetooth") private var bluetoothEnabled = true
    @AppStorage("VPNToggle") private var VPNEnabled = true
    @Bindable var stateManager: StateManager
    @State private var searchFocused = false
    @State private var searchText = ""
    @State private var showingSignInSheet = false
    @State private var id = UUID()
    
    var body: some View {
        // MARK: iPadOS Layout
        if UIDevice.iPad {
            NavigationSplitView {
                List(selection: $stateManager.selection) {
                    Button {
                        showingSignInSheet.toggle()
                    } label: {
                        AppleAccountSection()
                    }
                    .foregroundStyle(.primary)
                    
                    if !followUpDismissed && !UIDevice.IsSimulator {
                        Section {
                            Button {
                                id = UUID() // Reset destination
                                stateManager.selection = .followUp
                            } label: {
                                SLabel("FOLLOWUP_TITLE".localize(table: "FollowUp"), badgeCount: 1)
                                    .foregroundStyle(Color(UIColor.label))
                            }
                        }
                    }

                    // MARK: Radio Settings
                    if !UIDevice.IsSimulator {
                        Section {
                            IconToggle("Airplane Mode", isOn: $airplaneModeEnabled, color: Color.orange, icon: "com.apple.graphic-icon.airplane-mode")
                            ForEach(radioSettings) { setting in
                                if !phoneOnly.contains(setting.id) && requiredCapabilities(capability: setting.capability) {
                                    Button {
                                        id = UUID() // Reset destination
                                        stateManager.selection = setting.type
                                    } label: {
                                        SLabel(setting.id, color: setting.color, icon: setting.icon, status: setting.id == "Wi-Fi" ? (wifiEnabled && !airplaneModeEnabled ? "Not Connected" : "Off") : setting.id == "Bluetooth" ? (bluetoothEnabled ? "On" : "Off") : "")
                                    }
                                    .foregroundStyle(stateManager.selection == setting.type ? .blue : .primary)
                                    .listRowBackground(
                                        Color(stateManager.selection == setting.type ? (UIDevice.IsSimulator ? .blue : .selected) : .clear)
                                            .clipShape(RoundedRectangle(cornerRadius: 30, style: .circular))
                                    )
                                }
                            }
                            if requiredCapabilities(capability: .vpn) {
                                IconToggle("VPN", isOn: $VPNEnabled, color: .blue, icon: "network.connected.to.line.below")
                            }
                        }
                    }
                    
                    // MARK: Main
                    SettingsLabelSection(selection: $stateManager.selection, id: $id, item: UIDevice.IsSimulator ? simulatorMainSettings : mainSettings)
                    
                    // MARK: Attention
                    SettingsLabelSection(selection: $stateManager.selection, id: $id, item: UIDevice.IsSimulator ? attentionSimulatorSettings : attentionSettings)
                    
                    // MARK: Security
                    SettingsLabelSection(selection: $stateManager.selection, id: $id, item: UIDevice.IsSimulator ? simulatorSecuritySettings : securitySettings)
                    
                    // MARK: Services
                    SettingsLabelSection(selection: $stateManager.selection, id: $id, item: UIDevice.IsSimulator ? simulatorServiceSettings : serviceSettings)
                    
                    // MARK: Apps
                    SettingsLabelSection(selection: $stateManager.selection, id: $id, item: appsSettings)
                    
                    // MARK: Developer
                    SettingsLabelSection(selection: $stateManager.selection, id: $id, item: developerSettings)
                }
                .toolbar(removing: .sidebarToggle)
                .navigationTitle("Settings")
                .sheet(isPresented: $showingSignInSheet) {
                    NavigationStack {
                        SelectSignInOptionView()
                            .interactiveDismissDisabled()
                    }
                }
                .searchable(text: $searchText, isPresented: $searchFocused, placement: .navigationBarDrawer(displayMode: .always))
                .overlay {
                    if searchFocused && !searchText.isEmpty {
                        GeometryReader { geo in
                            List {
                                if searchText.isEmpty {
                                    Section("Suggestions") {}
                                } else {
                                    ContentUnavailableView.search(text: searchText)
                                        .frame(minHeight: 0, idealHeight: geo.size.height, maxHeight: .infinity)
                                        .edgesIgnoringSafeArea(.all)
                                        .listRowSeparator(.hidden)
                                }
                            }
                            .scrollDisabled(!searchText.isEmpty)
                            .listStyle(.inset)
                        }
                    }
                }
                .onChange(of: stateManager.selection) { // Change views when selecting sidebar navigation links
                    if let selectedSettingsItem = combinedSettings.first(where: { $0.type == stateManager.selection }) {
                        stateManager.destination = selectedSettingsItem.destination
                    }
                }
            } detail: {
                NavigationStack(path: $stateManager.path) {
                    stateManager.destination
                        .navigationDestination(for: AnyRoute.self) { route in
                            route.destination()
                        }
                }
                .id(id)
            }
        } else {
            // MARK: iOS Layout
            NavigationStack(path: $stateManager.path) {
                List {
                    Section { // Apple Account Section
                        Button {
                            showingSignInSheet.toggle()
                        } label: {
                            NavigationLink{} label: {
                                AppleAccountSection()
                            }
                        }
                        .foregroundStyle(.primary)
                        .sheet(isPresented: $showingSignInSheet) {
                            NavigationStack {
                                SelectSignInOptionView()
                                    .interactiveDismissDisabled()
                            }
                        }
                    }
                    
                    if !followUpDismissed && !UIDevice.IsSimulator {
                        Section {
                            SLink("FOLLOWUP_TITLE".localize(table: "FollowUp"), icon: "None", badgeCount: 1) {
                                FollowUpView()
                            }
                        }
                    }

                    if !UIDevice.IsSimulator {
                        // MARK: Radio Settings
                        Section {
                            IconToggle("Airplane Mode", isOn: $airplaneModeEnabled, icon: "com.apple.graphic-icon.airplane-mode")
                            ForEach(radioSettings) { setting in
                                if setting.capability == .none {
                                    SLink(setting.id, color: setting.color, icon: setting.icon, status: setting.id == "Wi-Fi" ? (wifiEnabled && !airplaneModeEnabled ? "Not Connected" : "Off") : setting.id == "Bluetooth" ? (bluetoothEnabled ? "On" : "Off") : "") {
                                        setting.destination
                                    }
                                    .accessibilityLabel(setting.id)
                                } else if requiredCapabilities(capability: setting.capability) {
                                    SLink(setting.id, color: setting.color, icon: setting.icon, status: setting.id == "Cellular" && airplaneModeEnabled ? "Airplane Mode" : setting.id == "Personal Hotspot" ? "Off" : "") {
                                        setting.destination
                                    }
                                    .disabled(setting.id == "Personal Hotspot" && airplaneModeEnabled)
                                    .accessibilityLabel(setting.id)
                                }
                            }
                            if requiredCapabilities(capability: .vpn) {
                                IconToggle("VPN", isOn: $VPNEnabled, color: .blue, icon: "network.connected.to.line.below")
                            }
                        }
                    }
                    
                    // MARK: Main Settings
                    SettingsLinkSection(item: UIDevice.IsSimulator ? simulatorMainSettings : mainSettings)
                    
                    // MARK: Attention
                    SettingsLinkSection(item: UIDevice.IsSimulator ? attentionSimulatorSettings : attentionSettings)
                    
                    // MARK: Security
                    SettingsLinkSection(item: UIDevice.IsSimulator ? simulatorSecuritySettings : securitySettings)
                    
                    // MARK: Services
                    SettingsLinkSection(item: UIDevice.IsSimulator ? simulatorServiceSettings : serviceSettings)
                    
                    // MARK: Apps
                    SettingsLinkSection(item: appsSettings)
                    
                    // MARK: Developer
                    if UIDevice.IsSimulator || configuration.developerMode {
                        SettingsLinkSection(item: developerSettings)
                    }
                }
                .navigationDestination(for: AnyRoute.self) { route in
                    route.destination()
                }
                .navigationTitle("Settings")
                .searchable(text: $searchText, isPresented: $searchFocused, placement: .automatic)
                .overlay {
                    if searchFocused {
                        GeometryReader { geo in
                            List {
                                if searchText.isEmpty {
                                    SettingsSearchView(stateManager: stateManager)
                                } else {
                                    ContentUnavailableView.search(text: searchText)
                                        .frame(minHeight: 0, idealHeight: geo.size.height, maxHeight: .infinity)
                                        .edgesIgnoringSafeArea(.all)
                                        .listRowSeparator(.hidden)
                                }
                            }
                            .scrollDisabled(!searchText.isEmpty)
                            .listStyle(.inset)
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Required Capabilities Check
@MainActor
func requiredCapabilities(capability: Capabilities) -> Bool {
    switch capability {
    case .actionButton:
        return UIDevice.RingerButtonCapability
    case .appleIntelligence:
        return UIDevice.IntelligenceCapability
    case .cellular:
        return UIDevice.CellularTelephonyCapability
    case .ethernet:
        return false
    case .faceID:
        return UIDevice.PearlIDCapability
    case .isInternal:
        return false
    case .none:
        return true
    case .siri:
        return !UIDevice.IntelligenceCapability
    case .sounds:
        return UIDevice.iPad
    case .soundsHaptics:
        return UIDevice.iPhone
    case .touchID:
        return !UIDevice.PearlIDCapability
    case .vpn:
        return false
    }
}

#Preview {
    ContentView(stateManager: StateManager())
        .environment(StateManager())
}
