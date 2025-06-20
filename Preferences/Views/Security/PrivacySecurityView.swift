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
    let table = "Privacy"
    let psTable = "PrivacyAndSecuritySettings"
    
    var body: some View {
        CustomList(title: "back".localize(table: "AXUILocalizedStrings")) {
            // MARK: Placard
            Placard(title: "PRIVACY".localize(table: table), color: .blue, icon: "hand.raised.fill", description: "Placard Subtitle".localize(table: psTable), frameY: $frameY, opacity: $opacity)
            
            // MARK: Location Services, Tracking Section
            Section {
                SLink("LOCATION_SERVICES".localize(table: table), color: .blue, icon: "location.fill", subtitle: "CONTACTS_NO_ACCESS_AUTHORIZATION".localize(table: table)) {
                    LocationServicesView()
                }
                SLink("TRACKERS".localize(table: table), color: .orange, icon: "app.connected.to.app.below.fill", status: "0") {
                    TrackingView()
                }
            }
            
            // MARK: App Permissions
            Section {
                SLink("CALENDARS".localize(table: table), icon: "appleCalendar", subtitle: "CALENDARS_NO_ACCESS_AUTHORIZATION".localize(table: table)) {
                    BundleControllerView("/System/Library/PrivateFrameworks/Settings/PrivacySettingsUI.framework/PrivacySettingsUI", controller: "PUICalendarPrivacyController", title: "CALENDARS", table: table)
                }
                SLink("CONTACTS".localize(table: table), icon: "appleContacts", subtitle: "CONTACTS_NO_ACCESS_AUTHORIZATION".localize(table: table)) {
                    BundleControllerView("/System/Library/PrivateFrameworks/Settings/PrivacySettingsUI.framework/PrivacySettingsUI", controller: "PUIContactsPrivacyController", title: "CONTACTS", table: table)
                }
                SLink("FILEACCESS".localize(table: table), icon: "appleFiles", subtitle: "None".localize(table: psTable)) {
                    BundleControllerView("/System/Library/PrivateFrameworks/Settings/PrivacySettingsUI.framework/PrivacySettingsUI", controller: "PUIFileAccessController", title: "FILEACCESS", table: table)
                }
                SLink("FOCUS".localize(table: table), color: .indigo, icon: "moon.fill", subtitle: "None".localize(table: psTable)) {
                    AppPermissionsView(permission: "FOCUS")
                }
                SLink("HEALTH".localize(table: table), icon: "appleHealth", subtitle: "None".localize(table: psTable)) {
                    AppPermissionsView(permission: "HEALTH", bundle: "healthapp")
                }
                SLink("WILLOW".localize(table: table), icon: "appleHome", subtitle: "None".localize(table: psTable)) {
                    AppPermissionsView(permission: "WILLOW")
                }
                SLink("MEDIALIBRARY".localize(table: table), icon: "appleMusic", subtitle: "None".localize(table: psTable)) {
                    AppPermissionsView(permission: "MEDIALIBRARY")
                }
                SLink("PASSKEYS".localize(table: table), color: .gray, icon: "person.badge.key.fill", subtitle: "None".localize(table: psTable)) {
                    AppPermissionsView(permission: "PASSKEYS")
                }
                SLink("PHOTOS".localize(table: table), icon: "applePhotos", subtitle: "PHOTOS_NO_ACCESS_AUTHORIZATION".localize(table: table)) {
                    BundleControllerView("/System/Library/PrivateFrameworks/Settings/PrivacySettingsUI.framework/PrivacySettingsUI", controller: "PUIPhotosPrivacyController", title: "PHOTOS", table: table)
                }
                SLink("REMINDERS".localize(table: table), icon: "appleReminders", subtitle: "CONTACTS_NO_ACCESS_AUTHORIZATION".localize(table: table)) {
                    AppPermissionsView(permission: "REMINDERS")
                }
                if UIDevice.iPhone {
                    SLink("WALLET".localize(table: table), icon: "appleWallet", subtitle: "CONTACTS_NO_ACCESS_AUTHORIZATION".localize(table: table)) {
                        BundleControllerView("/System/Library/PreferenceBundles/Privacy/WalletPrivacySettings.bundle/WalletPrivacySettings", controller: "WalletPrivacySettings.WalletPrivacySettingsController", title: "WALLET", table: table)
                    }
                }
            }
            
            // MARK: Sensor Permissions
            Section {
                if !UIDevice.IsSimulator {
                    SLink("ACCESSORY_SETUP".localize(table: table), color: .blue, icon: "ring.radiowaves.right", status: "0") {
                        BundleControllerView("/System/Library/PrivateFrameworks/Settings/PrivacySettingsUI.framework/PrivacySettingsUI", controller: "PUIAccessoriesController", title: "ACCESSORY_SETUP", table: table)
                    }
                }
                SLink("BT_PERIPHERAL".localize(table: table), color: .blue, icon: "bluetooth", status: "0") {
                    AppPermissionsView(permission: "BT_PERIPHERAL")
                }
                SLink("CAMERA".localize(table: table), color: .gray, icon: "camera.fill", status: "0") {
                    AppPermissionsView(permission: "CAMERA")
                }
                SLink("Critical Messages".localize(table: psTable), color: .green, icon: "exclamationmark.message.fill", status: "0") {
                    //AppPermissionsView(permission: "Critical Messages")
                    BundleControllerView("/System/Library/PrivateFrameworks/MessagesSettingsUI.framework/MessagesSettingsUI", controller: "CKSettingsCriticalMessagesViewController", title: "Critical Messages", table: psTable)
                }
                SLink("LOCAL_NETWORK".localize(table: table), color: .blue, icon: "network", status: "0") {
                    BundleControllerView("/System/Library/PrivateFrameworks/Settings/PrivacySettingsUI.framework/PrivacySettingsUI", controller: "PUINetworkController", title: "LOCAL_NETWORK", table: table)
                }
                SLink("MICROPHONE".localize(table: table), color: .orange, icon: "mic.fill", status: "0") {
                    AppPermissionsView(permission: "MICROPHONE")
                }
                SLink("MOTION".localize(table: table), color: .green, icon: "figure.run.motion", status: "0") {
                    AppPermissionsView(permission: "MOTION")
                }
                SLink("NEARBY_INTERACTIONS".localize(table: table), color: .blue, icon: "nearby.interactions", status: "0") {
                    AppPermissionsView(permission: "NEARBY_INTERACTIONS")
                }
                if UIDevice.iPhone {
                    SLink("Research Sensor & Usage Data".localize(table: psTable), color: .blue, icon: "sensorkit", status: "0") {
                        AppPermissionsView(permission: "Research Sensor & Usage Data", bundle: "sensorusage")
                    }
                    SLink("SPEECH_RECOGNITION".localize(table: table), color: .gray, icon: "waveform", status: "0") {
                        AppPermissionsView(permission: "SPEECH_RECOGNITION")
                    }
                }
            }
            
            // MARK: Journaling Suggestions
            if UIDevice.iPhone && !UIDevice.IsSimulator {
                Section {
                    SLink("JOURNALING_SUGGESTIONS".localize(table: table), color: .indigo, icon: "pencil.and.sparkles") {
                        JournalingSuggestionsView()
                    }
                }
            }
            
            // MARK: Safety Check
            if UIDevice.iPhone {
                Section {
                    SLink("SAFETY_CHECK".localize(table: "DigitalSeparationUI"), color: colorScheme == .dark ? .blue : .white, iconColor: .blue, icon: "person.badge.shield.checkmark.fill") {
                        SafetyCheckView()
                    }
                } footer: {
                    Text("Protect your personal safety by staying aware of which people, apps, and devices have access to your information.", tableName: psTable)
                }
            }
            
            // MARK: Sensitive Content Warning
            Section {
                SLink("Sensitive Content Warning".localize(table: "PrivacyAndSecuritySettings"), color: .blue, icon: "eye.trianglebadge.exclamationmark.fill", status: "Off".localize(table: table)) {
                    BundleControllerView("CommunicationSafetySettings", controller: "CommunicationSafetySettings", title: "Sensitive Content Warning", table: "PrivacyAndSecuritySettings")
                }
            } footer: {
                Text(.init("Detect nude photos and videos before they are viewed on your Device, and receive guidance to help make a safe choice. Apple does not have access to the photos or videos. [Learn more…](%@)".localize(table: "CommunicationSafetySettingsUI", "https://support.apple.com/en-us/105071")))
            }
            
            // MARK: Analytics & Improvements, Advertising
            Section {
                SLink("PROBLEM_REPORTING".localize(table: table), color: .blue, icon: "chart.bar.xaxis") {
                    AnalyticsImprovementsView()
                }
                SLink("ADVERTISING".localize(table: table), color: .blue, icon: "megaphone.fill") {
                    AppleAdvertisingView()
                }
            }
            
            if !UIDevice.IsSimulator {
                // MARK: Transparency Logs
                Section {
                    SLink("APP_PRIVACY_REPORT".localize(table: table), color: .green, icon: "shield.lefthalf.filled", status: "Off".localize(table: table)) {}
                    if UIDevice.IntelligenceCapability {
                        SLink("Apple Intelligence Report".localize(table: psTable), icon: "com.apple.application-icon.apple-intelligence", status: "Off".localize(table: psTable).localize(table: psTable)) {}
                    }
                } header: {
                    Text("Transparency Logs", tableName: psTable)
                }
                
                // MARK: Security
                Section {
                    if configuration.developerMode {
                        SLink("DEVELOPER_MODE".localize(table: table), color: .gray, icon: "hammer.fill", status: "Off".localize(table: table)) {
                            EmptyView()
                        }
                    }
                    if UIDevice.iPhone {
                        SLink("Stolen Device Protection".localize(table: psTable), color: .blue, icon: "lock.and.ring.2", status: "Off".localize(table: table)) {
                            EmptyView()
                        }
                    }
                    SLink("Lockdown Mode".localize(table: psTable), color: .blue, icon: "hand.raised.fill", status: "Off".localize(table: table)) {
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
