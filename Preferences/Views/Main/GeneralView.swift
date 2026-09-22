//
//  GeneralView.swift
//  Preferences
//

import SwiftUI

/// Settings > General
struct GeneralView: View {
    @State private var titleVisible = false
    @State private var showingHomeButtonSheet = false
    private let path = "/System/Library/PrivateFrameworks/Settings/GeneralSettingsUI.framework"
    private let table = "General"
    
    var body: some View {
        CustomList(title: titleVisible ? "General".localized(path: path) : "") {
            Section {
                Placard(
                    title: "General".localized(path: path),
                    icon: "com.apple.graphic-icon.gear",
                    description: "Manage your overall setup and preferences for Device, such as software updates, device language, CarPlay, AirDrop, and more.".localized(path: path),
                    isVisible: $titleVisible
                )
            }
            
            Section {
                SLink(
                    "About".localized(path: path),
                    icon: "com.apple.graphic-icon.about-current-device",
                    destination: AboutView()
                )
                if !UIDevice.IsSimulator {
                    SLink(
                        "Software Update".localized(path: path),
                        icon: "com.apple.graphic-icon.software-update",
                        destination: SoftwareUpdateView()
                    )
                    SLink(
                        "Device Storage".localized(path: path),
                        icon: "com.apple.graphic-icon.external-drive"
                    ) {
                        ControllerBridgeView(
                            "StorageSettingsUI",
                            controller: "StorageSettingsUIWrapper",
                            title: "Device Storage".localized(path: path)
                        )
                    }
                }
            }
            
            if !UIDevice.IsSimulator {
                Section {
                    SLink(
                        "AppleCare & Warranty".localized(path: path),
                        icon: "com.apple.graphic-icon.applecare",
                        destination: AppleCareWarrantyView()
                    )
                }
            }
            
            if !UIDevice.IsSimulator {
                Section {
                    SLink(
                        "AirDrop".localized(path: path),
                        icon: "com.apple.graphic-icon.airdrop",
                        destination: AirDropView()
                    )
                    SLink(
                        "AirPlay & Continuity".localized(path: path),
                        icon: "com.apple.graphic-icon.airplay-video"
                    ) {
                        ControllerBridgeView(
                            "AirPlayAndHandoffSettings",
                            controller: "AirPlayAndHandoffSettings.AirPlayAndHandoffSettingsRoot",
                            title: "CONTINUITY".localized(path: path, table: table)
                        )
                    }
                    if UIDevice.iPhone {
                        SLink(
                            "Picture in Picture".localized(path: path),
                            icon: "com.apple.graphic-icon.picture-in-picture"
                        ) {
                            ControllerBridgeView(
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
                        ControllerBridgeView(
                            "ReplayKitLocalCaptureSettings",
                            controller: "LocalCaptureSettingsController",
                            title: "HQLR_STATUSBAR_TAPPED_ALERT_TITLE".localized(path: "/System/Library/PreferenceBundles/ReplayKitLocalCaptureSettings.bundle")
                        )
                    }
                    if UIDevice.iPhone {
                        SLink(
                            "CarPlay".localized(path: path),
                            icon: "com.apple.graphic-icon.carplay"
                        ) {
                            ControllerBridgeView(
                                "CarKitSettings",
                                controller: "CRSettingsController",
                                title: "CarPlay".localized(path: path)
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
                        "Home Button".localized(path: path),
                        icon: "com.apple.graphic-icon.iphone-home-button"
                    ) {}
                }
                .foregroundStyle(.primary)
            }
            
            Section {
                SLink(
                    "AutoFill & Passwords".localized(path: path),
                    icon: "com.apple.graphic-icon.autofill",
                    destination: AutoFillPasswordsView()
                )
                if !UIDevice.IsSimulator {
                    SLink(
                        "Background App Refresh".localized(path: path),
                        icon: "com.apple.graphic-icon.background-app-refresh",
                        destination: BackgroundAppRefreshView()
                    )
                    SLink(
                        "Date & Time".localized(path: path),
                        icon: "com.apple.graphic-icon.date-and-time",
                        destination: DateTimeView()
                    )
                }
                SLink(
                    "Dictionary".localized(path: path),
                    icon: "com.apple.graphic-icon.dictionary",
                    destination: DictionaryView()
                )
                SLink(
                    "Fonts".localized(path: path),
                    icon: "com.apple.graphic-icon.fonts",
                    destination: FontsView()
                )
                SLink(
                    "Keyboard".localized(path: path),
                    icon: "com.apple.graphic-icon.keyboard",
                    destination: KeyboardView()
                )
                SLink(
                    "Language & Region".localized(path: path),
                    icon: "com.apple.graphic-icon.language"
                ) {
                    ControllerBridgeView(
                        "InternationalSettings",
                        controller: "InternationalSettingsController",
                        title: "Language & Region".localized(path: path)
                    )
                }
            }
            
            if !UIDevice.IsSimulator {
                Section {
                    SLink(
                        "TV Provider".localized(path: path),
                        icon: "com.apple.graphic-icon.tv-provider",
                        destination: TVProviderView()
                    )
                }
            }
            
            Section {
                SLink(
                    "VPN & Device Management".localized(path: path),
                    icon: "com.apple.graphic-icon.device-management",
                    destination: VPNDeviceManagementView()
                )
            }
            
            if !UIDevice.IsSimulator {
                Section {
                    SLink(
                        "Legal & Regulatory".localized(path: path),
                        icon: "com.apple.graphic-icon.legal-and-regulatory"
                    ) {
                        ControllerBridgeView(
                            "LegalAndRegulatorySettings",
                            controller: "LegalAndRegulatorySettings.LegalAndRegulatorySettingsRoot",
                            title: "LEGAL_AND_REGULATORY_TITLE".localized(path: path, table: table)
                        )
                    }
                }
                
                Section {
                    SLink(
                        "Transfer or Reset Device".localized(path: path),
                        icon: UIDevice.iPhone ? "com.apple.graphic-icon.transfer-or-reset-iphone" : "com.apple.graphic-icon.transfer-or-reset-ipad") {
                        ControllerBridgeView(
                            "\(path)/GeneralSettingsUI",
                            controller: "PSGTransferOrResetController",
                            title: "Transfer or Reset Device".localized(path: path)
                        )
                    }
                }
                
                Section {
                    Button("Shut Down".localized(path: path)) {}
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
    }
}

#Preview {
    NavigationStack {
        GeneralView()
    }
}
