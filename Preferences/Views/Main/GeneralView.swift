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
                SLink("About".localize(table: table), color: .gray, icon: UIDevice.IsSimulator ? "questionmark.app.dashed" : UIDevice.iPhone ? "iphone.gen3" : "ipad.gen2") {
                    AboutView()
                }
                if !UIDevice.IsSimulator {
                    SLink("SOFTWARE_UPDATE".localize(table: table), color: .gray, icon: "gear.badge") {
                        SoftwareUpdateView()
                    }
                    SLink("DEVICE_STORAGE".localize(table: table), color: .gray, icon: "externaldrive.fill") {
                        BundleControllerView("StorageSettingsUI", controller: "StorageSettingsUIWrapper", title: "DEVICE_STORAGE", table: table)
                    }
                }
            }
            
            if !UIDevice.IsSimulator {
                Section {
                    SLink("COVERAGE".localize(table: table), color: colorScheme == .dark ? Color(red: 208/255, green: 30/255, blue: 42/255) : .white, iconColor: Color(red: 208/255, green: 30/255, blue: 42/255), icon: "apple.logo") {
                        AppleCareWarrantyView()
                    }
                }
            }
            
            if !UIDevice.IsSimulator {
                Section {
                    SLink("AIRDROP".localize(table: table), color: colorScheme == .dark ? .blue : .white, iconColor: .blue, icon: "airdrop") {
                        AirDropView()
                    }
                    SLink("CONTINUITY".localize(table: table), color: .blue, icon: "airplay.video") {
                        BundleControllerView("AirPlayAndHandoffSettings", controller: "AirPlayAndHandoffSettings.AirPlayAndHandoffSettingsRoot", title: "CONTINUITY", table: table)
                    }
                    if UIDevice.iPhone {
                        SLink("PiP".localize(table: table), icon: "pip") {
                            BundleControllerView("PictureInPictureSettings", controller: "PictureInPictureSettings", title: "PiP", table: table)
                        }
                        SLink("Screen Capture".localize(table: table), icon: "camera.viewfinder") {}
                        SLink("CARPLAY".localize(table: table), color: .green, icon: "carplay") {
                            BundleControllerView("CarKitSettings", controller: "CRSettingsController", title: "CARPLAY", table: table)
                        }
                    }
                }
            }
            
            if !UIDevice.IsSimulator && UIDevice.HomeButtonCapability && UIDevice.iPhone {
                Button {
                    showingHomeButtonSheet = true
                } label: {
                    SLink("HOME_BUTTON".localize(table: table), color: .gray, icon: "iphone.gen1") {}
                }
                .foregroundStyle(.primary)
            }
            
            Section {
                SLink("AUTOFILL".localize(table: table), color: .gray, icon: "key.dots.fill") {
                    AutoFillPasswordsView()
                }
                if !UIDevice.IsSimulator {
                    SLink("AUTO_CONTENT_DOWNLOAD".localize(table: table), color: .gray, icon: "arrow.clockwise.app.stack.fill") {
                        BackgroundAppRefreshView()
                    }
                    SLink("DATE_AND_TIME".localize(table: table), color: .blue, icon: "calendar.badge.clock") {
                        DateTimeView()
                    }
                }
                SLink("DICTIONARY".localize(table: table), color: .blue, icon: "text.book.closed.fill") {
                    DictionaryView()
                }
                SLink("FONT_SETTING".localize(table: table), color: .gray, icon: "textformat") {
                    FontsView()
                }
//                if !UIDevice.isSimulator {
//                    SLink("GAME_CONTROLLER".localize(table: table), color: .gray, icon: "gamecontroller.fill") {
//                        GameControllerView()
//                    }
//                }
                SLink("Keyboard".localize(table: table), color: .gray, icon: "keyboard.fill") {
                    KeyboardView()
                }
                SLink("INTERNATIONAL".localize(table: table), color: .blue, icon: "globe") {
                    BundleControllerView("InternationalSettings", controller: "InternationalSettingsController", title: "INTERNATIONAL", table: table)
                }
            }
            
            if !UIDevice.IsSimulator {
                Section {
                    SLink("TV_PROVIDER_LABEL".localize(table: table), color: .black, icon: "cable.coaxial") {
                        TVProviderView()
                    }
                }
            }
            
            Section {
                SLink("VPN_DEVICE_MANAGEMENT".localize(table: table), color: .gray, icon: "gear") {
                    VPNDeviceManagementView()
                }
            }
            
            if !UIDevice.IsSimulator {
                Section {
                    SLink("LEGAL_AND_REGULATORY_TITLE".localize(table: table), color: .gray, icon: "checkmark.seal.text.page.fill") {
                        BundleControllerView("LegalAndRegulatorySettings", controller: "LegalAndRegulatorySettings.LegalAndRegulatorySettingsRoot", title: "LEGAL_AND_REGULATORY_TITLE", table: "General")
                    }
                }
            }
            
            Section {
                SLink("TRANSFER_OR_RESET_TITLE".localize(table: table), color: .gray, icon: "arrow.counterclockwise") {
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
