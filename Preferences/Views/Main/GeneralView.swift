//
//  GeneralView.swift
//  Preferences
//

import SwiftUI

/// The view located at `Settings > General`.
struct GeneralView: View {
    @State private var frameY = 0.0
    @State private var opacity = 0.0
    @State private var showingHomeButtonSheet = false
    private let path = "/System/Library/PrivateFrameworks/Settings/GeneralSettingsUI.framework"
    private let table = "General"
    
    var body: some View {
        CustomList(title: "General".localized(path: path, table: table)) {
            Section {
                Placard(
                    title: "General".localized(path: path, table: table),
                    icon: "com.apple.graphic-icon.gear",
                    description: "PLACARD_SUBTITLE".localized(path: path),
                    frameY: $frameY,
                    opacity: $opacity
                )
            }
            
            Section {
                SLink(
                    "About".localized(path: path, table: table),
                    icon: "com.apple.graphic-icon.about-current-device",
                    destination: AboutView()
                )
                if !UIDevice.IsSimulator {
                    SLink(
                        "SOFTWARE_UPDATE".localized(path: path, table: table),
                        icon: "com.apple.graphic-icon.software-update",
                        destination: SoftwareUpdateView()
                    )
                    SLink(
                        "DEVICE_STORAGE".localized(path: path, table: table),
                        icon: "com.apple.graphic-icon.external-drive"
                    ) {
                        BundleControllerView(
                            "StorageSettingsUI",
                            controller: "StorageSettingsUIWrapper",
                            title: "DEVICE_STORAGE".localized(path: path, table: table)
                        )
                    }
                }
            }
            
            if !UIDevice.IsSimulator {
                Section {
                    SLink(
                        "COVERAGE".localized(path: path, table: table),
                        icon: "com.apple.graphic-icon.applecare",
                        destination: AppleCareWarrantyView()
                    )
                }
            }
            
            if !UIDevice.IsSimulator {
                Section {
                    SLink(
                        "AIRDROP".localized(path: path, table: table),
                        icon: "com.apple.graphic-icon.airdrop",
                        destination: AirDropView()
                    )
                    SLink(
                        "CONTINUITY".localized(path: path, table: table),
                        icon: "com.apple.graphic-icon.airplay-video"
                    ) {
                        BundleControllerView(
                            "AirPlayAndHandoffSettings",
                            controller: "AirPlayAndHandoffSettings.AirPlayAndHandoffSettingsRoot",
                            title: "CONTINUITY".localized(path: path, table: table)
                        )
                    }
                    if UIDevice.iPhone {
                        SLink(
                            "PiP".localized(path: path, table: table),
                            icon: "com.apple.graphic-icon.picture-in-picture"
                        ) {
                            BundleControllerView(
                                "PictureInPictureSettings",
                                controller: "PictureInPictureSettings",
                                title: "PiP".localized(path: path, table: table)
                            )
                        }
                    }
                    SLink(
                        "SCREENSHOT_SERVICES_SETTINGS_TITLE".localized(path: "/System/Library/PreferenceBundles/ScreenshotServicesSettings.bundle"),
                        icon: "com.apple.graphic-icon.screenshots",
                        destination: ScreenCaptureView()
                    )
                    SLink(
                        "HQLR_STATUSBAR_TAPPED_ALERT_TITLE".localized(path: "/System/Library/PreferenceBundles/ReplayKitLocalCaptureSettings.bundle"),
                        icon: "com.apple.graphic-icon.localcapture"
                    ) {
                        BundleControllerView(
                            "ReplayKitLocalCaptureSettings",
                            controller: "LocalCaptureSettingsController",
                            title: "HQLR_STATUSBAR_TAPPED_ALERT_TITLE".localized(path: "/System/Library/PreferenceBundles/ReplayKitLocalCaptureSettings.bundle")
                        )
                    }
                    if UIDevice.iPhone {
                        SLink(
                            "CARPLAY".localized(path: path, table: table),
                            icon: "com.apple.graphic-icon.carplay"
                        ) {
                            BundleControllerView(
                                "CarKitSettings",
                                controller: "CRSettingsController",
                                title: "CARPLAY".localized(path: path, table: table)
                            )
                        }
                    }
                }
            }
            
            if !UIDevice.IsSimulator && UIDevice.HomeButtonCapability && UIDevice.iPhone {
                Button {
                    showingHomeButtonSheet = true
                } label: {
                    SLink(
                        "HOME_BUTTON".localized(path: path, table: table),
                        icon: "com.apple.graphic-icon.iphone-home-button"
                    ) {}
                }
                .foregroundStyle(.primary)
            }
            
            Section {
                SLink(
                    "AUTOFILL".localized(path: path, table: table),
                    icon: "com.apple.graphic-icon.autofill",
                    destination: AutoFillPasswordsView()
                )
                if !UIDevice.IsSimulator {
                    SLink(
                        "AUTO_CONTENT_DOWNLOAD".localized(path: path, table: table),
                        icon: "com.apple.graphic-icon.background-app-refresh",
                        destination: BackgroundAppRefreshView()
                    )
                    SLink(
                        "DATE_AND_TIME".localized(path: path, table: table),
                        icon: "com.apple.graphic-icon.date-and-time",
                        destination: DateTimeView()
                    )
                }
                SLink(
                    "DICTIONARY".localized(path: path, table: table),
                    icon: "com.apple.graphic-icon.dictionary",
                    destination: DictionaryView()
                )
                SLink(
                    "FONT_SETTING".localized(path: path, table: table),
                    icon: "com.apple.graphic-icon.fonts",
                    destination: FontsView()
                )
                SLink(
                    "Keyboard".localized(path: path, table: table),
                    icon: "com.apple.graphic-icon.keyboard",
                    destination: KeyboardView()
                )
                SLink(
                    "INTERNATIONAL".localized(path: path, table: table),
                    icon: "com.apple.graphic-icon.language"
                ) {
                    BundleControllerView(
                        "InternationalSettings",
                        controller: "InternationalSettingsController",
                        title: "INTERNATIONAL".localized(path: path, table: table)
                    )
                }
            }
            
            if !UIDevice.IsSimulator {
                Section {
                    SLink(
                        "TV_PROVIDER_LABEL".localized(path: path, table: table),
                        icon: "com.apple.graphic-icon.tv-provider",
                        destination: TVProviderView()
                    )
                }
            }
            
            Section {
                SLink(
                    "VPN_DEVICE_MANAGEMENT".localized(path: path, table: table),
                    icon: "com.apple.graphic-icon.device-management",
                    destination: VPNDeviceManagementView()
                )
            }
            
            if !UIDevice.IsSimulator {
                Section {
                    SLink(
                        "LEGAL_AND_REGULATORY_TITLE".localized(path: path, table: table),
                        icon: "com.apple.graphic-icon.legal-and-regulatory"
                    ) {
                        BundleControllerView(
                            "LegalAndRegulatorySettings",
                            controller: "LegalAndRegulatorySettings.LegalAndRegulatorySettingsRoot",
                            title: "LEGAL_AND_REGULATORY_TITLE".localized(path: path, table: table)
                        )
                    }
                }
                
                Section {
                    SLink(
                        "TRANSFER_OR_RESET_TITLE".localized(path: path, table: table),
                        icon: UIDevice.iPhone ? "com.apple.graphic-icon.transfer-or-reset-iphone" : "com.apple.graphic-icon.transfer-or-reset-ipad") {
                        BundleControllerView(
                            "\(path)/GeneralSettingsUI",
                            controller: "PSGTransferOrResetController",
                            title: "TRANSFER_OR_RESET_TITLE".localized(path: path, table: table)
                        )
                    }
                }
                
                Section {
                    Button("SHUTDOWN_LABEL".localized(path: path, table: table)) {}
                }
            }
        }
        .fullScreenCover(isPresented: $showingHomeButtonSheet) {
            NavigationStack {
                CustomViewController(
                    "\(path)/GeneralSettingsUI",
                    controller: "PSGHomeButtonCustomizeController"
                )
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
