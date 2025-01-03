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
                SettingsLink(color: .blue, icon: "location.fill", id: "LOCATION_SERVICES".localize(table: table), subtitle: "CONTACTS_NO_ACCESS_AUTHORIZATION".localize(table: table)) {
                    LocationServicesView()
                }
                SettingsLink(color: .orange, icon: "app.connected.to.app.below.fill", id: "TRACKERS".localize(table: table), status: "0") {
                    TrackingView()
                }
            }
            
            // MARK: App Permissions
            Section {
                SettingsLink(icon: "appleCalendar", id: "CALENDARS".localize(table: table), subtitle: "CALENDARS_NO_ACCESS_AUTHORIZATION".localize(table: table)) {
                    AppPermissionsView(permissionName: "CALENDARS")
                }
                SettingsLink(icon: "appleContacts", id: "CONTACTS".localize(table: table), subtitle: "CONTACTS_NO_ACCESS_AUTHORIZATION".localize(table: table)) {
                    AppPermissionsView(permissionName: "CONTACTS")
                }
                SettingsLink(icon: "appleFiles", id: "FILEACCESS".localize(table: table), subtitle: "None".localize(table: psTable)) {
                    AppPermissionsView(permissionName: "FILEACCESS")
                }
                SettingsLink(color: .indigo, icon: "moon.fill", id: "FOCUS".localize(table: table), subtitle: "None".localize(table: psTable)) {
                    AppPermissionsView(permissionName: "FOCUS")
                }
                SettingsLink(icon: "appleHealth", id: "HEALTH".localize(table: table), subtitle: "None".localize(table: psTable)) {
                    AppPermissionsView(permissionName: "HEALTH")
                }
                SettingsLink(icon: "appleHome", id: "WILLOW".localize(table: table), subtitle: "None".localize(table: psTable)) {
                    AppPermissionsView(permissionName: "WILLOW")
                }
                SettingsLink(icon: "appleMusic", id: "MEDIALIBRARY".localize(table: table), subtitle: "None".localize(table: psTable)) {
                    AppPermissionsView(permissionName: "MEDIALIBRARY")
                }
                SettingsLink(color: .gray, icon: "person.badge.key.fill", id: "PASSKEYS".localize(table: table), subtitle: "None".localize(table: psTable)) {
                    AppPermissionsView(permissionName: "PASSKEYS")
                }
                SettingsLink(icon: "applePhotos", id: "PHOTOS".localize(table: table), subtitle: "PHOTOS_NO_ACCESS_AUTHORIZATION".localize(table: table)) {
                    AppPermissionsView(permissionName: "PHOTOS")
                }
                SettingsLink(icon: "appleReminders", id: "REMINDERS".localize(table: table), subtitle: "CONTACTS_NO_ACCESS_AUTHORIZATION".localize(table: table)) {
                    AppPermissionsView(permissionName: "REMINDERS")
                }
                if UIDevice.iPhone {
                    SettingsLink(icon: "appleWallet", id: "WALLET".localize(table: table), subtitle: "CONTACTS_NO_ACCESS_AUTHORIZATION".localize(table: table)) {
                        AppPermissionsView(permissionName: "WALLET")
                    }
                }
            }
            
            // MARK: Sensor Permissions
            Section {
                if !UIDevice.IsSimulator {
                    SettingsLink(color: .blue, icon: "ring.radiowaves.right", id: "ACCESSORY_SETUP".localize(table: table), status: "0") {
                        AppPermissionsView(permissionName: "ACCESSORY_SETUP")
                    }
                }
                SettingsLink(color: .blue, icon: "bluetooth", id: "BT_PERIPHERAL".localize(table: table), status: "0") {
                    AppPermissionsView(permissionName: "BT_PERIPHERAL")
                }
                SettingsLink(color: .gray, icon: "camera.fill", id: "CAMERA".localize(table: table), status: "0") {
                    AppPermissionsView(permissionName: "CAMERA")
                }
                SettingsLink(color: .green, icon: "exclamationmark.message.fill", id: "Critical Messages".localize(table: psTable), status: "0") {
                    AppPermissionsView(permissionName: "CAMERA")
                }
                SettingsLink(color: .blue, icon: "network", id: "LOCAL_NETWORK".localize(table: table), status: "0") {
                    AppPermissionsView(permissionName: "LOCAL_NETWORK")
                }
                SettingsLink(color: .orange, icon: "mic.fill", id: "MICROPHONE".localize(table: table), status: "0") {
                    AppPermissionsView(permissionName: "MICROPHONE")
                }
                SettingsLink(color: .green, icon: "figure.run.motion", id: "MOTION".localize(table: table), status: "0") {
                    AppPermissionsView(permissionName: "MOTION")
                }
                SettingsLink(color: .blue, icon: "nearby.interactions", id: "NEARBY_INTERACTIONS".localize(table: table), status: "0") {
                    AppPermissionsView(permissionName: "NEARBY_INTERACTIONS")
                }
                if UIDevice.iPhone {
                    SettingsLink(color: .blue, icon: "sensorkit", id: "Research Sensor & Usage Data".localize(table: psTable), status: "0") {
                        AppPermissionsView(permissionName: "Research Sensor & Usage Data")
                    }
                    SettingsLink(color: .gray, icon: "waveform", id: "SPEECH_RECOGNITION".localize(table: table), status: "0") {
                        AppPermissionsView(permissionName: "SPEECH_RECOGNITION")
                    }
                }
            }
            
            // MARK: Journaling Suggestions
            if UIDevice.iPhone && !UIDevice.IsSimulator {
                Section {
                    SettingsLink(color: .indigo, icon: "pencil.and.sparkles", id: "JOURNALING_SUGGESTIONS".localize(table: table)) {
                        JournalingSuggestionsView()
                    }
                }
            }
            
            // MARK: Safety Check
            if UIDevice.iPhone {
                Section {
                    SettingsLink(color: colorScheme == .dark ? .blue : .white, iconColor: .blue, icon: "person.badge.shield.checkmark.fill", id: "SAFETY_CHECK".localize(table: "DigitalSeparationUI")) {
                        SafetyCheckView()
                    }
                } footer: {
                    Text("Protect your personal safety by staying aware of which people, apps, and devices have access to your information.", tableName: psTable)
                }
            }
            
            // MARK: Sensitive Content Warning
            Section {
                SettingsLink(color: .blue, icon: "eye.trianglebadge.exclamationmark.fill", id: "Sensitive Content Warning", status: "Off".localize(table: table)) {
                    SensitiveContentWarningView()
                }
            } footer: {
                Text(.init("Detect nude photos and videos before they are viewed on your Device, and receive guidance to help make a safe choice. Apple does not have access to the photos or videos. [Learn more…](%@)".localize(table: "CommunicationSafetySettingsUI", "https://support.apple.com/en-us/105071")))
            }
            
            // MARK: Analytics & Improvements, Advertising
            Section {
                SettingsLink(color: .blue, icon: "chart.bar.xaxis", id: "PROBLEM_REPORTING".localize(table: table)) {
                    AnalyticsImprovementsView()
                }
                SettingsLink(color: .blue, icon: "megaphone.fill", id: "ADVERTISING".localize(table: table)) {
                    AppleAdvertisingView()
                }
            }
            
            if !UIDevice.IsSimulator {
                // MARK: Transparency Logs
                Section {
                    SettingsLink(color: .green, icon: "shield.lefthalf.filled", id: "APP_PRIVACY_REPORT".localize(table: table), status: "Off".localize(table: table)) {}
                    if UIDevice.IntelligenceCapability {
                        SettingsLink(icon: "siri", id: "Apple Intelligence Report".localize(table: psTable), status: "Off".localize(table: psTable).localize(table: psTable)) {}
                    }
                } header: {
                    Text("Transparency Logs", tableName: psTable)
                }
                
                // MARK: Security
                Section {
                    if configuration.developerMode {
                        SettingsLink(color: .gray, icon: "hammer.fill", id: "DEVELOPER_MODE".localize(table: table), status: "Off".localize(table: table)) {
                            EmptyView()
                        }
                    }
                    if UIDevice.iPhone {
                        SettingsLink(color: .blue, icon: "lock.and.ring.2", id: "Stolen Device Protection".localize(table: psTable), status: "Off".localize(table: table)) {
                            EmptyView()
                        }
                    }
                    SettingsLink(color: .blue, icon: "hand.raised.fill", id: "Lockdown Mode".localize(table: psTable), status: "Off".localize(table: table)) {
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

#Preview {
    NavigationStack {
        PrivacySecurityView()
    }
}
