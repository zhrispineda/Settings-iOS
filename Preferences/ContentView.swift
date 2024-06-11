//
//  ContentView.swift
//  Preferences
//
//  Settings
//

import SwiftUI

struct ContentView: View {
    // Variables
    @EnvironmentObject var deviceInfo: DeviceInfo
    @State private var searchText = String()
    @State private var showingSignInSheet = false
    @State private var selection: SettingsModel? = .general
    @State private var destination = AnyView(GeneralView())
    @State private var isOnLandscapeOrientation: Bool = UIDevice.current.orientation.isLandscape
    @State private var id = UUID()
    @State private var airplaneModeEnabled = false
    let tabletOnly = ["Multitasking & Gestures"]
    let phoneOnly = ["Action Button", "Health"]
    
    var body: some View {
        ZStack {
            Color.primary
                .opacity(0.3)
                .ignoresSafeArea()
            HStack(spacing: 0.25) {
                NavigationStack {
                    // MARK: - iPadOS Settings
                    if deviceInfo.isTablet {
                        List(selection: $selection) {
                            Button(action: {
                                showingSignInSheet.toggle()
                            }, label: {
                                AppleAccountSection()
                            })
                            .sheet(isPresented: $showingSignInSheet) {
                                NavigationStack {
                                    SelectSignInOptionView()
                                        .interactiveDismissDisabled()
                                }
                            }
                            
                            // MARK: Radio Settings
                            if !Configuration().isSimulator {
                                Section {
                                    IconToggle(enabled: $airplaneModeEnabled, color: Color.orange, icon: "airplane", title: "Airplane Mode")
                                    ForEach(radioSettings) { setting in
                                        Button(action: {
                                            id = UUID() // Reset destination
                                            selection = setting.type
                                        }, label: {
                                            SettingsLabel(color: setting.color, icon: setting.icon, id: setting.id, status: setting.id == "Wi-Fi" ? "On" : String())
                                                .foregroundStyle(selection == setting.type ? Color.white : Color["Label"])
                                        })
                                        .listRowBackground(selection == setting.type ? Color.blue : nil)
                                    }
                                }
                            }
                            
                            // MARK: Main Settings
                            Section {
                                ForEach(mainSettings) { setting in
                                    if !phoneOnly.contains(setting.id) {
                                        Button(action: {
                                            id = UUID() // Reset destination
                                            selection = setting.type
                                        }, label: {
                                            SettingsLabel(color: setting.color, icon: setting.icon, id: setting.id)
                                                .foregroundStyle(selection == setting.type ? Color.white : Color["Label"])
                                        })
                                        .listRowBackground(selection == setting.type ? Color.blue.opacity(0.75) : nil)
                                    }
                                }
                            }
                            
                            // MARK: Attention Settings
                            Section {
                                ForEach(Configuration().isSimulator ? attentionSimulatorSettings : attentionSettings) { setting in
                                    if !phoneOnly.contains(setting.id) {
                                        Button(action: {
                                            id = UUID() // Reset destination
                                            selection = setting.type
                                        }, label: {
                                            SettingsLabel(color: setting.color, icon: setting.icon, id: setting.id)
                                                .foregroundStyle(selection == setting.type ? Color.white : Color["Label"])
                                        })
                                        .listRowBackground(selection == setting.type ? Color.blue : nil)
                                    }
                                }
                            }
                            
                            // MARK: Services Settings
                            Section {
                                ForEach(serviceSettings) { setting in
                                    Button(action: {
                                        id = UUID() // Reset destination
                                        selection = setting.type
                                    }, label: {
                                        SettingsLabel(color: setting.color, icon: setting.icon, id: setting.id)
                                            .foregroundStyle(selection == setting.type ? Color.white : Color["Label"])
                                    })
                                    .listRowBackground(selection == setting.type ? Color.blue.opacity(0.75) : nil)
                                }
                            }
                            
                            // MARK: Apps Settings
                            Section {
                                ForEach(appSettings) { setting in
                                    if !phoneOnly.contains(setting.id) {
                                        Button(action: {
                                            id = UUID() // Reset destination
                                            selection = setting.type
                                        }, label: {
                                            SettingsLabel(color: setting.color, icon: setting.icon, id: setting.id)
                                                .foregroundStyle(selection == setting.type ? Color.white : Color["Label"])
                                        })
                                        .listRowBackground(selection == setting.type ? Color.blue.opacity(0.75) : nil)
                                    }
                                }
                            }
                            
                            // MARK: Developer Settings
                            Section {
                                ForEach(developerSettings) { setting in
                                    Button(action: {
                                        id = UUID() // Reset destination
                                        selection = setting.type
                                    }, label: {
                                        SettingsLabel(color: setting.color, icon: setting.icon, id: setting.id)
                                            .foregroundStyle(selection == setting.type ? Color.white : Color["Label"])
                                    })
                                    .listRowBackground(selection == setting.type ? Color.blue.opacity(0.75) : nil)
                                }
                            }
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
                                Button(action: {
                                    showingSignInSheet.toggle()
                                }, label: {
                                    AppleAccountSection()
                                })
//                                NavigationLink("Services Included with Purchase", destination: {})
//                                    .font(.subheadline)
                                .sheet(isPresented: $showingSignInSheet, content: {
                                    NavigationStack {
                                        SelectSignInOptionView()
                                            .interactiveDismissDisabled()
                                    }
                                })
                            }
                            
//                            Section {
//                                NavigationLink("Add AppleCare+ Coverage", destination: {})
//                            } footer: {
//                                Text("There are 60 days left to add coverage for accidental damage.")
//                            }
                            
                            if !Configuration().isSimulator {
                                // MARK: Radio Settings
                                Section {
                                    IconToggle(enabled: $airplaneModeEnabled, color: Color.orange, icon: "airplane", title: "Airplane Mode")
                                    ForEach(radioSettings) { setting in
                                        SettingsLink(color: setting.color, icon: setting.icon, id: setting.id, status: setting.id == "Wi-Fi" ? "On" : setting.id == "Cellular" && airplaneModeEnabled ? "Airplane Mode" : "", content: {
                                            setting.destination
                                        })
                                        .disabled(setting.id == "Personal Hotspot" && airplaneModeEnabled)
                                    }
                                }
                            }
                            
                            // MARK: Main Settings
                            Section {
                                ForEach(Configuration().isSimulator ? simulatorMainSettings : mainSettings) { setting in
                                    if !tabletOnly.contains(setting.id) {
                                        if setting.id == "Action Button" && UIDevice.current.name.contains("15 Pro") {
                                            SettingsLink(color: setting.color, icon: setting.icon, id: setting.id, content: {
                                                setting.destination
                                            })
                                        } else if setting.id != "Action Button" {
                                            SettingsLink(color: setting.color, icon: setting.icon, id: setting.id, content: {
                                                setting.destination
                                            })
                                        }
                                    }
                                }
                            }
                            
                            // MARK: Attention
                            Section {
                                ForEach(Configuration().isSimulator ? attentionSimulatorSettings : attentionSettings) { setting in
                                    if setting.id == "Action Button" && UIDevice.current.name.contains("15 Pro") {
                                        SettingsLink(color: setting.color, icon: setting.icon, id: setting.id, content: {
                                            setting.destination
                                        })
                                    } else if setting.id != "Action Button" {
                                        SettingsLink(color: setting.color, icon: setting.icon, id: setting.id, content: {
                                            setting.destination
                                        })
                                    }
                                }
                            }
                            
                            // MARK: Services
                            SettingsLinkSection(item: securitySettings)
                            
                            // MARK: Services
                            SettingsLinkSection(item: serviceSettings)
                            
                            // MARK: Apps
                            SettingsLinkSection(item: appSettings)
                            
                            // MARK: TV Provider
//                            if !Configuration().isSimulator {
//                                SettingsLinkSection(item: tvProviderSettings)
//                            }
                            
                            // MARK: Developer
                            if Configuration().isSimulator || Configuration().developerMode {
                                SettingsLinkSection(item: developerSettings)
                            }
                        }
                        .navigationTitle("Settings")
                        .searchable(text: $searchText)
                    }
                }
                .frame(maxWidth: deviceInfo.isTablet ? (isOnLandscapeOrientation ? 415 : 320) : nil)
                if deviceInfo.isTablet {
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
    @EnvironmentObject var deviceInfo: DeviceInfo
    
    var body: some View {
        NavigationLink(destination: {}, label: {
            HStack {
                Image("AppleAccount_Icon_Blue90x90")
                    .resizable()
                    .frame(width: 60, height: 60)
                VStack(spacing: 3) {
                    Text("Apple Account")
                        .bold()
                        .font(.title3)
                        .foregroundStyle(Color["Label"])
                        .padding(.bottom, 0)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Sign in to access your iCloud data, the App Store, Apple services, and more.")
                        .foregroundStyle(Color.gray)
                        .font(.system(size: 13))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.leading, 5)
            }
        })
        .foregroundStyle(Color["Label"])
    }
}

struct SettingsLinkSection: View {
    var item: [SettingsItem<AnyView>]
    
    var body: some View {
        Section {
            ForEach(item) { setting in
                SettingsLink(color: setting.color, icon: setting.icon, id: setting.id, content: {
                    setting.destination
                })
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(DeviceInfo())
}
