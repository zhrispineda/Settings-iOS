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
                SettingsLink(color: .gray, icon: Configuration().isSimulator ? "questionmark.app.dashed" : DeviceInfo().isPhone ? "iphone.gen3" : "ipad.gen2", id: "About", content: {
                    AboutView()
                })
                if !Configuration().isSimulator {
                    SettingsLink(color: .gray, icon: "gear.badge", id: "Software Update", content: {
                        SoftwareUpdateView()
                    })
                    SettingsLink(color: .gray, icon: "externaldrive.fill", id: "\(DeviceInfo().model) Storage", content: {
                        EmptyView()
                    })
                }
            }
            
            if !Configuration().isSimulator {
                Section {
                    SettingsLink(icon: "applecare", id: "AppleCare & Warranty", content: {
                        EmptyView()
                    })
                }
            }
            
            if !Configuration().isSimulator {
                Section {
                    SettingsLink(icon: "airdrop", id: "AirDrop", content: {
                        EmptyView()
                    })
                    SettingsLink(color: .blue, icon: "airplay.video", id: "AirPlay & Continuity", content: {
                        EmptyView()
                    })
                    if DeviceInfo().isPhone {
                        SettingsLink(icon: "pip", id: "Picture in Picture", content: {
                            EmptyView()
                        })
                        SettingsLink(color: .green, icon: "carplay", id: "CarPlay", content: {
                            EmptyView()
                        })
                    }
                }
            }
            
            if !Configuration().isSimulator && DeviceInfo().hasHomeButton {
                NavigationLink("Home Button", destination: EmptyView())
                SettingsLink(color: .gray, icon: "iphone.gen1", id: "Home Button", content: {
                    EmptyView()
                })
            }
            
            Section {
                SettingsLink(color: .gray, icon: "ellipsis.rectangle", id: "AutoFill & Passwords", content: {
                    EmptyView()
                })
                if !Configuration().isSimulator {
                    SettingsLink(color: .gray, icon: "arrow.circlepath", id: "Background App Refresh", content: {
                        EmptyView()
                    })
                    SettingsLink(color: .blue, icon: "calendar.badge.clock", id: "Date & Time", content: {
                        DictionaryView()
                    })
                }
                SettingsLink(color: .blue, icon: "character.book.closed.fill", id: "Dictionary", content: {
                    DictionaryView()
                })
                SettingsLink(color: .gray, icon: "textformat", id: "Fonts", content: {
                    FontsView()
                })
                if !Configuration().isSimulator {
                    SettingsLink(color: .gray, icon: "gamecontroller.fill", id: "Game Controller", content: {
                        GameControllerView()
                    })
                    SettingsLink(color: .gray, icon: "keyboard.fill", id: "Keyboard", content: {
                        EmptyView()
                    })
                }
                SettingsLink(color: .blue, icon: "globe", id: "Language & Region", content: {
                    LanguageRegionView()
                })
            }
            
            if !Configuration().isSimulator {
                Section {
                    SettingsLink(icon: "cable.coaxial", id: "TV Provider", content: {
                        EmptyView()
                    })
                }
            }
            
            Section {
                SettingsLink(color: .gray, icon: "gear", id: "VPN & Device Management", content: { VPNDeviceManagementView() })
            }
            
            if !Configuration().isSimulator {
                Section {
                    SettingsLink(color: .gray, icon: "text.justify.left", id: "Legal & Regulatory", content: {
                        EmptyView()
                    })
                }
            }
            
            Section {
                SettingsLink(color: .gray, icon: "arrow.counterclockwise", id: "Transfer or Reset \(UIDevice().localizedModel)", content: {
                    EmptyView()
                })
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
