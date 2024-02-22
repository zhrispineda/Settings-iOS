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
                SettingsLink(color: .orange, icon: "app.connected.to.app.below.fill", larger: false, id: "Tracking", content: {
                    TrackingView()
                })
            }
            
            Section(content: {
                SettingsLink(icon: "applecontacts", id: "Contacts", content: {
                    AppPermissionsView(permissionName: "Contacts")
                })
                SettingsLink(icon: "applecalendar", id: "Calendars", content: {
                    AppPermissionsView(permissionName: "Calendars")
                })
                SettingsLink(icon: "applereminders", id: "Reminders", content: {
                    AppPermissionsView(permissionName: "Reminders")
                })
                SettingsLink(icon: "applephotos", id: "Photos", content: {
                    AppPermissionsView(permissionName: "Photos")
                })
                SettingsLink(color: .blue, icon: "logo.bluetooth", id: "Bluetooth", content: {
                    AppPermissionsView(permissionName: "Bluetooth")
                })
                SettingsLink(color: .blue, icon: "network", id: "Local Network", content: {
                    AppPermissionsView(permissionName: "Local Network")
                })
                SettingsLink(color: .orange, icon: "mic.fill", larger: false, id: "Microphone", content: {
                    AppPermissionsView(permissionName: "Microphone")
                })
                SettingsLink(color: .gray, icon: "waveform", id: "Speech Recognition", content: {
                    AppPermissionsView(permissionName: "Speech Recognition")
                })
                SettingsLink(color: .white, icon: "Placeholder_Normal", id: "Camera", content: {
                    AppPermissionsView(permissionName: "Camera")
                })
                SettingsLink(icon: "applehealth", id: "Health", content: {
                    AppPermissionsView(permissionName: "Health")
                })
                if DeviceInfo().isPhone {
                    SettingsLink(color: .blue, icon: "Sensor and Usage Data - 80_Normal", id: "Research Sensor & Usage Data", content: {
                        AppPermissionsView(permissionName: "Research & Usage Data")
                    })
                }
                SettingsLink(icon: "applehome", id: "HomeKit", content: {
                    AppPermissionsView(permissionName: "HomeKit")
                })
                SettingsLink(icon: "applewallet", id: "Wallet", content: {
                    AppPermissionsView(permissionName: "Wallet")
                })
                SettingsLink(icon: "applemusic", id: "Media & Apple Music", content: {
                    AppPermissionsView(permissionName: "Media & Apple Music")
                })
                SettingsLink(icon: "applefiles", id: "Files and Folders", content: {
                    AppPermissionsView(permissionName: "Files and Folders")
                })
                SettingsLink(color: .indigo, icon: "moon.fill", larger: false, id: "Focus", content: {
                    AppPermissionsView(permissionName: "Focus")
                })
                NavigationLink("Passkeys Access for Web Browsers", destination: AppPermissionsView(permissionName: "PassKeys Access for Web Browsers"))
            }, footer: {
                Text("As apps request access, they will be added in the categories above.")
            })
            
            if DeviceInfo().isPhone {
                Section(content: {
                    SettingsLink(color: .white, iconColor: .blue, icon: "person.badge.shield.checkmark.fill", larger: false, id: "Safety Check", content: {
                        SafetyCheckView()
                    })
                }, footer: {
                    Text("Protect your personal safety by staying aware of which people, apps, and devices have access to your information.")
                })
            }
            
            Section(content: {
                SettingsLink(color: .blue, icon: "eye.trianglebadge.exclamationmark.fill", larger: false, id: "Sensitive Content Warning", status: "Off", content: {
                    SensitiveContentWarningView()
                })
            }, footer: {
                Text("Detect nude photos and videos before they are viewed on your \(DeviceInfo().model), and receive guidance to help make a safe choice. Apple does not have access to the photos or videos. [Learn more...](https://support.apple.com/en-us/105071)")
            })
            
            Section {
                NavigationLink("Apple Advertising", destination: {
                    AppleAdvertisingView()
                })
            }
        }
    }
}

#Preview {
    NavigationStack {
        PrivacySecurityView()
    }
}
