//
//  GeneralView.swift
//  Preferences
//
//  Settings > General
//

import SwiftUI

struct GeneralView: View {
    // Variables
    @State private var opacity: Double = 0
    @State private var frameY: Double = 0
    let table = "General"
    
    var body: some View {
        CustomList(title: "Back") {
            Section {
                Placard(title: "General".localize(table: table), color: Color.gray, icon: "gear", description: "PLACARD_SUBTITLE".localize(table: "GeneralSettingsUI"))
                    .overlay { // For calculating opacity of the principal toolbar item
                        GeometryReader { geo in
                            Color.clear
                                .onChange(of: geo.frame(in: .scrollView).minY) {
                                    frameY = geo.frame(in: .scrollView).minY
                                    opacity = frameY / -30
                                }
                        }
                    }
            }
        
            Section {
                SettingsLink(color: .gray, icon: UIDevice.IsSimulator ? "questionmark.app.dashed" : UIDevice.iPhone ? "iphone.gen3" : "ipad.gen2", id: "About".localize(table: table)) {
                    AboutView()
                }
                if !UIDevice.IsSimulator {
                    SettingsLink(color: .gray, icon: "gear.badge", id: "SOFTWARE_UPDATE".localize(table: table)) {
                        SoftwareUpdateView()
                    }
                    SettingsLink(color: .gray, icon: "externaldrive.fill", id: "DEVICE_STORAGE".localize(table: table)) {
                        StorageView()
                    }
                }
            }
            
            if !UIDevice.IsSimulator {
                Section {
                    SettingsLink(color: Color.white, icon: "appleCare", id: "COVERAGE".localize(table: table)) {
                        AppleCareWarrantyView()
                    }
                }
            }
            
            if !UIDevice.IsSimulator {
                Section {
                    SettingsLink(color: .white, iconColor: .blue, icon: "airdrop", id: "AIRDROP".localize(table: table)) {
                        AirDropView()
                    }
                    SettingsLink(color: .blue, icon: "airplay.video", id: "CONTINUITY".localize(table: table)) {
                        AirPlayContinuityView()
                    }
                    if UIDevice.iPhone {
                        SettingsLink(icon: "pip", id: "PiP".localize(table: table)) {
                            PiPView()
                        }
                        SettingsLink(color: .green, icon: "carplay", id: "CARPLAY".localize(table: table)) {
                            CarPlayView()
                        }
                    }
                }
            }
            
            if !UIDevice.IsSimulator && UIDevice.HomeButtonCapability {
                SettingsLink(color: .gray, icon: "iphone.gen1", id: "HOME_BUTTON".localize(table: table)) {}
            }
            
            Section {
                SettingsLink(color: .gray, icon: "key.dots.fill", id: "AUTOFILL".localize(table: table)) {
                    AutoFillPasswordsView()
                }
                if !UIDevice.IsSimulator {
                    SettingsLink(color: .gray, icon: "arrow.clockwise.app.stack.fill", id: "AUTO_CONTENT_DOWNLOAD".localize(table: table)) {
                        BackgroundAppRefreshView()
                    }
                    SettingsLink(color: .blue, icon: "calendar.badge.clock", id: "DATE_AND_TIME".localize(table: table)) {
                        DateTimeView()
                    }
                }
                SettingsLink(color: .blue, icon: "text.book.closed.fill", id: "DICTIONARY".localize(table: table)) {
                    DictionaryView()
                }
                SettingsLink(color: .gray, icon: "textformat", id: "FONT_SETTING".localize(table: table)) {
                    FontsView()
                }
//                if !UIDevice.isSimulator {
//                    SettingsLink(color: .gray, icon: "gamecontroller.fill", id: "GAME_CONTROLLER".localize(table: table)) {
//                        GameControllerView()
//                    }
//                }
                SettingsLink(color: .gray, icon: "keyboard.fill", id: "Keyboard".localize(table: table)) {
                    KeyboardView()
                }
                SettingsLink(color: .blue, icon: "globe", id: "INTERNATIONAL".localize(table: table)) {
                    LanguageRegionView()
                }
            }
            
            if !UIDevice.IsSimulator {
                Section {
                    SettingsLink(icon: "cable.coaxial", id: "TV_PROVIDER_LABEL".localize(table: table)) {
                        TVProviderView()
                    }
                }
            }
            
            Section {
                SettingsLink(color: .gray, icon: "gear", id: "VPN_DEVICE_MANAGEMENT".localize(table: table)) {
                    VPNDeviceManagementView()
                }
            }
            
            if !UIDevice.IsSimulator {
                Section {
                    SettingsLink(color: .gray, icon: "checkmark.seal.text.page.fill", id: "LEGAL_AND_REGULATORY_TITLE".localize(table: table)) {
                        LegalRegulatoryView()
                    }
                }
            }
            
            Section {
                SettingsLink(color: .gray, icon: "arrow.counterclockwise", id: "TRANSFER_OR_RESET_TITLE".localize(table: table)) {
                    if !UIDevice.IsSimulator {
                        TransferResetView()
                    } else {
                        Text(String())
                            .onAppear {
                                exit(0)
                            }
                    }
                }
            }
            
            if !UIDevice.IsSimulator {
                Section {
                    Button("SHUTDOWN_LABEL".localize(table: table)) {}
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("General".localize(table: table))
                    .fontWeight(.semibold)
                    .font(.subheadline)
                    .opacity(frameY < 50.0 ? opacity : 0) // Only fade when passing the help section title at the top
            }
        }
    }
}

#Preview {
    NavigationStack {
        GeneralView()
    }
}
