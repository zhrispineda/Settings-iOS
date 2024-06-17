//
//  ContentView.swift
//  Preferences
//
//  Settings
//

import SwiftUI

// Variables
let phoneOnly = ["Action Button", "Emergency SOS", "Health", "Personal Hotspot", "StandBy"]
let tabletOnly = ["Multitasking & Gestures"]

struct ContentView: View {
    // Variables
    @EnvironmentObject var device: Device
    @State private var searchText = String()
    @State private var showingSignInSheet = false
    @State private var selection: SettingsModel? = .general
    @State private var destination = AnyView(GeneralView())
    @State private var isOnLandscapeOrientation: Bool = UIDevice.current.orientation.isLandscape
    @State private var id = UUID()
    @State private var airplaneModeEnabled = false
    
    var body: some View {
        ZStack {
            Color.primary
                .opacity(0.3)
                .ignoresSafeArea()
            HStack(spacing: 0.25) {
                NavigationStack {
                    // MARK: - iPadOS Settings
                    if device.isTablet {
                        List(selection: $selection) {
                            Button {
                                showingSignInSheet.toggle()
                            } label: {
                                AppleAccountSection()
                            }
                            .sheet(isPresented: $showingSignInSheet) {
                                NavigationStack {
                                    SelectSignInOptionView()
                                        .interactiveDismissDisabled()
                                }
                            }
                            
                            // MARK: Radio
                            if !Configuration().isSimulator {
                                Section {
                                    IconToggle(enabled: $airplaneModeEnabled, color: Color.orange, icon: "airplane", title: "Airplane Mode")
                                    ForEach(radioSettings) { setting in
                                        if !phoneOnly.contains(setting.id) {
                                            Button {
                                                id = UUID() // Reset destination
                                                selection = setting.type
                                            } label: {
                                                SettingsLabel(color: setting.color, icon: setting.icon, id: setting.id, status: setting.id == "Wi-Fi" ? "On" : String())
                                                    .foregroundStyle(selection == setting.type ? (Configuration().isSimulator ? Color.white : Color["Label"]) : Color["Label"])
                                            }
                                            .listRowBackground(selection == setting.type ? (Configuration().isSimulator ? Color.blue : Color("Selected")) : nil)
                                        }
                                    }
                                }
                            }
                            
                            // MARK: Main
                            SettingsLabelSection(selection: $selection, id: $id, item: Configuration().isSimulator ? simulatorMainSettings : mainSettings)
                            
                            // MARK: Attention
                            SettingsLabelSection(selection: $selection, id: $id, item: Configuration().isSimulator ? attentionSimulatorSettings : attentionSettings)
                            
                            // MARK: Security
                            SettingsLabelSection(selection: $selection, id: $id, item: Configuration().isSimulator ? simulatorSecuritySettings : securitySettings)
                            
                            // MARK: Services
                            SettingsLabelSection(selection: $selection, id: $id, item: serviceSettings)
                            
                            // MARK: Apps
                            SettingsLabelSection(selection: $selection, id: $id, item: appSettings)
                            
                            // MARK: Developer
                            SettingsLabelSection(selection: $selection, id: $id, item: developerSettings)
                        }
                        .navigationTitle("Settings")
                        .searchable(text: $searchText, placement: .navigationBarDrawer)
                        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                            if UIDevice.current.orientation.rawValue <= 4 {
                                // Changes frame sizes when changing orientation on iPadOS
                                isOnLandscapeOrientation = UIDevice.current.orientation.isLandscape
                            }
                        }
                        .onAppear(perform: {
                            if UIDevice.current.orientation.rawValue <= 4 {
                                isOnLandscapeOrientation = UIDevice.current.orientation.isLandscape
                            }
                        })
                        .onChange(of: selection, { // Change views when selecting sidebar navigation links
                            if let selectedSettingsItem = combinedSettings.first(where: { $0.type == selection }) {
                                destination = selectedSettingsItem.destination
                            }
                        })
                    } else {
                        // MARK: - iOS Settings
                        List {
                            Section {
                                Button {
                                    showingSignInSheet.toggle()
                                } label: {
                                    AppleAccountSection()
                                }
                                .sheet(isPresented: $showingSignInSheet) {
                                    NavigationStack {
                                        SelectSignInOptionView()
                                            .interactiveDismissDisabled()
                                    }
                                }
                            }
                            
                            if !Configuration().isSimulator {
                                // MARK: Radio Settings
                                Section {
                                    IconToggle(enabled: $airplaneModeEnabled, color: Color.orange, icon: "airplane", title: "Airplane Mode")
                                    ForEach(radioSettings) { setting in
                                        SettingsLink(color: setting.color, icon: setting.icon, id: setting.id, status: setting.id == "Wi-Fi" ? "On" : setting.id == "Cellular" && airplaneModeEnabled ? "Airplane Mode" : "") {
                                            setting.destination
                                        }
                                        .disabled(setting.id == "Personal Hotspot" && airplaneModeEnabled)
                                    }
                                }
                            }
                            
                            // MARK: Main Settings
                            SettingsLinkSection(item: Configuration().isSimulator ? simulatorMainSettings : mainSettings)
                            
                            // MARK: Attention
                            SettingsLinkSection(item: Configuration().isSimulator ? attentionSimulatorSettings : attentionSettings)
                            
                            // MARK: Security
                            SettingsLinkSection(item: Configuration().isSimulator ? simulatorSecuritySettings : securitySettings)
                            
                            // MARK: Services
                            SettingsLinkSection(item: serviceSettings)
                            
                            // MARK: Apps
                            SettingsLinkSection(item: appSettings)
                            
                            // MARK: Developer
                            if Configuration().isSimulator || Configuration().developerMode {
                                SettingsLinkSection(item: developerSettings)
                            }
                        }
                        .navigationTitle("Settings")
                        .searchable(text: $searchText)
                    }
                }
                .frame(maxWidth: device.isTablet ? (isOnLandscapeOrientation ? 415 : 320) : nil)
                if device.isTablet {
                    NavigationStack {
                        destination
                    }
                    .id(id)
                }
            }
        }
    }
}

