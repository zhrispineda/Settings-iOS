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
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(PrimarySettingsListModel.self) private var model
    @State private var searchFocused = false
    @State private var showingSignInError = false
    @State private var showingSignInSheet = false
    @State private var searchText = ""
    
    var body: some View {
        @Bindable var model = model
        
        NavigationSplitView {
            List(selection: $model.selection) {
                Section {
                    Button {
                        if model.isConnected {
                            showingSignInSheet.toggle()
                        } else {
                            SettingsLogger.info("Presenting Network Alert.")
                            showingSignInError.toggle()
                        }
                    } label: {
                        NavigationLink {} label: {
                            AppleAccountSection()
                        }
                        .navigationLinkIndicatorVisibility(UIDevice.iPad && !model.isCompact ? .hidden : .visible)
                    }
                }
                
                if !UIDevice.IsSimulator && !followUpDismissed {
                    SettingsLabelSection(item: model.followUpSettings)
                }
                
                // MARK: Radio Settings
                if !UIDevice.IsSimulator {
                    Section {
                        SettingsLabelSection(item: model.radioSettings)
                    }
                }
                
                SettingsLabelSection(item: UIDevice.IsSimulator ? model.simulatorMainSettings : model.mainSettings)
                SettingsLabelSection(item: UIDevice.IsSimulator ? model.attentionSimulatorSettings : model.attentionSettings)
                SettingsLabelSection(item: UIDevice.IsSimulator ? model.simulatorSecuritySettings : model.securitySettings)
                SettingsLabelSection(item: UIDevice.IsSimulator ? model.simulatorServicesSettings : model.serviceSettings)
                SettingsLabelSection(item: model.appsSettings)
                
                if UIDevice.IsSimulator || configuration.developerMode {
                    SettingsLabelSection(item: model.developerSettings)
                }
            }
            .navigationTitle(UIDevice.iPhone || model.isCompact ? .settings : "")
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
                                SettingsSearchView()
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
            NavigationStack(path: $model.path) {
                model.selection?.destination
            }
        }
        .onAppear {
            model.isCompact = horizontalSizeClass == .compact
            if model.selection == nil && UIDevice.iPad && !model.isCompact {
                model.selection = model.mainSettings.first
            }
        }
        .onChange(of: model.path) { oldValue, _ in
            if !oldValue.isEmpty {
                SettingsLogger.log("Last Navigation Event: \(oldValue.joined(separator: " → "))")
            }
        }
        .onChange(of: horizontalSizeClass) {
            model.isCompact = horizontalSizeClass == .compact
            if !model.isCompact && model.selection == nil {
                model.selection = model.mainSettings.first
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
