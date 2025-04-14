//
//  GeneralView.swift
//  Preferences
//
//  Settings > General
//

import SwiftUI

struct GeneralView: View {
    // Variables
    @Environment(\.colorScheme) private var colorScheme
    @State private var opacity: Double = 0
    @State private var frameY: Double = 0
    @State private var showingHomeButtonSheet: Bool = false
    let table = "General"
    
    var body: some View {
        CustomList(title: "back".localize(table: "AXUILocalizedStrings")) {
            Section {
                Placard(title: "General".localize(table: table), color: Color.gray, icon: "gear", description: "PLACARD_SUBTITLE".localize(table: "GeneralSettingsUI"), frameY: $frameY, opacity: $opacity)
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
                        BundleControllerView("StorageSettingsUI", controller: "StorageSettingsUIWrapper", title: "DEVICE_STORAGE", table: table)
                    }
                }
            }
            
            if !UIDevice.IsSimulator {
                Section {
                    SettingsLink(color: colorScheme == .dark ? Color(red: 208/255, green: 30/255, blue: 42/255) : .white, iconColor: Color(red: 208/255, green: 30/255, blue: 42/255), icon: "apple.logo", id: "COVERAGE".localize(table: table)) {
                        AppleCareWarrantyView()
                    }
                }
            }
            
            if !UIDevice.IsSimulator {
                Section {
                    SettingsLink(color: colorScheme == .dark ? .blue : .white, iconColor: .blue, icon: "airdrop", id: "AIRDROP".localize(table: table)) {
                        AirDropView()
                    }
                    SettingsLink(color: .blue, icon: "airplay.video", id: "CONTINUITY".localize(table: table)) {
                        BundleControllerView("AirPlayAndHandoffSettings", controller: "AirPlayAndHandoffSettings.AirPlayAndHandoffSettingsRoot", title: "CONTINUITY", table: table)
                    }
                    if UIDevice.iPhone {
                        SettingsLink(icon: "pip", id: "PiP".localize(table: table)) {
                            BundleControllerView("PictureInPictureSettings", controller: "PictureInPictureSettings", title: "PiP", table: table)
                        }
                        SettingsLink(color: .green, icon: "carplay", id: "CARPLAY".localize(table: table)) {
                            BundleControllerView("CarKitSettings", controller: "CRSettingsController", title: "CARPLAY", table: table)
                        }
                    }
                }
            }
            
            if !UIDevice.IsSimulator && UIDevice.HomeButtonCapability && UIDevice.iPhone {
                Button {
                    showingHomeButtonSheet = true
                } label: {
                    SettingsLink(color: .gray, icon: "iphone.gen1", id: "HOME_BUTTON".localize(table: table)) {}
                }
                .foregroundStyle(.primary)
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
                    BundleControllerView("InternationalSettings", controller: "InternationalSettingsController", title: "INTERNATIONAL", table: table)
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
                        BundleControllerView("LegalAndRegulatorySettings", controller: "LegalAndRegulatorySettings.LegalAndRegulatorySettingsRoot", title: "LEGAL_AND_REGULATORY_TITLE", table: "General")
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
        .fullScreenCover(isPresented: $showingHomeButtonSheet) {
            NavigationStack {
                CustomViewController("/System/Library/PrivateFrameworks/Settings/GeneralSettingsUI.framework/GeneralSettingsUI", controller: "PSGHomeButtonCustomizeController")
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button("Done") {
                                showingHomeButtonSheet = false
                            }
                            .bold()
                        }
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

struct GeneralRoute: Routable {
    func destination() -> AnyView {
        AnyView(GeneralView())
    }
}

#Preview {
    NavigationStack {
        GeneralView()
    }
}
