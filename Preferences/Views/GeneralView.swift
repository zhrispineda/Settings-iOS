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
                SectionHelp(title: "General", color: Color.gray, icon: "gear", description: "Manage your overall setup and preferences for \(DeviceInfo().model), such as software updates, device language\(DeviceInfo().isPhone ? ", CarPlay" : ""), AirDrop, and more.")
            }
        
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
                    NavigationLink("Keyboard", destination: KeyboardView())
                }
                SettingsLink(color: .gray, icon: "ellipsis.rectangle", id: "AutoFill & Passwords", content: { EmptyView() })
                SettingsLink(color: .blue, icon: "character.book.closed.fill", id: "Dictionary", content: { DictionaryView() })
                SettingsLink(color: .gray, icon: "textformat", id: "Fonts", content: { FontsView() })
                SettingsLink(color: .blue, icon: "globe", id: "Language & Region", content: { LanguageRegionView() })
                //NavigationLink("Game Controllers", destination: GameControllerView())
            }
            
            Section {
                SettingsLink(color: .gray, icon: "gear", id: "VPN & Device Management", content: { VPNDeviceManagementView() })
            }
            
            if !Configuration().isSimulator {
                Section {
                    NavigationLink("Legal & Regulatory", destination: EmptyView())
                }
            }
            
            Section {
                SettingsLink(color: .gray, icon: "arrow.counterclockwise", id: "Transfer or Reset \(UIDevice().localizedModel)", content: { EmptyView() })
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
