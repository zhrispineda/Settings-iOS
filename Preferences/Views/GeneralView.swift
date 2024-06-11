//
//  GeneralView.swift
//  Preferences
//
//  Settings > General
//

import SwiftUI

struct GeneralView: View {
    var body: some View {
        CustomList(title: "General") {
            // General Tooltip Header
            Section {
                VStack(spacing: 10) {
                    HStack(spacing: 15) {
                        Image("gear-icon-large40x40")
                            .resizable()
                            .frame(width: 56, height: 56)
                        .padding(.top, 5)
                    }
                    Text("General")
                        .bold()
                        .font(.title2)
                    Text("Manage your overall setup and preferences for \(DeviceInfo().model), such as software updates, device language\(DeviceInfo().isPhone ? ", CarPlay" : ""), AirDrop, and more.")
                        .multilineTextAlignment(.center)
                        .padding(.bottom)
                }
                .frame(maxWidth: .infinity)
            }
            .listRowSeparator(.hidden)
        
            Section {
                SettingsLink(color: .gray, icon: Configuration().isSimulator ? "questionmark.app.dashed" : DeviceInfo().isPhone ? "iphone.gen3" : "ipad.gen2", id: "About", content: { AboutView() })
                if !Configuration().isSimulator {
                    NavigationLink("Software Update", destination: SoftwareUpdateView())
                }
            }
            
            if !Configuration().isSimulator {
                Section {
                    NavigationLink("AppleCare & Warranty", destination: EmptyView())
                }
            }
            
            if !Configuration().isSimulator {
                Section {
                    NavigationLink("AirDrop", destination: EmptyView())
                    NavigationLink("AirPlay & Handoff", destination: EmptyView())
                    if DeviceInfo().isPhone {
                        NavigationLink("Picture in Picture", destination: EmptyView())
                        NavigationLink("CarPlay", destination: EmptyView())
                    }
                }
            }
            
            if !Configuration().isSimulator && DeviceInfo().hasHomeButton {
                NavigationLink("Home Button", destination: EmptyView())
            }
            
            if !Configuration().isSimulator {
                Section {
                    //NavigationLink("CarPlay", destination: EmptyView())
                    //NavigationLink("Matter Accessories", destination: EmptyView())
                }
            }
            
            if !Configuration().isSimulator {
                Section {
                    NavigationLink("\(UIDevice().localizedModel) Storage", destination: EmptyView())
                    NavigationLink("Background App Refresh", destination: EmptyView())
                }
            }
            
            Section {
                if !Configuration().isSimulator {
                    NavigationLink("Date & Time", destination: EmptyView())
                }
                NavigationLink("Keyboard", destination: KeyboardView())
                NavigationLink("Game Controllers", destination: GameControllerView())
                NavigationLink("Fonts", destination: FontsView())
                NavigationLink("Language & Region", destination: LanguageRegionView())
                NavigationLink("Dictionary", destination: DictionaryView())
            }
            
            Section {
                NavigationLink("VPN & Device Management", destination: VPNDeviceManagementView())
            }
            
            if !Configuration().isSimulator {
                Section {
                    NavigationLink("Legal & Regulatory", destination: EmptyView())
                }
            }
            
            Section {
                NavigationLink("Transfer or Reset \(UIDevice().localizedModel)", destination: {
                    Color(UIColor.systemGroupedBackground)
                        .ignoresSafeArea()
                        .navigationTitle("Transfer or Reset \(UIDevice().localizedModel)")
                })
                if !Configuration().isSimulator {
                    Button("Shut Down", action: {})
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        GeneralView()
    }
}