struct AppleAccountSection: View {
    @EnvironmentObject var deviceInfo: Device
    
    var body: some View {
        NavigationLink {} label: {
            HStack {
                Image("AppleAccount_Icon_Blue90x90")
                    .resizable()
                    .frame(width: 60, height: 60)
                VStack(alignment: .leading, spacing: 3) {
                    Text("Apple Account")
                        .bold()
                        .font(.title3)
                        .foregroundStyle(Color["Label"])
                        .padding(.bottom, 0)
                    Text("Sign in to access your iCloud data, the App Store, Apple services, and more.")
                        .foregroundStyle(.secondary)
                        .font(.system(size: 13))
                }
                .padding(.leading, 5)
            }
        }
        .foregroundStyle(Color["Label"])
    }
}

// Settings Sidebar Label for iPadOS
struct SettingsLabelSection: View {
    @Binding var selection: SettingsModel?
    @Binding var id: UUID
    var item: [SettingsItem<AnyView>]
    
    var body: some View {
        Section {
            ForEach(item) { setting in
                if !phoneOnly.contains(setting.id) {
                    Button {
                        id = UUID() // Reset destination
                        selection = setting.type
                    } label: {
                        SettingsLabel(color: setting.color, icon: setting.icon, id: setting.id)
                            .foregroundStyle(selection == setting.type ? (Configuration().isSimulator ? Color.white : Color["Label"]) : Color["Label"])
                    }
                    .listRowBackground(selection == setting.type ? (Configuration().isSimulator ? Color.blue : Color("Selected")) : nil)
                }
            }
        }
    }
}

// Settings Link for iOS
struct SettingsLinkSection: View {
    var item: [SettingsItem<AnyView>]
    
    var body: some View {
        Section {
            ForEach(item) { setting in
                if !tabletOnly.contains(setting.id) {
                    if setting.id == "Action Button" && Device().hasActionButton {
                        SettingsLink(color: setting.color, icon: setting.icon, id: setting.id) {
                            setting.destination
                        }
                    } else if setting.id != "Action Button" {
                        SettingsLink(color: setting.color, icon: setting.icon, id: setting.id) {
                            setting.destination
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(Device())
}
