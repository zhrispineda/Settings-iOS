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
        CustomList {
            Section {
                Placard(title: "General".localize(table: table), icon: "com.apple.graphic-icon.gear", description: "PLACARD_SUBTITLE".localize(table: "GeneralSettingsUI"), frameY: $frameY, opacity: $opacity)
            }
            
            Section {
                SLink("About".localize(table: table), icon: "com.apple.graphic-icon.about-current-device") {
                    AboutView()
                }
                if !UIDevice.IsSimulator {
                    SLink("SOFTWARE_UPDATE".localize(table: table), icon: "com.apple.graphic-icon.software-update") {
                        SoftwareUpdateView()
                    }
                    SLink("DEVICE_STORAGE".localize(table: table), color: .gray, icon: "com.apple.graphic-icon.external-drive") {
                        BundleControllerView("StorageSettingsUI", controller: "StorageSettingsUIWrapper", title: "DEVICE_STORAGE", table: table)
                    }
                }
            }
            
            if !UIDevice.IsSimulator {
                Section {
                    SLink("COVERAGE".localize(table: table), icon: "com.apple.graphic-icon.applecare") {
                        AppleCareWarrantyView()
                    }
                }
            }
            
            if !UIDevice.IsSimulator {
                Section {
                    SLink("AIRDROP".localize(table: table), icon: "com.apple.graphic-icon.airdrop") {
                        AirDropView()
                    }
                    SLink("CONTINUITY".localize(table: table), icon: "com.apple.graphic-icon.airplay-video") {
                        BundleControllerView("AirPlayAndHandoffSettings", controller: "AirPlayAndHandoffSettings.AirPlayAndHandoffSettingsRoot", title: "CONTINUITY", table: table)
                    }
                    if UIDevice.iPhone {
                        SLink("PiP".localize(table: table), icon: "com.apple.graphic-icon.picture-in-picture") {
                            BundleControllerView("PictureInPictureSettings", controller: "PictureInPictureSettings", title: "PiP", table: table)
                        }
                        SLink("Screen Capture".localize(table: table), icon: "com.apple.graphic-icon.screenshots") {}
                        SLink("CARPLAY".localize(table: table), icon: "com.apple.graphic-icon.carplay") {
                            BundleControllerView("CarKitSettings", controller: "CRSettingsController", title: "CARPLAY", table: table)
                        }
                    }
                }
            }
            
            if !UIDevice.IsSimulator && UIDevice.HomeButtonCapability && UIDevice.iPhone {
                Button {
                    showingHomeButtonSheet = true
                } label: {
                    SLink("HOME_BUTTON".localize(table: table), icon: "com.apple.graphic-icon.iphone-home-button") {}
                }
                .foregroundStyle(.primary)
            }
            
            Section {
                SLink("AUTOFILL".localize(table: table), icon: "com.apple.graphic-icon.autofill") {
                    AutoFillPasswordsView()
                }
                if !UIDevice.IsSimulator {
                    SLink("AUTO_CONTENT_DOWNLOAD".localize(table: table), icon: "com.apple.graphic-icon.background-app-refresh") {
                        BackgroundAppRefreshView()
                    }
                    SLink("DATE_AND_TIME".localize(table: table), icon: "com.apple.graphic-icon.date-and-time") {
                        DateTimeView()
                    }
                }
                SLink("DICTIONARY".localize(table: table), icon: "com.apple.graphic-icon.dictionary") {
                    DictionaryView()
                }
                SLink("FONT_SETTING".localize(table: table), icon: "com.apple.graphic-icon.fonts") {
                    FontsView()
                }
                SLink("Keyboard".localize(table: table), icon: "com.apple.graphic-icon.keyboard") {
                    KeyboardView()
                }
                SLink("INTERNATIONAL".localize(table: table), icon: "com.apple.graphic-icon.language") {
                    BundleControllerView("InternationalSettings", controller: "InternationalSettingsController", title: "INTERNATIONAL", table: table)
                }
            }
            
            if !UIDevice.IsSimulator {
                Section {
                    SLink("TV_PROVIDER_LABEL".localize(table: table), icon: "com.apple.graphic-icon.tv-provider") {
                        TVProviderView()
                    }
                }
            }
            
            Section {
                SLink("VPN_DEVICE_MANAGEMENT".localize(table: table), icon: "com.apple.graphic-icon.device-management") {
                    VPNDeviceManagementView()
                }
            }
            
            if !UIDevice.IsSimulator {
                Section {
                    SLink("LEGAL_AND_REGULATORY_TITLE".localize(table: table), icon: "com.apple.graphic-icon.legal-and-regulatory") {
                        BundleControllerView("LegalAndRegulatorySettings", controller: "LegalAndRegulatorySettings.LegalAndRegulatorySettingsRoot", title: "LEGAL_AND_REGULATORY_TITLE", table: "General")
                    }
                }
            }
            
            Section {
                SLink("TRANSFER_OR_RESET_TITLE".localize(table: table), icon: UIDevice.iPhone ? "com.apple.graphic-icon.transfer-or-reset-iphone" : "com.apple.graphic-icon.transfer-or-reset-ipad") {
                    if !UIDevice.IsSimulator {
                        BundleControllerView("/System/Library/PrivateFrameworks/Settings/GeneralSettingsUI.framework/GeneralSettingsUI", controller: "PSGTransferOrResetController", title: "TRANSFER_OR_RESET_TITLE", table: table)
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
