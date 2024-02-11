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
                SettingsLink(color: .orange, icon: "app.connected.to.app.below.fill", larger: false, id: "Tracking", content: {})
            }
            
            Section(content: {
                SettingsLink(icon: "applecontacts", id: "Contacts", content: {})
                SettingsLink(icon: "applecalendar", id: "Calendars", content: {})
                SettingsLink(icon: "applereminders", id: "Reminders", content: {})
                SettingsLink(icon: "applephotos", id: "Photos", content: {})
                SettingsLink(color: .blue, icon: "logo.bluetooth", id: "Bluetooth", content: {})
                SettingsLink(color: .blue, icon: "network", id: "Local Network", content: {})
                SettingsLink(color: .orange, icon: "mic.fill", larger: false, id: "Microphone", content: {})
                SettingsLink(color: .gray, icon: "waveform", id: "Speech Recognition", content: {})
                SettingsLink(color: .white, icon: "Icon", id: "Camera", content: {})
                SettingsLink(icon: "applehealth", id: "Health", content: {})
                if DeviceInfo().isPhone {
                    SettingsLink(color: .blue, icon: "point.3.filled.connected.trianglepath.dotted", id: "Research Sensor & Usage Data", content: {})
                }
                SettingsLink(icon: "applehome", id: "HomeKit", content: {})
                SettingsLink(icon: "applewallet", id: "Wallet", content: {})
                SettingsLink(icon: "applemusic", id: "Media & Apple Music", content: {})
                SettingsLink(icon: "applefiles", id: "Files & Folders", content: {})
                SettingsLink(color: .indigo, icon: "moon.fill", larger: false, id: "Focus", content: {})
                NavigationLink("Passkeys Access for Web Browsers", destination: {})
            }, footer: {
                Text("As apps request access, they will be added in the categories above.")
            })
            
            if DeviceInfo().isPhone {
                Section(content: {
                    SettingsLink(color: .white, iconColor: .blue, icon: "person.badge.shield.checkmark.fill", larger: false, id: "Safety Check", content: {})
                }, footer: {
                    Text("Protect your personal safety by staying aware of which people, apps, and devices have access to your information.")
                })
            }
            
            Section(content: {
                SettingsLink(color: .blue, icon: "eye.trianglebadge.exclamationmark.fill", larger: false, id: "Sensitive Content Warning", status: "Off", content: {})
            }, footer: {
                Text("Detect nude photos and videos before they are viewed on your iPhone, and receive guidance to help make a safe choice. Apple does not have access to the photos or videos. [Learn more...](https://support.apple.com/en-us/105071)")
            })
            
            Section {
                NavigationLink("Apple Advertising", destination: {})
            }
        }
    }
}

#Preview {
    NavigationStack {
        PrivacySecurityView()
    }
}
