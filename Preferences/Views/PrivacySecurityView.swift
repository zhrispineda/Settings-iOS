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
            SectionHelp(title: "Privacy & Security", color: .blue, icon: "hand.raised.fill", description: "The advanced security and privacy features in \(UIDevice().systemName) help to safeguard your data while also providing contorl over the sharing of personal information. [Learn more...](https://support.apple.com/guide/iphone/use-built-in-privacy-and-security-protections-iph6e7d349d1/ios)")
            
            Section {
                SettingsLink(color: .blue, icon: "location.fill", id: "Location Services", subtitle: "1 while using") {
                    EmptyView()
                }
                SettingsLink(color: .orange, icon: "app.connected.to.app.below.fill", id: "Tracking", status: "0") {
                    TrackingView()
                }
            }
            
            Section {
                SettingsLink(icon: "applecalendar", id: "Calendars", subtitle: "None") {
                    AppPermissionsView(permissionName: "Calendars")
                }
                SettingsLink(icon: "applecontacts", id: "Contacts", subtitle: "None") {
                    AppPermissionsView(permissionName: "Contacts")
                }
                SettingsLink(icon: "applefiles", id: "Files & Folders", subtitle: "None") {
                    AppPermissionsView(permissionName: "Files & Folders")
                }
                SettingsLink(color: .indigo, icon: "moon.fill", id: "Focus", subtitle: "None") {
                    AppPermissionsView(permissionName: "Focus")
                }
                SettingsLink(icon: "applehealth", id: "Health", subtitle: "None") {
                    AppPermissionsView(permissionName: "Health")
                }
                SettingsLink(icon: "applehome", id: "HomeKit", subtitle: "None") {
                    AppPermissionsView(permissionName: "HomeKit")
                }
                SettingsLink(icon: "applemusic", id: "Media & Apple Music", subtitle: "None") {
                    AppPermissionsView(permissionName: "Media & Apple Music")
                }
                SettingsLink(color :.gray, icon: "person.badge.key.fill", id: "Passkeys Access for Web Browsers", subtitle: "None") {
                    AppPermissionsView(permissionName: "Passkeys Access for Web Browsers")
                }
                SettingsLink(icon: "applephotos", id: "Photos", subtitle: "None") {
                    AppPermissionsView(permissionName: "Photos")
                }
                SettingsLink(icon: "applereminders", id: "Reminders", subtitle: "None") {
                    AppPermissionsView(permissionName: "Reminders")
                }
                if Device().isPhone {
                    SettingsLink(icon: "applewallet", id: "Wallet", subtitle: "None") {
                        AppPermissionsView(permissionName: "Wallet")
                    }
                }
            }
            
            Section {
                SettingsLink(color: .blue, icon: "bluetooth", id: "Bluetooth", status: "0") {
                    AppPermissionsView(permissionName: "Bluetooth")
                }
                SettingsLink(color: .gray, icon: "camera.fill", id: "Camera", status: "0") {
                    AppPermissionsView(permissionName: "Camera")
                }
                SettingsLink(color: .blue, icon: "network", id: "Local Network", status: "0") {
                    AppPermissionsView(permissionName: "Local Network")
                }
                SettingsLink(color: .orange, icon: "mic.fill", id: "Microphone", status: "0") {
                    AppPermissionsView(permissionName: "Microphone")
                }
                SettingsLink(color: .green, icon: "figure.run", id: "Motion & Fitness", status: "0") {
                    AppPermissionsView(permissionName: "Microphone")
                }
                SettingsLink(color: .gray, icon: "waveform", id: "Speech Recognition", status: "0") {
                    AppPermissionsView(permissionName: "Speech Recognition")
                }
                if Device().isPhone {
                    SettingsLink(icon: "sensorKit60x60", id: "Research Sensor & Usage Data") {
                        AppPermissionsView(permissionName: "Research & Usage Data")
                    }
                }
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
                SettingsLink(color: .blue, icon: "chart.bar.xaxis", id: "Analytics & Improvement") {
                    AppleAdvertisingView()
                }
                SettingsLink(color: .blue, icon: "megaphone.fill", id: "Apple Advertising") {
                    AppleAdvertisingView()
                }
            }
            
            Section {} header: {
                Text("Security")
            }
        }
    }
}

#Preview {
    NavigationStack {
        PrivacySecurityView()
    }
}
