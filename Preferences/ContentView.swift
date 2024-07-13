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
    @State private var showingCellular = false
    @State private var showingVpn = false
    @AppStorage("airplaneMode") private var airplaneModeEnabled = false
    @AppStorage("wifi") private var wifiEnabled = true
    @AppStorage("bluetooth") private var bluetoothEnabled = true
    @AppStorage("vpn") private var vpnEnabled = false
    
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
                            if !UIDevice.isSimulator {
                                Section {
                                    IconToggle(enabled: $airplaneModeEnabled, color: Color.orange, icon: "airplane", title: "Airplane Mode")
                                    ForEach(radioSettings) { setting in
                                        if !phoneOnly.contains(setting.id) {
                                            Button {
                                                id = UUID() // Reset destination
                                                selection = setting.type
                                            } label: {
                                                SettingsLabel(color: setting.color, icon: setting.icon, id: setting.id, status: setting.id == "Wi-Fi" ? (wifiEnabled && airplaneModeEnabled ? "Not Connected" : "Off") : setting.id == "Bluetooth" ? (bluetoothEnabled ? "On" : "Off") : String())
                                                    .foregroundStyle(selection == setting.type ? (UIDevice.isSimulator ? Color.white : Color["Label"]) : Color["Label"])
                                            }
                                            .listRowBackground(selection == setting.type ? (UIDevice.isSimulator ? Color.blue : Color("Selected")) : nil)
                                        }
                                    }
                                    IconToggle(enabled: $vpnEnabled, color: .blue, icon: "network.connected.to.line.below", title: "VPN")
                                }
                            }
                            
                            // MARK: Main
                            SettingsLabelSection(selection: $selection, id: $id, item: UIDevice.isSimulator ? simulatorMainSettings : mainSettings)
                            
                            // MARK: Attention
                            SettingsLabelSection(selection: $selection, id: $id, item: UIDevice.isSimulator ? attentionSimulatorSettings : attentionSettings)
                            
                            // MARK: Security
                            SettingsLabelSection(selection: $selection, id: $id, item: UIDevice.isSimulator ? simulatorSecuritySettings : securitySettings)
                            
                            // MARK: Services
                            SettingsLabelSection(selection: $selection, id: $id, item: serviceSettings)
                            
                            // MARK: Apps
                            SettingsLabelSection(selection: $selection, id: $id, item: appsSettings)
                            
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
                        .onAppear {
                            if UIDevice.current.orientation.rawValue <= 4 {
                                isOnLandscapeOrientation = UIDevice.current.orientation.isLandscape
                            }
                        }
                        .onChange(of: selection) { // Change views when selecting sidebar navigation links
                            if let selectedSettingsItem = combinedSettings.first(where: { $0.type == selection }) {
                                destination = selectedSettingsItem.destination
                            }
                        }
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
                            
                            if !UIDevice.isSimulator {
                                // MARK: Radio Settings
                                Section {
                                    IconToggle(enabled: $airplaneModeEnabled, color: Color.orange, icon: "airplane", title: "Airplane Mode")
                                    ForEach(radioSettings) { setting in
                                        if setting.capability == .none {
                                            SettingsLink(color: setting.color, icon: setting.icon, id: setting.id, status: setting.id == "Wi-Fi" ? (wifiEnabled && !airplaneModeEnabled ? "Not Connected" : "Off") : setting.id == "Bluetooth" ? (bluetoothEnabled ? "On" : "Off") : setting.id == "Cellular" && airplaneModeEnabled ? "Airplane Mode" : String()) {
                                                setting.destination
                                            }
                                            .disabled(setting.id == "Personal Hotspot" && airplaneModeEnabled)
                                        } else if setting.capability != .none && showingCellular {
                                            SettingsLink(color: setting.color, icon: setting.icon, id: setting.id, status: setting.id == "Cellular" && airplaneModeEnabled ? "Airplane Mode" : String()) {
                                                setting.destination
                                            }
                                        }
                                    }
                                    if showingVpn {
                                        IconToggle(enabled: $vpnEnabled, color: .blue, icon: "network.connected.to.line.below", title: "VPN")
                                    }
                                }
                            }
                            
                            // MARK: Main Settings
                            SettingsLinkSection(item: UIDevice.isSimulator ? simulatorMainSettings : mainSettings)
                            
                            // MARK: Attention
                            SettingsLinkSection(item: UIDevice.isSimulator ? attentionSimulatorSettings : attentionSettings)
                            
                            // MARK: Security
                            SettingsLinkSection(item: UIDevice.isSimulator ? simulatorSecuritySettings : securitySettings)
                            
                            // MARK: Services
                            SettingsLinkSection(item: serviceSettings)
                            
                            // MARK: Apps
                            SettingsLinkSection(item: appsSettings)
                            
                            // MARK: Developer
                            if UIDevice.isSimulator || Configuration().developerMode {
                                SettingsLinkSection(item: developerSettings)
                            }
                        }
                        .onAppear {
                            Task {
                                try await Task.sleep(nanoseconds: 500_000_000)
                                withAnimation { showingCellular = true }
                                try await Task.sleep(nanoseconds: 500_000_000)
                                withAnimation { showingVpn = true }
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

// MARK: Apple Account Button
struct AppleAccountSection: View {
    @EnvironmentObject var deviceInfo: Device
    
    var body: some View {
        NavigationLink {} label: {
            HStack {
                Image("appleAccount")
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

// MARK: - Settings Sidebar Label for iPadOS
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
                            .foregroundStyle(selection == setting.type ? (UIDevice.isSimulator ? Color.white : Color["Label"]) : Color["Label"])
                    }
                    .listRowBackground(selection == setting.type ? (UIDevice.isSimulator ? Color.blue : Color("Selected")) : nil)
                }
            }
        }
    }
}

// MARK: - Settings Link for iOS
struct SettingsLinkSection: View {
    var item: [SettingsItem<AnyView>]
    
    var body: some View {
        Section {
            ForEach(item) { setting in
                if !tabletOnly.contains(setting.id) && requiredCapabilities(capability: setting.capability) {
                    SettingsLink(color: setting.color, icon: setting.icon, id: setting.id) {
                        setting.destination
                    }
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
    }
}

#Preview {
    ContentView()
        .environmentObject(Device())
}
