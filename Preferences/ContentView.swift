//
//  ContentView.swift
//  Preferences
//
//  Settings
//

import SwiftUI
import TipKit

// Variables
let phoneOnly = ["Action Button", "Emergency SOS", "Health", "Personal Hotspot", "StandBy"]
let tabletOnly = ["Apple Pencil", "Multitasking & Gestures"]

struct ContentView: View {
    // Variables
    @AppStorage("SiriEnabled") private var siriEnabled = false
    @EnvironmentObject var stateManager: StateManager
    @State private var searchFocused = false
    @State private var searchText = String()
    @State private var showingSignInSheet = false
    @State private var isOnLandscapeOrientation: Bool = UIDevice.current.orientation.isLandscape
    @State private var id = UUID()
    @State private var preloadRect = false
    @AppStorage("FollowUpDismissed") private var followUpDismissed = false
    @AppStorage("AirplaneMode") private var airplaneModeEnabled = false
    @AppStorage("wifi") private var wifiEnabled = true
    @AppStorage("bluetooth") private var bluetoothEnabled = true
    @AppStorage("vpn") private var vpnEnabled = false
    
    init() {
        try? Tips.configure()
    }
    
    var body: some View {
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
                                        SettingsLabel(id: "FOLLOWUP_TITLE".localize(table: "FollowUp"), badgeCount: 1)
                                            .foregroundStyle(Color(UIColor.label))
                                    }
                                }
                            }
                            
                            // MARK: Radio
                            if !UIDevice.IsSimulator {
                                Section {
                                    IconToggle(enabled: $airplaneModeEnabled, color: Color.orange, icon: "airplane", title: "Airplane Mode")
                                    ForEach(radioSettings) { setting in
                                        if !phoneOnly.contains(setting.id) && requiredCapabilities(capability: setting.capability) {
                                            Button {
                                                id = UUID() // Reset destination
                                                stateManager.selection = setting.type
                                            } label: {
                                                SettingsLabel(color: setting.color, icon: setting.icon, id: setting.id, status: setting.id == "Wi-Fi" ? (wifiEnabled && !airplaneModeEnabled ? "Not Connected" : "Off") : setting.id == "Bluetooth" ? (bluetoothEnabled ? "On" : "Off") : String())
                                                    .foregroundStyle(stateManager.selection == setting.type ? (UIDevice.IsSimulator ? Color.white : Color["Label"]) : Color["Label"])
                                            }
                                            .listRowBackground(stateManager.selection == setting.type ? (UIDevice.IsSimulator ? Color.blue : Color("Selected")) : nil)
                                        }
                                    }
                                    //IconToggle(enabled: $vpnEnabled, color: .blue, icon: "network.connected.to.line.below", title: "VPN")
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
                            Task {
                                try await Task.sleep(nanoseconds: 500_000_000)
                                withAnimation { preloadRect = true }
                            }
                        }
                        .sheet(isPresented: $showingSignInSheet) {
                            NavigationStack {
                                SelectSignInOptionView()
                                    .interactiveDismissDisabled()
                            }
                        }
                        .searchable(text: $searchText, isPresented: $searchFocused, placement: .navigationBarDrawer)
                        .overlay {
                            if searchFocused {
                                GeometryReader { geo in
                                    List {
                                        if searchText.isEmpty {
                                            Section("Suggestions") {}
                                        } else {
                                            ContentUnavailableView("ContentUnavailableView_Search_Text %@".localize(table: "SwiftUI", searchText), systemImage: "magnifyingglass", description: Text("ContentUnavailableView_Search_Secondary_Text", tableName: "SwiftUI"))
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
                        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                            if UIDevice.current.orientation.rawValue <= 4 {
                                // Changes frame sizes when changing orientation on iPadOS
                                isOnLandscapeOrientation = UIDevice.current.orientation.isLandscape
                            }
                        }
                        .task {
                            if UIDevice.current.orientation.rawValue <= 4 {
                                isOnLandscapeOrientation = UIDevice.current.orientation.isLandscape
                            }
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
                                    .foregroundStyle(Color["Label"])
                                }
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
                                    SettingsLink(icon: "None", id: "FOLLOWUP_TITLE".localize(table: "FollowUp"), badgeCount: 1) {
                                        FollowUpView()
                                    }
                                }
                            }
                            
                            if !UIDevice.IsSimulator {
                                // MARK: Radio Settings
                                Section {
                                    IconToggle(enabled: $airplaneModeEnabled, color: Color.orange, icon: "airplane", title: "Airplane Mode")
                                    ForEach(radioSettings) { setting in
                                        if setting.capability == .none {
                                            SettingsLink(color: setting.color, icon: setting.icon, id: setting.id, status: setting.id == "Wi-Fi" ? (wifiEnabled && !airplaneModeEnabled ? "Not Connected" : "Off") : setting.id == "Bluetooth" ? (bluetoothEnabled ? "On" : "Off") : String()) {
                                                setting.destination
                                            }
                                            .accessibilityLabel(setting.id)
                                        } else if setting.capability != .none {
                                            SettingsLink(color: setting.color, icon: setting.icon, id: setting.id, status: setting.id == "Cellular" && airplaneModeEnabled ? "Airplane Mode" : setting.id == "Personal Hotspot" ? "Off" : String()) {
                                                setting.destination
                                            }
                                            .disabled(setting.id == "Personal Hotspot" && airplaneModeEnabled)
                                            .accessibilityLabel(setting.id)
                                        }
                                    }
                                    //IconToggle(enabled: $vpnEnabled, color: .blue, icon: "network.connected.to.line.below", title: "VPN")
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
                        .searchable(text: $searchText, isPresented: $searchFocused)
                        .overlay {
                            if searchFocused {
                                GeometryReader { geo in
                                    List {
                                        if searchText.isEmpty {
                                            SettingsSearchView()
                                        } else {
                                            ContentUnavailableView("ContentUnavailableView_Search_Text %@".localize(table: "SwiftUI", searchText), systemImage: "magnifyingglass", description: Text("ContentUnavailableView_Search_Secondary_Text", tableName: "SwiftUI"))
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
                .frame(maxWidth: UIDevice.iPad ? (isOnLandscapeOrientation ? 415 : 320) : nil)
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
    }
}

// MARK: - Required Capabilities Check
@MainActor func requiredCapabilities(capability: Capabilities) -> Bool {
    switch capability {
    case .none:
        return true
    case .actionButton:
        return UIDevice.RingerButtonCapability
    case .cellular:
        return UIDevice.CellularTelephonyCapability
    case .vpn:
        return true
    case .siri:
        return !UIDevice.IntelligenceCapability
    case .appleIntelligence:
        return UIDevice.IntelligenceCapability
    case .isInternal:
        return false
    }
}

#Preview {
    ContentView()
        .environmentObject(StateManager())
}
