//
//  PrivacySecurityView.swift
//  Preferences
//
//  Settings > Privacy & Security
//

import SwiftUI

struct PrivacySecurityView: View {
    @Environment(\.colorScheme) private var colorScheme
    @State private var opacity: Double = 0
    @State private var frameY: Double = 0
    let communication = "/System/Library/PrivateFrameworks/CommunicationSafetySettingsUI.framework"
    let safety = "/System/Library/PreferenceBundles/DigitalSeparationSettings.bundle"
    let privacy = "/System/Library/PreferenceBundles/PrivacyAndSecuritySettings.bundle"
    
    var body: some View {
        CustomList(title: "Privacy & Security".localized(path: privacy)) {
            // MARK: Placard
            Placard(
                title: "Privacy & Security".localized(path: privacy),
                icon: "com.apple.graphic-icon.privacy",
                description: "Placard Subtitle".localized(path: privacy),
                frameY: $frameY,
                opacity: $opacity
            )
            
            // MARK: Location Services, Tracking Section
            Section {
                SLink(
                    "Location Services".localized(path: privacy),
                    icon: "com.apple.graphic-icon.location",
                    subtitle: "None".localized(path: privacy),
                    destination: LocationServicesView()
                )
                SLink(
                    "Tracking".localized(path: privacy),
                    icon: "com.apple.graphic-icon.app-tracking-transparency",
                    status: "0",
                    destination: TrackingView()
                )
            }
            
            // MARK: App Permissions
            Section {
                SLink(
                    "Calendars".localized(path: privacy),
                    icon: "com.apple.mobilecal",
                    subtitle: "None".localized(path: privacy),
                    destination: BundleControllerView(
                        "/System/Library/PrivateFrameworks/Settings/PrivacySettingsUI.framework/PrivacySettingsUI",
                        controller: "PUICalendarPrivacyController",
                        title: "Calendars".localized(path: privacy)
                    )
                )
                SLink(
                    "Contacts".localized(path: privacy),
                    icon: "com.apple.MobileAddressBook",
                    subtitle: "None".localized(path: privacy),
                    destination: BundleControllerView(
                        "/System/Library/PrivateFrameworks/Settings/PrivacySettingsUI.framework/PrivacySettingsUI",
                        controller: "PUIContactsPrivacyController",
                        title: "Contacts".localized(path: privacy)
                    )
                )
                SLink(
                    "Files & Folders".localized(path: privacy),
                    icon: "com.apple.DocumentsApp",
                    subtitle: "None".localized(path: privacy),
                    destination: BundleControllerView(
                        "/System/Library/PrivateFrameworks/Settings/PrivacySettingsUI.framework/PrivacySettingsUI",
                        controller: "PUIFileAccessController",
                        title: "Files & Folders".localized(path: privacy)
                    )
                )
                SLink(
                    "Focus".localized(path: privacy),
                    icon: "com.apple.graphic-icon.focus",
                    subtitle: "None".localized(path: privacy),
                    destination: AppPermissionsView(permission: "FOCUS")
                )
                SLink(
                    "Health".localized(path: privacy),
                    icon: "com.apple.Health",
                    subtitle: "None".localized(path: privacy),
                    destination: AppPermissionsView(permission: "HEALTH", bundle: "healthapp")
                )
                SLink(
                    "Home Accessories".localized(path: privacy),
                    icon: "com.apple.Home.HomeControlService",
                    subtitle: "None".localized(path: privacy),
                    destination: AppPermissionsView(permission: "WILLOW")
                )
                SLink(
                    "Media & Apple Music".localized(path: privacy),
                    icon: "com.apple.Music",
                    subtitle: "None".localized(path: privacy),
                    destination: AppPermissionsView(permission: "MEDIALIBRARY")
                )
                SLink(
                    "Passkeys Access for Web Browsers".localized(path: privacy),
                    icon: "com.apple.graphic-icon.person-passkey",
                    subtitle: "None".localized(path: privacy),
                    destination: AppPermissionsView(permission: "PASSKEYS")
                )
                SLink(
                    "Photos".localized(path: privacy),
                    icon: "com.apple.mobileslideshow",
                    subtitle: "None".localized(path: privacy),
                    destination: BundleControllerView(
                        "/System/Library/PrivateFrameworks/Settings/PrivacySettingsUI.framework/PrivacySettingsUI",
                        controller: "PUIPhotosPrivacyController",
                        title: "Photos".localized(path: privacy)
                    )
                )
                SLink(
                    "Reminders".localized(path: privacy),
                    icon: "com.apple.reminders",
                    subtitle: "None".localized(path: privacy),
                    destination: AppPermissionsView(permission: "REMINDERS")
                )
                if UIDevice.iPhone {
                    SLink(
                        "Wallet".localized(path: privacy),
                        icon: "com.apple.Passbook",
                        subtitle: "None".localized(path: privacy),
                        destination: BundleControllerView(
                            "/System/Library/PreferenceBundles/Privacy/WalletPrivacySettings.bundle/WalletPrivacySettings",
                            controller: "WalletPrivacySettings.WalletPrivacySettingsController",
                            title: "Wallet".localized(path: privacy)
                        )
                    )
                }
            }
            
            // MARK: Sensor Permissions
            Section {
                if !UIDevice.IsSimulator {
                    SLink(
                        "Accessories".localized(path: privacy),
                        icon: "com.apple.graphic-icon.accessories",
                        status: "0",
                        destination: BundleControllerView(
                            "/System/Library/PrivateFrameworks/Settings/PrivacySettingsUI.framework/PrivacySettingsUI",
                            controller: "PUIAccessoriesController",
                            title: "Accessories".localized(path: privacy)
                        )
                    )
                }
                SLink(
                    "Bluetooth".localized(path: privacy),
                    icon: "com.apple.graphic-icon.bluetooth",
                    status: "0",
                    destination: AppPermissionsView(permission: "BT_PERIPHERAL")
                )
                SLink(
                    "Camera".localized(path: privacy),
                    icon: "com.apple.graphic-icon.camera",
                    status: "0",
                    destination: AppPermissionsView(permission: "CAMERA")
                )
                SLink(
                    "Critical Messages".localized(path: privacy),
                    icon: "com.apple.graphic-icon.critical-messages",
                    status: "0",
                    destination: BundleControllerView(
                        "/System/Library/PrivateFrameworks/MessagesSettingsUI.framework/MessagesSettingsUI",
                        controller: "CKSettingsCriticalMessagesViewController",
                        title: "Critical Messages".localized(path: privacy)
                    )
                )
                SLink(
                    "Local Network".localized(path: privacy),
                    icon: "com.apple.graphic-icon.local-network",
                    status: "0",
                    destination: BundleControllerView(
                        "/System/Library/PrivateFrameworks/Settings/PrivacySettingsUI.framework/PrivacySettingsUI",
                        controller: "PUINetworkController",
                        title: "LOCAL_NETWORK"
                    )
                )
                SLink(
                    "Microphone".localized(path: privacy),
                    icon: "com.apple.graphic-icon.microphone-access",
                    status: "0",
                    destination: AppPermissionsView(permission: "MICROPHONE")
                )
                SLink(
                    "Motion".localized(path: privacy),
                    icon: "com.apple.graphic-icon.motion-and-fitness",
                    status: "0",
                    destination: AppPermissionsView(permission: "MOTION")
                )
                SLink(
                    "Nearby Interactions".localized(path: privacy),
                    icon: "com.apple.graphic-icon.nearby-interactions",
                    status: "0",
                    destination: AppPermissionsView(permission: "NEARBY_INTERACTIONS")
                )
                if UIDevice.iPhone {
                    SLink(
                        "Research Sensor & Usage Data".localized(path: privacy),
                        icon: "com.apple.graphic-icon.research-sensor-and-usage-data",
                        status: "0",
                        destination: AppPermissionsView(permission: "Research Sensor & Usage Data", bundle: "sensorusage")
                    )
                    SLink(
                        "Speech Recognition".localized(path: privacy),
                        icon: "com.apple.graphic-icon.waveform",
                        status: "0",
                        destination: AppPermissionsView(permission: "SPEECH_RECOGNITION")
                    )
                }
            }
            
            // MARK: Journaling Suggestions
            if UIDevice.iPhone && !UIDevice.IsSimulator {
                Section {
                    SLink(
                        "Journaling Suggestions".localized(path: privacy),
                        icon: "com.apple.graphic-icon.journaling-suggestions",
                        destination: JournalingSuggestionsView()
                    )
                }
            }
            
            // MARK: Safety Check
            
            Section {
                SLink(
                    "Blocked contacts".localized(path: privacy),
                    icon: "com.apple.graphic-icon.content-and-privacy-restrictions",
                    destination: EmptyView()
                )
                if UIDevice.iPhone {
                    SLink(
                        "SAFETY_CHECK".localized(path: safety),
                        icon: "com.apple.graphic-icon.safety-check",
                        destination: SafetyCheckView()
                    )
                }
            } footer: {
                if UIDevice.iPhone {
                    Text("Protect your personal safety by staying aware of which people, apps, and devices have access to your information.".localized(path: privacy))
                }
            }
            
            // MARK: Sensitive Content Warning
            Section {
                SLink(
                    "Sensitive Content Warning".localized(path: privacy),
                    icon: "com.apple.graphic-icon.sensitive-media-check",
                    status: "Off".localized(path: privacy),
                    destination: BundleControllerView(
                        "CommunicationSafetySettings",
                        controller: "CommunicationSafetySettings",
                        title: "Sensitive Content Warning".localized(path: privacy)
                    )
                )
            } footer: {
                Text(.init("Detect nude photos and videos before they are viewed on your Device, and receive guidance to help make a safe choice. Apple does not have access to the photos or videos. [Learn more…](%@)".localized(path: communication, "https://support.apple.com/105071")))
            }
            
            // MARK: Analytics & Improvements, Advertising
            Section {
                SLink(
                    "Analytics & Improvements".localized(path: privacy),
                    icon: "com.apple.graphic-icon.analytics-and-improvements") {
                    CustomViewController(
                        "/System/Library/PrivateFrameworks/Settings/PrivacySettingsUI.framework/PrivacySettingsUI",
                        controller: "PUIProblemReportingController")
                        .ignoresSafeArea()
                        .navigationTitle("PROBLEM_REPORTING".localized(path: privacy))
                }
                SLink(
                    "Apple Advertising".localized(path: privacy),
                    icon: "com.apple.graphic-icon.apple-advertising",
                    destination: AppleAdvertisingView()
                )
            }
            
            if !UIDevice.IsSimulator {
                // MARK: Transparency Logs
                Section {
                    SLink(
                        "App Privacy Report".localized(path: privacy),
                        icon: "com.apple.graphic-icon.app-privacy-report",
                        status: "Off".localized(path: privacy)
                    ) {}
                    if UIDevice.IntelligenceCapability {
                        SLink(
                            "Apple Intelligence Report".localized(path: privacy),
                            icon: "com.apple.application-icon.apple-intelligence",
                            status: "Off".localized(path: privacy)
                        ) {}
                    }
                } header: {
                    Text("Transparency Logs".localized(path: privacy))
                }
                
                // MARK: Security
                Section {
                    if configuration.developerMode {
                        SLink(
                            "Developer Mode".localized(path: privacy),
                            icon: "com.apple.graphic-icon.developer-tools",
                            status: "Off".localized(path: privacy)
                        ) {}
                    }
                    SLink(
                        "Wired Accessories".localized(path: privacy),
                        icon: "com.apple.graphic-icon.usb-c-port",
                        status: "Automatically Allow When Unlocked"
                    ) {}
                    SLink(
                        "Background Security Improvements".localized(path: privacy),
                        icon: "com.apple.graphic-icon.background-security-improvements"
                    ) {}
                    if UIDevice.iPhone {
                        SLink(
                            "Stolen Device Protection".localized(path: privacy),
                            icon: "com.apple.graphic-icon.stolen-device-protection",
                            status: "Off".localized(path: privacy)
                        ) {}
                    }
                    SLink(
                        "Lockdown Mode".localized(path: privacy),
                        icon: "com.apple.graphic-icon.privacy",
                        status: "Off".localized(path: privacy)
                    ) {}
                } header: {
                    Text("Security".localized(path: privacy))
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Privacy & Security".localized(path: privacy))
                    .fontWeight(.semibold)
                    .font(.subheadline)
                    .opacity(frameY < 50.0 ? opacity : 0)
            }
        }
    }
}

#Preview {
    NavigationStack {
        PrivacySecurityView()
    }
}
