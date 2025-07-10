//
//  PrivacySecurityView.swift
//  Preferences
//
//  Settings > Privacy & Security
//

import SwiftUI

struct PrivacySecurityView: View {
    // Variables
    @Environment(\.colorScheme) private var colorScheme
    @State private var opacity: Double = 0
    @State private var frameY: Double = 0
    let communication = "/System/Library/PrivateFrameworks/CommunicationSafetySettingsUI.framework"
    let safety = "/System/Library/PreferenceBundles/DigitalSeparationSettings.bundle"
    let table = "Privacy"
    let psTable = "PrivacyAndSecuritySettings"
    
    var body: some View {
        CustomList(title: "back".localize(table: "AXUILocalizedStrings")) {
            // MARK: Placard
            Placard(title: "PRIVACY".localize(table: table), icon: "com.apple.graphic-icon.privacy", description: "Placard Subtitle".localize(table: psTable), frameY: $frameY, opacity: $opacity)
            
            // MARK: Location Services, Tracking Section
            Section {
                SLink("LOCATION_SERVICES".localize(table: table), icon: "com.apple.graphic-icon.location", subtitle: "CONTACTS_NO_ACCESS_AUTHORIZATION".localize(table: table)) {
                    LocationServicesView()
                }
                SLink("TRACKERS".localize(table: table), icon: "com.apple.graphic-icon.app-tracking-transparency", status: "0") {
                    TrackingView()
                }
            }
            
            // MARK: App Permissions
            Section {
                SLink("CALENDARS".localize(table: table), icon: "com.apple.mobilecal", subtitle: "CALENDARS_NO_ACCESS_AUTHORIZATION".localize(table: table)) {
                    BundleControllerView("/System/Library/PrivateFrameworks/Settings/PrivacySettingsUI.framework/PrivacySettingsUI", controller: "PUICalendarPrivacyController", title: "CALENDARS", table: table)
                }
                SLink("CONTACTS".localize(table: table), icon: "com.apple.MobileAddressBook", subtitle: "CONTACTS_NO_ACCESS_AUTHORIZATION".localize(table: table)) {
                    BundleControllerView("/System/Library/PrivateFrameworks/Settings/PrivacySettingsUI.framework/PrivacySettingsUI", controller: "PUIContactsPrivacyController", title: "CONTACTS", table: table)
                }
                SLink("FILEACCESS".localize(table: table), icon: "com.apple.DocumentsApp", subtitle: "None".localize(table: psTable)) {
                    BundleControllerView("/System/Library/PrivateFrameworks/Settings/PrivacySettingsUI.framework/PrivacySettingsUI", controller: "PUIFileAccessController", title: "FILEACCESS", table: table)
                }
                SLink("FOCUS".localize(table: table), icon: "com.apple.graphic-icon.focus", subtitle: "None".localize(table: psTable)) {
                    AppPermissionsView(permission: "FOCUS")
                }
                SLink("HEALTH".localize(table: table), icon: "com.apple.Health", subtitle: "None".localize(table: psTable)) {
                    AppPermissionsView(permission: "HEALTH", bundle: "healthapp")
                }
                SLink("WILLOW".localize(table: table), icon: "com.apple.Home.HomeControlService", subtitle: "None".localize(table: psTable)) {
                    AppPermissionsView(permission: "WILLOW")
                }
                SLink("MEDIALIBRARY".localize(table: table), icon: "com.apple.Music", subtitle: "None".localize(table: psTable)) {
                    AppPermissionsView(permission: "MEDIALIBRARY")
                }
                SLink("PASSKEYS".localize(table: table), icon: "com.apple.graphic-icon.person-passkey", subtitle: "None".localize(table: psTable)) {
                    AppPermissionsView(permission: "PASSKEYS")
                }
                SLink("PHOTOS".localize(table: table), icon: "com.apple.mobileslideshow", subtitle: "PHOTOS_NO_ACCESS_AUTHORIZATION".localize(table: table)) {
                    BundleControllerView("/System/Library/PrivateFrameworks/Settings/PrivacySettingsUI.framework/PrivacySettingsUI", controller: "PUIPhotosPrivacyController", title: "PHOTOS", table: table)
                }
                SLink("REMINDERS".localize(table: table), icon: "com.apple.reminders", subtitle: "CONTACTS_NO_ACCESS_AUTHORIZATION".localize(table: table)) {
                    AppPermissionsView(permission: "REMINDERS")
                }
                if UIDevice.iPhone {
                    SLink("WALLET".localize(table: table), icon: "com.apple.Passbook", subtitle: "CONTACTS_NO_ACCESS_AUTHORIZATION".localize(table: table)) {
                        BundleControllerView("/System/Library/PreferenceBundles/Privacy/WalletPrivacySettings.bundle/WalletPrivacySettings", controller: "WalletPrivacySettings.WalletPrivacySettingsController", title: "WALLET", table: table)
                    }
                }
            }
            
            // MARK: Sensor Permissions
            Section {
                if !UIDevice.IsSimulator {
                    SLink("ACCESSORY_SETUP".localize(table: table), icon: "com.apple.graphic-icon.accessories", status: "0") {
                        BundleControllerView("/System/Library/PrivateFrameworks/Settings/PrivacySettingsUI.framework/PrivacySettingsUI", controller: "PUIAccessoriesController", title: "ACCESSORY_SETUP", table: table)
                    }
                }
                SLink("BT_PERIPHERAL".localize(table: table), icon: "com.apple.graphic-icon.bluetooth", status: "0") {
                    AppPermissionsView(permission: "BT_PERIPHERAL")
                }
                SLink("CAMERA".localize(table: table), icon: "com.apple.graphic-icon.camera", status: "0") {
                    AppPermissionsView(permission: "CAMERA")
                }
                SLink("Critical Messages".localize(table: psTable), icon: "com.apple.graphic-icon.critical-messages", status: "0") {
                    BundleControllerView("/System/Library/PrivateFrameworks/MessagesSettingsUI.framework/MessagesSettingsUI", controller: "CKSettingsCriticalMessagesViewController", title: "Critical Messages", table: psTable)
                }
                SLink("LOCAL_NETWORK".localize(table: table), icon: "com.apple.graphic-icon.local-network", status: "0") {
                    BundleControllerView("/System/Library/PrivateFrameworks/Settings/PrivacySettingsUI.framework/PrivacySettingsUI", controller: "PUINetworkController", title: "LOCAL_NETWORK", table: table)
                }
                SLink("MICROPHONE".localize(table: table), icon: "com.apple.graphic-icon.microphone-access", status: "0") {
                    AppPermissionsView(permission: "MICROPHONE")
                }
                SLink("MOTION".localize(table: table), icon: "com.apple.graphic-icon.motion-and-fitness", status: "0") {
                    AppPermissionsView(permission: "MOTION")
                }
                SLink("NEARBY_INTERACTIONS".localize(table: table), icon: "com.apple.graphic-icon.nearby-interactions", status: "0") {
                    AppPermissionsView(permission: "NEARBY_INTERACTIONS")
                }
                if UIDevice.iPhone {
                    SLink("Research Sensor & Usage Data".localize(table: psTable), icon: "com.apple.graphic-icon.research-sensor-and-usage-data", status: "0") {
                        AppPermissionsView(permission: "Research Sensor & Usage Data", bundle: "sensorusage")
                    }
                    SLink("SPEECH_RECOGNITION".localize(table: table), icon: "com.apple.graphic-icon.waveform", status: "0") {
                        AppPermissionsView(permission: "SPEECH_RECOGNITION")
                    }
                }
            }
            
            // MARK: Journaling Suggestions
            if UIDevice.iPhone && !UIDevice.IsSimulator {
                Section {
                    SLink("JOURNALING_SUGGESTIONS".localize(table: table), icon: "com.apple.graphic-icon.journaling-suggestions") {
                        JournalingSuggestionsView()
                    }
                }
            }
            
            // MARK: Safety Check
            if UIDevice.iPhone {
                Section {
                    SLink("SAFETY_CHECK".localized(path: safety), icon: "com.apple.graphic-icon.safety-check") {
                        SafetyCheckView()
                    }
                } footer: {
                    Text("Protect your personal safety by staying aware of which people, apps, and devices have access to your information.", tableName: psTable)
                }
            }
            
            // MARK: Sensitive Content Warning
            Section {
                SLink("Sensitive Content Warning".localize(table: "PrivacyAndSecuritySettings"), icon: "com.apple.graphic-icon.sensitive-media-check", status: "Off".localize(table: table)) {
                    BundleControllerView("CommunicationSafetySettings", controller: "CommunicationSafetySettings", title: "Sensitive Content Warning", table: "PrivacyAndSecuritySettings")
                }
            } footer: {
                Text(.init("Detect nude photos and videos before they are viewed on your Device, and receive guidance to help make a safe choice. Apple does not have access to the photos or videos. [Learn more…](%@)".localized(path: communication, "https://support.apple.com/en-us/105071")))
            }
            
            // MARK: Analytics & Improvements, Advertising
            Section {
                SLink("PROBLEM_REPORTING".localize(table: table), icon: "com.apple.graphic-icon.analytics-and-improvements") {
                    CustomViewController("/System/Library/PrivateFrameworks/Settings/PrivacySettingsUI.framework/PrivacySettingsUI", controller: "PUIProblemReportingController")
                        .ignoresSafeArea()
                        .navigationTitle("PROBLEM_REPORTING".localize(table: table))
                }
                SLink("ADVERTISING".localize(table: table), icon: "com.apple.graphic-icon.apple-advertising") {
                    AppleAdvertisingView()
                }
            }
            
            if !UIDevice.IsSimulator {
                // MARK: Transparency Logs
                Section {
                    SLink("APP_PRIVACY_REPORT".localize(table: table), icon: "com.apple.graphic-icon.app-privacy-report", status: "Off".localize(table: table)) {}
                    if UIDevice.IntelligenceCapability {
                        SLink("Apple Intelligence Report".localize(table: psTable), icon: "com.apple.application-icon.apple-intelligence", status: "Off".localize(table: psTable).localize(table: psTable)) {}
                    }
                } header: {
                    Text("Transparency Logs", tableName: psTable)
                }
                
                // MARK: Security
                Section {
                    if configuration.developerMode {
                        SLink("DEVELOPER_MODE".localize(table: table), icon: "com.apple.graphic-icon.developer-tools", status: "Off".localize(table: table)) {
                            EmptyView()
                        }
                    }
                    if UIDevice.iPhone {
                        SLink("Stolen Device Protection".localize(table: psTable), icon: "com.apple.graphic-icon.stolen-device-protection", status: "Off".localize(table: table)) {
                            EmptyView()
                        }
                    }
                    SLink("Lockdown Mode".localize(table: psTable), icon: "com.apple.graphic-icon.privacy", status: "Off".localize(table: table)) {
                        EmptyView()
                    }
                } header: {
                    Text("Security", tableName: psTable)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Privacy & Security")
                    .fontWeight(.semibold)
                    .font(.subheadline)
                    .opacity(frameY < 50.0 ? opacity : 0) // Only fade when passing the help section title at the top
            }
        }
    }
}

struct PrivacySecurityRoute: Routable {
    func destination() -> AnyView {
        AnyView(PrivacySecurityView())
    }
}

#Preview {
    NavigationStack {
        PrivacySecurityView()
    }
}
