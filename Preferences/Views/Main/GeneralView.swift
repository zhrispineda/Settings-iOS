//
//  GeneralView.swift
//  Preferences
//
//  Settings > General
//

import SwiftUI

struct GeneralView: View {
    @Environment(\.colorScheme) private var colorScheme
    @State private var opacity: Double = 0
    @State private var frameY: Double = 0
    @State private var showingHomeButtonSheet: Bool = false
    let path = "/System/Library/PrivateFrameworks/Settings/GeneralSettingsUI.framework"
    let table = "General"
    
    var body: some View {
        CustomList(title: "General".localized(path: path, table: table)) {
            Section {
                Placard(
                    title: "General".localized(
                        path: path,
                        table: table
                    ),
                    icon: "com.apple.graphic-icon.gear",
                    description: "PLACARD_SUBTITLE".localized(
                        path: path
                    ),
                    frameY: $frameY,
                    opacity: $opacity
                )
            }
            
            Section {
                SLink("About".localized(path: path, table: table), icon: "com.apple.graphic-icon.about-current-device") {
                    AboutView()
                }
                if !UIDevice.IsSimulator {
                    SLink("SOFTWARE_UPDATE".localized(path: path, table: table), icon: "com.apple.graphic-icon.software-update") {
                        SoftwareUpdateView()
                    }
                    SLink("DEVICE_STORAGE".localized(path: path, table: table), icon: "com.apple.graphic-icon.external-drive") {
                        BundleControllerView("StorageSettingsUI", controller: "StorageSettingsUIWrapper", title: "DEVICE_STORAGE".localized(path: path, table: table))
                    }
                }
            }
            
            if !UIDevice.IsSimulator {
                Section {
                    SLink("COVERAGE".localized(path: path, table: table), icon: "com.apple.graphic-icon.applecare") {
                        AppleCareWarrantyView()
                    }
                }
            }
            
            if !UIDevice.IsSimulator {
                Section {
                    SLink("AIRDROP".localized(path: path, table: table), icon: "com.apple.graphic-icon.airdrop") {
                        AirDropView()
                    }
                    SLink("CONTINUITY".localized(path: path, table: table), icon: "com.apple.graphic-icon.airplay-video") {
                        BundleControllerView("AirPlayAndHandoffSettings", controller: "AirPlayAndHandoffSettings.AirPlayAndHandoffSettingsRoot", title: "CONTINUITY".localized(path: path, table: table))
                    }
                    if UIDevice.iPhone {
                        SLink("PiP".localized(path: path, table: table), icon: "com.apple.graphic-icon.picture-in-picture") {
                            BundleControllerView("PictureInPictureSettings", controller: "PictureInPictureSettings", title: "PiP".localized(path: path, table: table))
                        }
                    }
                    SLink("Screen Capture".localized(path: path, table: table), icon: "com.apple.graphic-icon.screenshots") {
                        ScreenCaptureView()
                    }
                    if UIDevice.iPhone {
                        SLink("CARPLAY".localized(path: path, table: table), icon: "com.apple.graphic-icon.carplay") {
                            BundleControllerView("CarKitSettings", controller: "CRSettingsController", title: "CARPLAY".localized(path: path, table: table))
                        }
                    }
                }
            }
            
            if !UIDevice.IsSimulator && UIDevice.HomeButtonCapability && UIDevice.iPhone {
                Button {
                    showingHomeButtonSheet = true
                } label: {
                    SLink("HOME_BUTTON".localized(path: path, table: table), icon: "com.apple.graphic-icon.iphone-home-button") {}
                }
                .foregroundStyle(.primary)
            }
            
            Section {
                SLink("AUTOFILL".localized(path: path, table: table), icon: "com.apple.graphic-icon.autofill") {
                    AutoFillPasswordsView()
                }
                if !UIDevice.IsSimulator {
                    SLink("AUTO_CONTENT_DOWNLOAD".localized(path: path, table: table), icon: "com.apple.graphic-icon.background-app-refresh") {
                        BackgroundAppRefreshView()
                    }
                    SLink("DATE_AND_TIME".localized(path: path, table: table), icon: "com.apple.graphic-icon.date-and-time") {
                        DateTimeView()
                    }
                }
                SLink("DICTIONARY".localized(path: path, table: table), icon: "com.apple.graphic-icon.dictionary") {
                    DictionaryView()
                }
                SLink("FONT_SETTING".localized(path: path, table: table), icon: "com.apple.graphic-icon.fonts") {
                    FontsView()
                }
                SLink("Keyboard".localized(path: path, table: table), icon: "com.apple.graphic-icon.keyboard") {
                    KeyboardView()
                }
                SLink("INTERNATIONAL".localized(path: path, table: table), icon: "com.apple.graphic-icon.language") {
                    BundleControllerView("InternationalSettings", controller: "InternationalSettingsController", title: "INTERNATIONAL".localized(path: path, table: table))
                }
            }
            
            if !UIDevice.IsSimulator {
                Section {
                    SLink("TV_PROVIDER_LABEL".localized(path: path, table: table), icon: "com.apple.graphic-icon.tv-provider") {
                        TVProviderView()
                    }
                }
            }
            
            Section {
                SLink("VPN_DEVICE_MANAGEMENT".localized(path: path, table: table), icon: "com.apple.graphic-icon.device-management") {
                    VPNDeviceManagementView()
                }
            }
            
            if !UIDevice.IsSimulator {
                Section {
                    SLink("LEGAL_AND_REGULATORY_TITLE".localized(path: path, table: table), icon: "com.apple.graphic-icon.legal-and-regulatory") {
                        BundleControllerView("LegalAndRegulatorySettings", controller: "LegalAndRegulatorySettings.LegalAndRegulatorySettingsRoot", title: "LEGAL_AND_REGULATORY_TITLE".localized(path: path, table: table))
                    }
                }
            }
            
            Section {
                SLink("TRANSFER_OR_RESET_TITLE".localized(path: path, table: table), icon: UIDevice.iPhone ? "com.apple.graphic-icon.transfer-or-reset-iphone" : "com.apple.graphic-icon.transfer-or-reset-ipad") {
                    if !UIDevice.IsSimulator {
                        BundleControllerView("/System/Library/PrivateFrameworks/Settings/GeneralSettingsUI.framework/GeneralSettingsUI", controller: "PSGTransferOrResetController", title: "TRANSFER_OR_RESET_TITLE".localized(path: path, table: table))
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
                    Button("SHUTDOWN_LABEL".localized(path: path, table: table)) {}
                }
            }
        }
        .fullScreenCover(isPresented: $showingHomeButtonSheet) {
            NavigationStack {
                CustomViewController("/System/Library/PrivateFrameworks/Settings/GeneralSettingsUI.framework/GeneralSettingsUI", controller: "PSGHomeButtonCustomizeController")
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button(role: .confirm) {
                                showingHomeButtonSheet = false
                            }
                        }
                    }
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("General".localized(path: path, table: table))
                    .fontWeight(.semibold)
                    .font(.subheadline)
                    .opacity(frameY < 50.0 ? opacity : 0)
            }
        }
    }
}

#Preview {
    NavigationStack {
        GeneralView()
    }
}
