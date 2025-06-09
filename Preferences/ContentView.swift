//
//  ContentView.swift
//  Preferences
//
//  Settings
//

import SwiftUI
import TipKit

struct ContentView: View {
    // Variables
    @AppStorage("SiriEnabled") private var siriEnabled = false
    @AppStorage("FollowUpDismissed") private var followUpDismissed = false
    @AppStorage("AirplaneMode") private var airplaneModeEnabled = false
    @AppStorage("WiFi") private var wifiEnabled = true
    @AppStorage("Bluetooth") private var bluetoothEnabled = true
    @AppStorage("VPNToggle") private var VPNEnabled = true
    @State private var stateManager = StateManager()
    @State private var searchFocused = false
    @State private var searchText = ""
    @State private var showingSignInSheet = false
    @State private var isLandscape = false
    @State private var id = UUID()
    @State private var preloadRect = true
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.primary
                    .opacity(0.3)
                    .ignoresSafeArea()
                HStack(spacing: 0.25) {
                    NavigationStack(path: $stateManager.path) {
                        // MARK: - iPadOS Settings
                        if UIDevice.iPad {
                            List(selection: $stateManager.selection) {
                                if !preloadRect {
                                    Section {
                                        Rectangle()
                                            .foregroundStyle(Color.clear)
                                            .listRowBackground(Color.clear)
                                            .frame(height: 25)
                                    }
                                }
                                
                                Button {
                                    showingSignInSheet.toggle()
                                } label: {
                                    AppleAccountSection()
                                }
                                .foregroundStyle(.primary)
                                
                                if siriEnabled && UIDevice.IntelligenceCapability {
                                    // MARK: TipKit Section
                                    Section {
                                        ImageCreationTipView()
                                    }
                                }
                                
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
                                        IconToggle("Airplane Mode", isOn: $airplaneModeEnabled, color: Color.orange, icon: "airplane")
                                        ForEach(radioSettings) { setting in
                                            if !phoneOnly.contains(setting.id) && requiredCapabilities(capability: setting.capability) {
                                                Button {
                                                    id = UUID() // Reset destination
                                                    stateManager.selection = setting.type
                                                } label: {
                                                    SLabel(setting.id, color: setting.color, icon: setting.icon, status: setting.id == "Wi-Fi" ? (wifiEnabled && !airplaneModeEnabled ? "Not Connected" : "Off") : setting.id == "Bluetooth" ? (bluetoothEnabled ? "On" : "Off") : "")
                                                }
                                                .foregroundColor(.primary)
                                                .listRowBackground(stateManager.selection == setting.type ? (UIDevice.IsSimulator ? Color.blue : .selected) : nil)
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
                            .navigationTitle("Settings")
                            .onAppear {
                                isLandscape = geometry.size.width > geometry.size.height
                                
                                Task {
                                    withAnimation { preloadRect = false }
                                    try await Task.sleep(for: .seconds(1))
                                    withAnimation { preloadRect = true }
                                }
                            }
                            .sheet(isPresented: $showingSignInSheet) {
                                NavigationStack {
                                    SelectSignInOptionView()
                                        .interactiveDismissDisabled()
                                }
                            }
                            .searchable(text: $searchText, isPresented: $searchFocused, placement: .navigationBarDrawer(displayMode: .automatic))
                            .overlay {
                                if searchFocused {
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
                            .onChange(of: geometry.size.width) {
                                isLandscape = geometry.size.width > geometry.size.height
                            }
                            .onChange(of: stateManager.selection) { // Change views when selecting sidebar navigation links
                                if let selectedSettingsItem = combinedSettings.first(where: { $0.type == stateManager.selection }) {
                                    stateManager.destination = selectedSettingsItem.destination
                                }
                            }
                        } else {
                            // MARK: - iOS Settings
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
                                
                                if siriEnabled && UIDevice.IntelligenceCapability {
                                    // MARK: TipKit Section
                                    Section {
                                        ImageCreationTipView()
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
                                        IconToggle("Airplane Mode", isOn: $airplaneModeEnabled, color: Color.orange, icon: "airplane")
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
                    .frame(maxWidth: UIDevice.iPad ? (isLandscape ? 415 : 375) : nil)
                    if UIDevice.iPad {
                        NavigationStack(path: $stateManager.path) {
                            stateManager.destination
                                .navigationDestination(for: AnyRoute.self) { route in
                                    route.destination()
                                }
                        }
                        .id(id)
                    }
                }
            }
            .onAppear {
                try? Tips.configure()
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
    ContentView()
}
