//
//  GeneralView.swift
//  Preferences
//
//  Settings > General
//

import SwiftUI

struct GeneralView: View {
    var body: some View {
        CustomList(title: String(localized: "General", table: "General")) {
            Section {
                SectionHelp(title: String(localized: "General", table: "General"), color: Color.gray, icon: "gear", description: "PLACARD_SUBTITLE")
            }
        
            Section {
                SettingsLink(color: .gray, icon: UIDevice.isSimulator ? "questionmark.app.dashed" : Device().isPhone ? "iphone.gen3" : "ipad.gen2", id: String(localized: "About", table: "General")) {
                    AboutView()
                }
                if !UIDevice.isSimulator {
                    SettingsLink(color: .gray, icon: "gear.badge", id: String(localized: "SOFTWARE_UPDATE", table: "General")) {
                        SoftwareUpdateView()
                    }
                    SettingsLink(color: .gray, icon: "externaldrive.fill", id: String(localized: "DEVICE_STORAGE", table: "General")) {}
                }
            }
            
            if !UIDevice.isSimulator {
                Section {
                    SettingsLink(icon: "appleCare", id: String(localized: "COVERAGE", table: "General")) {
                        AppleCareWarrantyView()
                    }
                }
            }
            
            if !UIDevice.isSimulator {
                Section {
                    SettingsLink(color: .white, iconColor: .blue, icon: "airdrop", id: "AirDrop") {}
                    SettingsLink(color: .blue, icon: "airplay.video", id: "AirPlay & Continuity") {}
                    if Device().isPhone {
                        SettingsLink(icon: "pip", id: "Picture in Picture") {}
                        SettingsLink(color: .green, icon: "carplay", id: "CarPlay") {}
                    }
                }
            }
            
            if !UIDevice.isSimulator && Device().hasHomeButton {
                NavigationLink("Home Button", destination: EmptyView())
                SettingsLink(color: .gray, icon: "iphone.gen1", id: "Home Button") {}
            }
            
            Section {
                SettingsLink(color: .gray, icon: "ellipsis.rectangle", id: "AutoFill & Passwords") {
                    AutoFillPasswordsView()
                }
                if !UIDevice.isSimulator {
                    SettingsLink(color: .gray, icon: "arrow.circlepath", id: "Background App Refresh") {}
                    SettingsLink(color: .blue, icon: "calendar.badge.clock", id: "Date & Time") {}
                }
                SettingsLink(color: .blue, icon: "character.book.closed.fill", id: "Dictionary") {
                    DictionaryView()
                }
                SettingsLink(color: .gray, icon: "textformat", id: "Fonts") {
                    FontsView()
                }
                if !UIDevice.isSimulator {
                    SettingsLink(color: .gray, icon: "gamecontroller.fill", id: "Game Controller") {
                        GameControllerView()
                    }
                    SettingsLink(color: .gray, icon: "keyboard.fill", id: "Keyboard") {
                        KeyboardView()
                    }
                }
                SettingsLink(color: .blue, icon: "globe", id: "Language & Region") {
                    LanguageRegionView()
                }
            }
            
            if !UIDevice.isSimulator {
                Section {
                    SettingsLink(icon: "cable.coaxial", id: "TV Provider") {}
                }
            }
            
            Section {
                SettingsLink(color: .gray, icon: "gear", id: "VPN & Device Management") {
                    VPNDeviceManagementView()
                }
            }
            
            if !UIDevice.isSimulator {
                Section {
                    SettingsLink(color: .gray, icon: "text.justify.left", id: "Legal & Regulatory") {}
                }
            }
            
            Section {
                SettingsLink(color: .gray, icon: "arrow.counterclockwise", id: "Transfer or Reset \(Device().model)") {
                    if !UIDevice.isSimulator {
                        TransferResetView()
                    }
                }
                if !UIDevice.isSimulator {
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
