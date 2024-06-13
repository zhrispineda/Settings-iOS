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
                SectionHelp(title: "General", color: Color.gray, icon: "gear", description: "Manage your overall setup and preferences for \(Device().model), such as software updates, device language\(Device().isPhone ? ", CarPlay" : ""), AirDrop, and more.")
            }
        
            Section {
                SettingsLink(color: .gray, icon: Configuration().isSimulator ? "questionmark.app.dashed" : Device().isPhone ? "iphone.gen3" : "ipad.gen2", id: "About") {
                    AboutView()
                }
                if !Configuration().isSimulator {
                    SettingsLink(color: .gray, icon: "gear.badge", id: "Software Update") {
                        SoftwareUpdateView()
                    }
                    SettingsLink(color: .gray, icon: "externaldrive.fill", id: "\(Device().model) Storage") {}
                }
            }
            
            if !Configuration().isSimulator {
                Section {
                    SettingsLink(icon: "applecare", id: "AppleCare & Warranty") {}
                }
            }
            
            if !Configuration().isSimulator {
                Section {
                    SettingsLink(icon: "airdrop", id: "AirDrop") {
                        EmptyView()
                    }
                    SettingsLink(color: .blue, icon: "airplay.video", id: "AirPlay & Continuity") {
                        EmptyView()
                    }
                    if Device().isPhone {
                        SettingsLink(icon: "pip", id: "Picture in Picture") {
                            EmptyView()
                        }
                        SettingsLink(color: .green, icon: "carplay", id: "CarPlay") {
                            EmptyView()
                        }
                    }
                }
            }
            
            if !Configuration().isSimulator && Device().hasHomeButton {
                NavigationLink("Home Button", destination: EmptyView())
                SettingsLink(color: .gray, icon: "iphone.gen1", id: "Home Button") {}
            }
            
            Section {
                SettingsLink(color: .gray, icon: "ellipsis.rectangle", id: "AutoFill & Passwords") {}
                if !Configuration().isSimulator {
                    SettingsLink(color: .gray, icon: "arrow.circlepath", id: "Background App Refresh") {}
                    SettingsLink(color: .blue, icon: "calendar.badge.clock", id: "Date & Time") {
                        DictionaryView()
                    }
                }
                SettingsLink(color: .blue, icon: "character.book.closed.fill", id: "Dictionary") {
                    DictionaryView()
                }
                SettingsLink(color: .gray, icon: "textformat", id: "Fonts") {
                    FontsView()
                }
                if !Configuration().isSimulator {
                    SettingsLink(color: .gray, icon: "gamecontroller.fill", id: "Game Controller") {
                        GameControllerView()
                    }
                    SettingsLink(color: .gray, icon: "keyboard.fill", id: "Keyboard") {}
                }
                SettingsLink(color: .blue, icon: "globe", id: "Language & Region") {
                    LanguageRegionView()
                }
            }
            
            if !Configuration().isSimulator {
                Section {
                    SettingsLink(icon: "cable.coaxial", id: "TV Provider") {}
                }
            }
            
            Section {
                SettingsLink(color: .gray, icon: "gear", id: "VPN & Device Management") {
                    VPNDeviceManagementView()
                }
            }
            
            if !Configuration().isSimulator {
                Section {
                    SettingsLink(color: .gray, icon: "text.justify.left", id: "Legal & Regulatory") {}
                }
            }
            
            Section {
                SettingsLink(color: .gray, icon: "arrow.counterclockwise", id: "Transfer or Reset \(UIDevice().localizedModel)") {}
                if !Configuration().isSimulator {
                    Button("Shut Down") {}
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
