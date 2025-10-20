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
    @Environment(PrimarySettingsListModel.self) private var stateManager
    @State private var searchFocused = false
    @State private var showingSignInError = false
    @State private var showingSignInSheet = false
    @State private var searchText = ""
    @State private var splitViewVisibility = NavigationSplitViewVisibility.all
    
    var body: some View {
        @Bindable var stateManager = stateManager
        
        NavigationSplitView(columnVisibility: $splitViewVisibility) {
            List(selection: $stateManager.selection) {
                Section {
                    Button {
                        if stateManager.isConnected {
                            showingSignInSheet.toggle()
                        } else {
                            SettingsLogger.info("Presenting Network Alert.")
                            showingSignInError.toggle()
                        }
                    } label: {
                        NavigationLink {} label: {
                            AppleAccountSection()
                        }
                        .navigationLinkIndicatorVisibility(UIDevice.iPad && !stateManager.isCompact ? .hidden : .visible)
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
            .navigationTitle(UIDevice.iPhone || stateManager.isCompact ? .settings : "")
            .toolbar(removing: .sidebarToggle)
            .alert(.connectToTheInternetToSignInToYourDevice, isPresented: $showingSignInError) {
                Button(.ok) {}
            }
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
        } detail: {
            NavigationStack(path: $stateManager.path) {
                stateManager.selection?.destination
            }
        }
        .onAppear {
            stateManager.isCompact = splitViewVisibility == .detailOnly
            if stateManager.selection == nil && UIDevice.iPad && !stateManager.isCompact {
                stateManager.selection = stateManager.mainSettings.first
            }
        }
        .onChange(of: stateManager.path) { oldValue, newValue in
            if !oldValue.isEmpty {
                SettingsLogger.log("Last Navigation Event: \(oldValue.joined(separator: " → "))")
            }
        }
        .onChange(of: splitViewVisibility) {
            stateManager.isCompact = splitViewVisibility == .detailOnly
            if !stateManager.isCompact && stateManager.selection == nil {
                stateManager.selection = stateManager.mainSettings.first
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
        .environment(PrimarySettingsListModel())
}
