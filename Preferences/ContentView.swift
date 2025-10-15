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
    @AppStorage("VPNToggle") private var VPNEnabled = true
    @Environment(StateManager.self) private var stateManager
    @State private var searchFocused = false
    @State private var searchText = ""
    @State private var showingSignInSheet = false

    var body: some View {
        @Bindable var stateManager = stateManager
        
        // MARK: iPadOS Layout
        if UIDevice.iPad {
            NavigationSplitView {
                List(selection: $stateManager.selection) {
                    Button {
                        showingSignInSheet.toggle()
                    } label: {
                        AppleAccountSection()
                    }
                    
                    if !followUpDismissed && !UIDevice.IsSimulator {
                        Section {
                            Button {
                                stateManager.selection = stateManager.followUpSettings.first
                            } label: {
                                SLabel("FOLLOWUP_TITLE".localized(path: "/System/Library/PrivateFrameworks/SetupAssistant.framework", table: "FollowUp"), badgeCount: 1)
                            }
                        }
                    }

                    // MARK: Radio Settings
                    if !UIDevice.IsSimulator {
                        Section {
                            IconToggle(
                                "Airplane Mode",
                                isOn: $airplaneModeEnabled,
                                icon: "com.apple.graphic-icon.airplane-mode"
                            )
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
                    SettingsLabelSection(selection: $stateManager.selection, item: stateManager.developerSettings)
                }
                .toolbar(removing: .sidebarToggle)
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
                .onAppear {
                    if stateManager.selection == nil {
                        stateManager.selection = stateManager.mainSettings.first
                    }
                }
            } detail: {
                NavigationStack(path: $stateManager.path) {
                    stateManager.selection?.destination
                        .navigationDestination(for: String.self) { key in
                            RouteRegistry.shared.view(for: key) ?? AnyView(Text("Unknown: \(key)"))
                        }
                }
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
                            SLink("FOLLOWUP_TITLE".localized(path: "/System/Library/PrivateFrameworks/SetupAssistant.framework", table: "FollowUp"), icon: "None", badgeCount: 1) {
                                FollowUpView()
                            }
                        }
                    }
                    
//                    Section {
//                        HStack {
//                            if let asset = UIImage.asset(path: "/System/Library/PrivateFrameworks/MobileBackup.framework/PlugIns/MBPrebuddyFollowUpExtension.appex", name: "iPhone") {
//                                Image(uiImage: asset)
//                                    .resizable()
//                                    .renderingMode(.template)
//                                    .scaledToFit()
//                                    .frame(width: 42)
//                                    .foregroundStyle(.blue)
//                            }
//                            LabeledContent {} label: {
//                                Text("Get Ready For Your New iPhone")
//                                Text("Use iCloud to move your apps and data to your new iPhone.")
//                            }
//                        }
//                        Button("Get Started") {}
//                    }

                    if !UIDevice.IsSimulator {
                        // MARK: Radio Settings
                        Section {
                            IconToggle(
                                "Airplane Mode",
                                isOn: $airplaneModeEnabled,
                                icon: "com.apple.graphic-icon.airplane-mode"
                            )
                            SettingsLinkSection(item: stateManager.radioSettings)
                            if requiredCapabilities(capability: .vpn) {
                                IconToggle("VPN", isOn: $VPNEnabled, color: .blue, icon: "network.connected.to.line.below")
                            }
                        }
                    }
                    
                    // MARK: Main Settings
                    SettingsLinkSection(item: UIDevice.IsSimulator ? stateManager.simulatorMainSettings : stateManager.mainSettings)
                    
                    // MARK: Attention
                    SettingsLinkSection(item: UIDevice.IsSimulator ? stateManager.attentionSimulatorSettings : stateManager.attentionSettings)
                    
                    // MARK: Security
                    SettingsLinkSection(item: UIDevice.IsSimulator ? stateManager.simulatorSecuritySettings : stateManager.securitySettings)
                    
                    // MARK: Services
                    SettingsLinkSection(item: UIDevice.IsSimulator ? stateManager.simulatorServicesSettings : stateManager.serviceSettings)

                    // MARK: Apps
                    SettingsLinkSection(item: stateManager.appsSettings)
                    
                    // MARK: Developer
                    if UIDevice.IsSimulator || configuration.developerMode {
                        SettingsLinkSection(item: stateManager.developerSettings)
                    }
                }
                .navigationDestination(for: String.self) { key in
                    RouteRegistry.shared.view(for: key) ?? AnyView(Text("Unknown: \(key)"))
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
            .onChange(of: stateManager.path) {
                if !stateManager.path.isEmpty {
                    SettingsLogger.log("Last Navigation Event: \(stateManager.breadcrumb)")
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
    ContentView()
        .environment(StateManager())
}
