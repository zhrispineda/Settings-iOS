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
    @State private var selection: SettingsModel? = .general
    @State private var destination = AnyView(GeneralView())
    @State private var isOnLandscapeOrientation: Bool = UIDevice.current.orientation.isLandscape
    @State private var id = UUID()
    let tabletOnly = ["Multitasking & Gestures"]
    
    var body: some View {
        ZStack {
            Color.primary
                .opacity(0.3)
                .ignoresSafeArea()
            HStack(spacing: 0.25) {
                NavigationStack {
                    // MARK: - iPadOS Settings
                    if !deviceInfo.isPhone {
                        List(selection: $selection) {
                            Button(action: {}, label: {
                                HStack {
                                    Image(systemName: "person.crop.circle.fill")                                        .resizable()
                                        .foregroundStyle(Color(UIColor.systemGray6), Color(UIColor.systemGray2))
                                        .fontWeight(.thin)
                                        .frame(width: 54, height: 54)
                                    VStack {
                                        Text("Sign in to your \(deviceInfo.model)")
                                            .font(.system(size: 16))
                                            .padding(.bottom, 0)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        Text("Set up iCloud, the App Store, and more.")
                                            .foregroundStyle(Color(UIColor.label))
                                            .font(.system(size: 13))
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.trailing)
                                    }
                                    .padding(.leading, 5)
                                }
                                .padding(.vertical, -5)
                            })
                            
                            // MARK: Attention Settings
                            Section {
                                ForEach(attentionSettings) { setting in
                                    if setting.id != "Action Button" {
                                        Button(action: {
                                            id = UUID() // Reset destination
                                            selection = setting.type
                                        }, label: {
                                            SettingsLabel(color: setting.color, icon: setting.icon, id: setting.id)
                                                .foregroundStyle(selection == setting.type ? Color.white : Color(UIColor.label))
                                        })
                                        .listRowBackground(selection == setting.type ? Color.blue : nil)
                                    }
                                }
                            }
                            
                            // MARK: Main Settings
                            Section {
                                ForEach(mainSettings) { setting in
                                    Button(action: {
                                        id = UUID() // Reset destination
                                        selection = setting.type
                                    }, label: {
                                        SettingsLabel(color: setting.color, icon: setting.icon, id: setting.id)
                                            .foregroundStyle(selection == setting.type ? Color.white : Color(UIColor.label))
                                    })
                                    .listRowBackground(selection == setting.type ? Color.blue.opacity(0.75) : nil)
                                }
                            }
                            
                            // MARK: Services Settings
                            Section {
                                ForEach(servicesSettings) { setting in
                                    Button(action: {
                                        id = UUID() // Reset destination
                                        selection = setting.type
                                    }, label: {
                                        SettingsLabel(color: setting.color, icon: setting.icon, id: setting.id)
                                            .foregroundStyle(selection == setting.type ? Color.white : Color(UIColor.label))
                                    })
                                    .listRowBackground(selection == setting.type ? Color.blue.opacity(0.75) : nil)
                                }
                            }
                            
                            // MARK: Apps Settings
                            Section {
                                ForEach(appsSettings) { setting in
                                    if setting.id != "Health" {
                                        Button(action: {
                                            id = UUID() // Reset destination
                                            selection = setting.type
                                        }, label: {
                                            SettingsLabel(color: setting.color, icon: setting.icon, id: setting.id)
                                                .foregroundStyle(selection == setting.type ? Color.white : Color(UIColor.label))
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
                                            .foregroundStyle(selection == setting.type ? Color.white : Color(UIColor.label))
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
                                Button(action: {}, label: {
                                    HStack {
                                        Image(systemName: "person.crop.circle.fill")                                        .resizable()
                                            .foregroundStyle(Color(UIColor.systemGray6), Color(UIColor.systemGray2))
                                            .fontWeight(.thin)
                                            .frame(width: 54, height: 54)
                                        VStack {
                                            Text("Sign in to your \(deviceInfo.model)")
                                                .font(.system(size: 16))
                                                .padding(.bottom, 0)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            Text("Set up iCloud, the App Store, and more.")
                                                .foregroundStyle(Color(UIColor.label))
                                                .font(.system(size: 13))
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                        .padding(.leading, 5)
                                    }
                                    .padding(.vertical, -5)
                                })
                            }
                            
                            // MARK: Attention Settings
                            Section {
                                ForEach(attentionSettings) { setting in
                                    if setting.id == "Action Button" {
                                        if UIDevice.current.name.contains("15 Pro") {
                                            SettingsLink(color: setting.color, icon: setting.icon, id: setting.id, content: {
                                                setting.destination
                                            })
                                        }
                                    } else if setting.id != "Action Button" {
                                        SettingsLink(color: setting.color, icon: setting.icon, id: setting.id, content: {
                                            setting.destination
                                        })
                                    }
                                }
                            }
                            
                            // MARK: Main Settings
                            Section {
                                ForEach(mainSettings) { setting in
                                    if !tabletOnly.contains(setting.id) {
                                        SettingsLink(color: setting.color, icon: setting.icon, id: setting.id, content: {
                                            setting.destination
                                        })
                                    }
                                }
                            }
                            
                            // MARK: Services Settings
                            Section {
                                ForEach(servicesSettings) { setting in
                                    if !tabletOnly.contains(setting.id) {
                                        SettingsLink(color: setting.color, icon: setting.icon, id: setting.id, content: {
                                            setting.destination
                                        })
                                    }
                                }
                            }
                            
                            // MARK: Apps Settings
                            Section {
                                ForEach(appsSettings) { setting in
                                    if !tabletOnly.contains(setting.id) {
                                        SettingsLink(color: setting.color, icon: setting.icon, id: setting.id, content: {
                                            setting.destination
                                        })
                                    }
                                }
                            }
                            
                            // MARK: Developer Settings
                            Section {
                                ForEach(developerSettings) { setting in
                                    if !tabletOnly.contains(setting.id) {
                                        SettingsLink(color: setting.color, icon: setting.icon, id: setting.id, content: {
                                            setting.destination
                                        })
                                    }
                                }
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
                    }.id(id)
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(DeviceInfo())
}
