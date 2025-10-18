//
//  ContentView.swift
//  Preferences
//
//  Settings
//

import SwiftUI

struct ContentView: View {
    @AppStorage("FollowUpDismissed") private var followUpDismissed = false
    @AppStorage("VPNToggle") private var VPNEnabled = true
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(StateManager.self) private var stateManager
    @State private var searchFocused = false
    @State private var showingSignInSheet = false
    @State private var searchText = ""
    
    var body: some View {
        @Bindable var stateManager = stateManager
        
        NavigationSplitView {
            List(selection: $stateManager.selection) {
                Section {
                    Button {
                        showingSignInSheet.toggle()
                    } label: {
                        NavigationLink {} label: {
                            AppleAccountSection()
                        }
                        .navigationLinkIndicatorVisibility(UIDevice.iPad ? .hidden : .visible)
                    }
                }
                
                if !UIDevice.IsSimulator && !followUpDismissed {
                    SettingsLabelSection(selection: $stateManager.selection, item: stateManager.followUpSettings)
                }
                
                // MARK: Radio Settings
                if !UIDevice.IsSimulator {
                    Section {
                        SettingsLabelSection(selection: $stateManager.selection, item: stateManager.radioSettings)
                        if requiredCapabilities(capability: .vpn) {
                            IconToggle("VPN", isOn: $VPNEnabled, color: .blue, icon: "network.connected.to.line.below")
                        }
                    }
                }
                
                // MARK: Main
                SettingsLabelSection(selection: $stateManager.selection, item: UIDevice.IsSimulator ? stateManager.simulatorMainSettings : stateManager.mainSettings)
                
                // MARK: Attention
                SettingsLabelSection(selection: $stateManager.selection, item: UIDevice.IsSimulator ? stateManager.attentionSimulatorSettings : stateManager.attentionSettings)
                
                // MARK: Security
                SettingsLabelSection(selection: $stateManager.selection, item: UIDevice.IsSimulator ? stateManager.simulatorSecuritySettings : stateManager.securitySettings)
                
                // MARK: Services
                SettingsLabelSection(selection: $stateManager.selection, item: UIDevice.IsSimulator ? stateManager.simulatorServicesSettings : stateManager.serviceSettings)
                
                // MARK: Apps
                SettingsLabelSection(selection: $stateManager.selection, item: stateManager.appsSettings)
                
                // MARK: Developer
                if UIDevice.IsSimulator || configuration.developerMode {
                    SettingsLabelSection(selection: $stateManager.selection, item: stateManager.developerSettings)
                }
            }
            .navigationTitle(UIDevice.iPhone || horizontalSizeClass == .compact ? "Settings" : "")
            .toolbar(removing: .sidebarToggle)
            .sheet(isPresented: $showingSignInSheet) {
                NavigationStack {
                    SelectSignInOptionView()
                        .interactiveDismissDisabled()
                }
            }
            .searchable(text: $searchText, isPresented: $searchFocused, placement: UIDevice.iPad ? .navigationBarDrawer(displayMode: .always) : .automatic)
            .overlay {
                if UIDevice.iPad && searchFocused && !searchText.isEmpty {
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
                } else if UIDevice.iPhone && searchFocused {
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
            .onAppear {
                if stateManager.selection == nil && UIDevice.iPad && horizontalSizeClass == .regular {
                    stateManager.selection = stateManager.mainSettings.first
                }
            }
        } detail: {
            NavigationStack(path: $stateManager.path) {
                stateManager.selection?.destination
            }
        }
        .onChange(of: stateManager.path) { oldValue, newValue in
            if !oldValue.isEmpty {
                SettingsLogger.log("Last Navigation Event: \(oldValue.joined(separator: " → "))")
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
    case .hotspot:
        return false
    case .satellite:
        return false
    case .phone:
        return UIDevice.iPhone
    case .tablet:
        return UIDevice.iPad
    }
}

#Preview {
    ContentView()
        .environment(StateManager())
}
