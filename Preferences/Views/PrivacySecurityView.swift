//
//  PrivacySecurityView.swift
//  Preferences
//
//  Settings > Privacy & Security
//

import SwiftUI

struct PrivacySecurityView: View {
    var body: some View {
        CustomList(title: "Privacy & Security") {
            Section {
                SettingsLink(color: .orange, icon: "app.connected.to.app.below.fill", larger: false, id: "Tracking") {
                    TrackingView()
                }
            }
            
            Section {
                SettingsLink(icon: "applecontacts", id: "Contacts") {
                    AppPermissionsView(permissionName: "Contacts")
                }
                SettingsLink(icon: "applecalendar", id: "Calendars") {
                    AppPermissionsView(permissionName: "Calendars")
                }
                SettingsLink(icon: "applereminders", id: "Reminders") {
                    AppPermissionsView(permissionName: "Reminders")
                }
                SettingsLink(icon: "applephotos", id: "Photos") {
                    AppPermissionsView(permissionName: "Photos")
                }
                SettingsLink(color: .blue, icon: "bluetooth", id: "Bluetooth") {
                    AppPermissionsView(permissionName: "Bluetooth")
                }
                SettingsLink(color: .blue, icon: "network", id: "Local Network") {
                    AppPermissionsView(permissionName: "Local Network")
                }
                SettingsLink(color: .orange, icon: "mic.fill", larger: false, id: "Microphone") {
                    AppPermissionsView(permissionName: "Microphone")
                }
                SettingsLink(color: .gray, icon: "waveform", id: "Speech Recognition") {
                    AppPermissionsView(permissionName: "Speech Recognition")
                }
                SettingsLink(color: .white, icon: "Placeholder_Normal", id: "Camera") {
                    AppPermissionsView(permissionName: "Camera")
                }
                SettingsLink(icon: "applehealth", id: "Health", content: {
                    AppPermissionsView(permissionName: "Health")
                })
                if Device().isPhone {
                    SettingsLink(icon: "sensorKit60x60", id: "Research Sensor & Usage Data") {
                        AppPermissionsView(permissionName: "Research & Usage Data")
                    }
                }
                SettingsLink(icon: "applehome", id: "HomeKit") {
                    AppPermissionsView(permissionName: "HomeKit")
                }
                SettingsLink(icon: "applewallet", id: "Wallet") {
                    AppPermissionsView(permissionName: "Wallet")
                }
                SettingsLink(icon: "applemusic", id: "Media & Apple Music") {
                    AppPermissionsView(permissionName: "Media & Apple Music")
                }
                SettingsLink(icon: "applefiles", id: "Files and Folders") {
                    AppPermissionsView(permissionName: "Files and Folders")
                }
                SettingsLink(color: .indigo, icon: "moon.fill", larger: false, id: "Focus") {
                    AppPermissionsView(permissionName: "Focus")
                }
                NavigationLink("Passkeys Access for Web Browsers", destination: AppPermissionsView(permissionName: "PassKeys Access for Web Browsers"))
            } footer: {
                Text("As apps request access, they will be added in the categories above.")
            }
            
            if Device().isPhone {
                Section {
                    SettingsLink(color: .white, iconColor: .blue, icon: "person.badge.shield.checkmark.fill", larger: false, id: "Safety Check") {
                        SafetyCheckView()
                    }
                } footer: {
                    Text("Protect your personal safety by staying aware of which people, apps, and devices have access to your information.")
                }
            }
            
            Section {
                SettingsLink(color: .blue, icon: "eye.trianglebadge.exclamationmark.fill", larger: false, id: "Sensitive Content Warning", status: "Off") {
                    SensitiveContentWarningView()
                }
            } footer: {
                Text("Detect nude photos and videos before they are viewed on your \(Device().model), and receive guidance to help make a safe choice. Apple does not have access to the photos or videos. [Learn more...](https://support.apple.com/en-us/105071)")
            }
            
            Section {
                NavigationLink("Apple Advertising", destination: AppleAdvertisingView())
            }
        }
    }
}

#Preview {
    NavigationStack {
        PrivacySecurityView()
    }
}
