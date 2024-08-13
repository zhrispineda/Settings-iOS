//
//  GeneralView.swift
//  Preferences
//
//  Settings > General
//

import SwiftUI

struct GeneralView: View {
    var body: some View {
        CustomList {
            Section {
                SectionHelp(title: String(localized: "General", table: "General"), color: Color.gray, icon: "gear", description: "PLACARD_SUBTITLE")
            }
        
            Section {
                SettingsLink(color: .gray, icon: UIDevice.isSimulator ? "questionmark.app.dashed" : UIDevice.iPhone ? "iphone.gen3" : "ipad.gen2", id: String(localized: "About", table: "General")) {
                    AboutView()
                }
                if !UIDevice.isSimulator {
                    SettingsLink(color: .gray, icon: "gear.badge", id: String(localized: "SOFTWARE_UPDATE", table: "General")) {
                        SoftwareUpdateView()
                    }
                    SettingsLink(color: .gray, icon: "externaldrive.fill", id: String(localized: "DEVICE_STORAGE", table: "General")) {
                        StorageView()
                    }
                }
            }
            
            if !UIDevice.isSimulator {
                Section {
                    SettingsLink(color: Color.clear, icon: "appleCare", id: String(localized: "COVERAGE", table: "General")) {
                        AppleCareWarrantyView()
                    }
                }
            }
            
            if !UIDevice.isSimulator {
                Section {
                    SettingsLink(color: .white, iconColor: .blue, icon: "airdrop", id: String(localized: "AIRDROP", table: "General")) {
                        AirDropView()
                    }
                    SettingsLink(color: .blue, icon: "airplay.video", id: String(localized: "CONTINUITY", table: "General")) {}
                    if UIDevice.iPhone {
                        SettingsLink(icon: "pip", id: String(localized: "PiP", table: "General")) {}
                        SettingsLink(color: .green, icon: "carplay", id: String(localized: "CARPLAY", table: "General")) {
                            CarPlayView()
                        }
                    }
                }
            }
            
            if !UIDevice.isSimulator && UIDevice.HomeButtonCapability {
                SettingsLink(color: .gray, icon: "iphone.gen1", id: String(localized: "HOME_BUTTON", table: "General")) {}
            }
            
            Section {
                SettingsLink(color: .gray, icon: "key.dots.fill", id: String(localized: "AUTOFILL", table: "General")) {
                    AutoFillPasswordsView()
                }
                if !UIDevice.isSimulator {
                    SettingsLink(color: .gray, icon: "arrow.clockwise.app.stack.fill", id: String(localized: "AUTO_CONTENT_DOWNLOAD", table: "General")) {}
                    SettingsLink(color: .blue, icon: "calendar.badge.clock", id: String(localized: "DATE_AND_TIME", table: "General")) {}
                }
                SettingsLink(color: .blue, icon: "text.book.closed.fill", id: String(localized: "DICTIONARY", table: "General")) {
                    DictionaryView()
                }
                SettingsLink(color: .gray, icon: "textformat", id: String(localized: "FONT_SETTING", table: "General")) {
                    FontsView()
                }
//                if !UIDevice.isSimulator {
//                    SettingsLink(color: .gray, icon: "gamecontroller.fill", id: String(localized: "GAME_CONTROLLER", table: "General")) {
//                        GameControllerView()
//                    }
//                }
                SettingsLink(color: .gray, icon: "keyboard.fill", id: String(localized: "Keyboard", table: "General")) {
                    KeyboardView()
                }
                SettingsLink(color: .blue, icon: "globe", id: String(localized: "INTERNATIONAL", table: "General")) {
                    LanguageRegionView()
                }
            }
            
            if !UIDevice.isSimulator {
                Section {
                    SettingsLink(icon: "cable.coaxial", id: String(localized: "TV_PROVIDER_LABEL", table: "General")) {}
                }
            }
            
            Section {
                SettingsLink(color: .gray, icon: "gear", id: String(localized: "VPN_DEVICE_MANAGEMENT", table: "General")) {
                    VPNDeviceManagementView()
                }
            }
            
            if !UIDevice.isSimulator {
                Section {
                    SettingsLink(color: .gray, icon: "checkmark.seal.text.page.fill", id: String(localized: "LEGAL_AND_REGULATORY_TITLE", table: "General")) {}
                }
            }
            
            Section {
                SettingsLink(color: .gray, icon: "arrow.counterclockwise", id: String(localized: "TRANSFER_OR_RESET_TITLE", table: "General")) {
                    if !UIDevice.isSimulator {
                        TransferResetView()
                    }
                }
            }
            
            if !UIDevice.isSimulator {
                Section {
                    Button(String(localized: "SHUTDOWN_LABEL", table: "General")) {}
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
