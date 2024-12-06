//
//  PrivacySecurityView.swift
//  Preferences
//
//  Settings > Privacy & Security
//

import SwiftUI

struct PrivacySecurityView: View {
    // Variables
    @State private var opacity: Double = 0
    @State private var frameY: Double = 0
    let table = "Privacy"
    
    var body: some View {
        CustomList(title: "Back") {
            Placard(title: "PRIVACY".localize(table: table), color: .blue, icon: "hand.raised.fill", description: "Control which apps can access your data, location, camera, and microphone, and manage safety protections. [Learn more...](https://support.apple.com/guide/iphone/use-built-in-privacy-and-security-protections-iph6e7d349d1/ios)", frameY: $frameY, opacity: $opacity)
            
            Section {
                SettingsLink(color: .blue, icon: "location.fill", id: "LOCATION_SERVICES".localize(table: table), subtitle: "None") {
                    LocationServicesView()
                }
                SettingsLink(color: .orange, icon: "app.connected.to.app.below.fill", id: "TRACKERS".localize(table: table), status: "0") {
                    TrackingView()
                }
            }
            
            Section {
                SettingsLink(icon: "appleCalendar", id: "CALENDARS".localize(table: table), subtitle: "CALENDARS_NO_ACCESS_AUTHORIZATION".localize(table: table)) {
                    AppPermissionsView(permissionName: "CALENDARS")
                }
                SettingsLink(icon: "appleContacts", id: "CONTACTS".localize(table: table), subtitle: "CONTACTS_NO_ACCESS_AUTHORIZATION".localize(table: table)) {
                    AppPermissionsView(permissionName: "CONTACTS")
                }
                SettingsLink(icon: "appleFiles", id: "FILEACCESS".localize(table: table), subtitle: "None") {
                    AppPermissionsView(permissionName: "FILEACCESS")
                }
                SettingsLink(color: .indigo, icon: "moon.fill", id: "FOCUS".localize(table: table), subtitle: "None") {
                    AppPermissionsView(permissionName: "FOCUS")
                }
                SettingsLink(icon: "appleHealth", id: "HEALTH".localize(table: table), subtitle: "None") {
                    AppPermissionsView(permissionName: "HEALTH")
                }
                SettingsLink(icon: "appleHome", id: "WILLOW".localize(table: table), subtitle: "None") {
                    AppPermissionsView(permissionName: "WILLOW")
                }
                SettingsLink(icon: "appleMusic", id: "MEDIALIBRARY".localize(table: table), subtitle: "None") {
                    AppPermissionsView(permissionName: "MEDIALIBRARY")
                }
                SettingsLink(color: .gray, icon: "person.badge.key.fill", id: "PASSKEYS".localize(table: table), subtitle: "None") {
                    AppPermissionsView(permissionName: "PASSKEYS")
                }
                SettingsLink(icon: "applePhotos", id: "PHOTOS".localize(table: table), subtitle: "PHOTOS_NO_ACCESS_AUTHORIZATION".localize(table: table)) {
                    AppPermissionsView(permissionName: "PHOTOS")
                }
                SettingsLink(icon: "appleReminders", id: "REMINDERS".localize(table: table), subtitle: "None") {
                    AppPermissionsView(permissionName: "REMINDERS")
                }
                if UIDevice.iPhone {
                    SettingsLink(icon: "appleWallet", id: "WALLET".localize(table: table), subtitle: "None") {
                        AppPermissionsView(permissionName: "WALLET")
                    }
                }
            }
            
            Section {
                if !UIDevice.IsSimulator {
                    SettingsLink(color: .blue, icon: "Accessory", id: "ACCESSORY_SETUP".localize(table: table), status: "0") {
                        AppPermissionsView(permissionName: "ACCESSORY_SETUP")
                    }
                }
                SettingsLink(color: .blue, icon: "bluetooth", id: "BT_PERIPHERAL".localize(table: table), status: "0") {
                    AppPermissionsView(permissionName: "BT_PERIPHERAL")
                }
                SettingsLink(color: .gray, icon: "camera.fill", id: "CAMERA".localize(table: table), status: "0") {
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
                    SettingsLink(color: .blue, icon: "sensorkit", id: "Research Sensor & Usage Data", status: "0") {
                        AppPermissionsView(permissionName: "Research Sensor & Usage Data")
                    }
                    SettingsLink(color: .gray, icon: "waveform", id: "SPEECH_RECOGNITION".localize(table: table), status: "0") {
                        AppPermissionsView(permissionName: "SPEECH_RECOGNITION")
                    }
                }
            }
            
            if UIDevice.iPhone && !UIDevice.IsSimulator {
                Section {
                    SettingsLink(color: .indigo, icon: "pencil.and.sparkles", id: "JOURNALING_SUGGESTIONS".localize(table: table)) {
                        JournalingSuggestionsView()
                    }
                }
            }
            
            if UIDevice.iPhone {
                Section {
                    SettingsLink(color: .white, iconColor: .blue, icon: "person.badge.shield.checkmark.fill", id: "Safety Check") {
                        SafetyCheckView()
                    }
                } footer: {
                    Text("Protect your personal safety by staying aware of which people, apps, and devices have access to your information.")
                }
            }
            
            Section {
                SettingsLink(color: .blue, icon: "eye.trianglebadge.exclamationmark.fill", id: "Sensitive Content Warning", status: "Off") {
                    SensitiveContentWarningView()
                }
            } footer: {
                Text("Detect nude photos and videos before they are viewed on your \(UIDevice.current.model), and receive guidance to help make a safe choice. Apple does not have access to the photos or videos. [Learn more...](https://support.apple.com/en-us/105071)")
            }
            
            Section {
                SettingsLink(color: .blue, icon: "chart.bar.xaxis", id: "PROBLEM_REPORTING".localize(table: table)) {}
                SettingsLink(color: .blue, icon: "megaphone.fill", id: "ADVERTISING".localize(table: table)) {
                    AppleAdvertisingView()
                }
            }
            
            Section {
                if !UIDevice.IsSimulator {
                    SettingsLink(color: .green, icon: "shield.lefthalf.filled", id: "APP_PRIVACY_REPORT".localize(table: table)) {}
                }
            }
            
            if !UIDevice.IsSimulator {
                Section {
                    if configuration.developerMode {
                        SettingsLink(color: .gray, icon: "hammer.fill", id: "DEVELOPER_MODE".localize(table: table), status: "Off") {
                            EmptyView()
                        }
                    }
                    SettingsLink(color: .blue, icon: "hand.raised.fill", id: "Lockdown Mode", status: "Off".localize(table: table)) {
                        EmptyView()
                    }
                } header: {
                    Text("Security")
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
