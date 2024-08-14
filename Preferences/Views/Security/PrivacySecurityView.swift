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
    
    var body: some View {
        CustomList(title: "Privacy & Security") {
            SectionHelp(title: "Privacy & Security", color: .blue, icon: "hand.raised.fill", description: "The advanced security and privacy features in \(UIDevice().systemName) help to safeguard your data while also providing control over the sharing of personal information. [Learn more...](https://support.apple.com/guide/iphone/use-built-in-privacy-and-security-protections-iph6e7d349d1/ios)")
                .overlay { // For calculating opacity of the principal toolbar item
                    GeometryReader { geo in
                        Color.clear
                            .onChange(of: geo.frame(in: .scrollView).minY) {
                                frameY = geo.frame(in: .scrollView).minY
                                opacity = frameY / -30
                            }
                    }
                }
            
            Section {
                SettingsLink(color: .blue, icon: "location.fill", id: "Location Services", subtitle: "1 while using") {
                    LocationServicesView()
                }
                SettingsLink(color: .orange, icon: "app.connected.to.app.below.fill", id: "Tracking", status: "0") {
                    TrackingView()
                }
            }
            
            Section {
                SettingsLink(icon: "appleCalendar", id: "Calendars", subtitle: "None") {
                    AppPermissionsView(permissionName: "Calendars")
                }
                SettingsLink(icon: "appleContacts", id: "Contacts", subtitle: "None") {
                    AppPermissionsView(permissionName: "Contacts")
                }
                SettingsLink(icon: "appleFiles", id: "Files & Folders", subtitle: "None") {
                    AppPermissionsView(permissionName: "Files & Folders")
                }
                SettingsLink(color: .indigo, icon: "moon.fill", id: "Focus", subtitle: "None") {
                    AppPermissionsView(permissionName: "Focus")
                }
                SettingsLink(icon: "appleHealth", id: "Health", subtitle: "None") {
                    AppPermissionsView(permissionName: "Health")
                }
                SettingsLink(icon: "appleHome", id: "HomeKit", subtitle: "None") {
                    AppPermissionsView(permissionName: "HomeKit")
                }
                SettingsLink(icon: "appleMusic", id: "Media & Apple Music", subtitle: "None") {
                    AppPermissionsView(permissionName: "Media & Apple Music")
                }
                SettingsLink(color: .gray, icon: "person.badge.key.fill", id: "Passkeys Access for Web Browsers", subtitle: "None") {
                    AppPermissionsView(permissionName: "Passkeys Access for Web Browsers")
                }
                SettingsLink(icon: "applePhotos", id: "Photos", subtitle: "None") {
                    AppPermissionsView(permissionName: "Photos")
                }
                SettingsLink(icon: "appleReminders", id: "Reminders", subtitle: "None") {
                    AppPermissionsView(permissionName: "Reminders")
                }
                if UIDevice.iPhone {
                    SettingsLink(icon: "appleWallet", id: "Wallet", subtitle: "None") {
                        AppPermissionsView(permissionName: "Wallet")
                    }
                }
            }
            
            Section {
                SettingsLink(color: .blue, icon: "Accessory", id: "Accessories", status: "0") {
                    AppPermissionsView(permissionName: "Accessories")
                }
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
                SettingsLink(color: .green, icon: "figure.run.motion", id: "Motion & Fitness", status: "0") {
                    AppPermissionsView(permissionName: "Motion & Fitness")
                }
                SettingsLink(color: .blue, icon: "nearby.interactions", id: "Nearby Interactions", status: "0") {
                    AppPermissionsView(permissionName: "Nearby Interactions")
                }
                if UIDevice.iPhone {
                    SettingsLink(color: .blue, icon: "sensorkit", id: "Research Sensor & Usage Data", status: "0") {
                        AppPermissionsView(permissionName: "Research Sensor & Usage Data")
                    }
                    SettingsLink(color: .gray, icon: "waveform", id: "Speech Recognition", status: "0") {
                        AppPermissionsView(permissionName: "Speech Recognition")
                    }
                }
            }
            
            if UIDevice.iPhone && !UIDevice.isSimulator {
                Section {
                    SettingsLink(color: .indigo, icon: "pencil.and.sparkles", id: "Journaling Suggestions") {
                        EmptyView()
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
                SettingsLink(color: .blue, icon: "chart.bar.xaxis", id: "Analytics & Improvement") {}
                SettingsLink(color: .blue, icon: "megaphone.fill", id: "Apple Advertising") {
                    AppleAdvertisingView()
                }
            }
            
            Section {
                if !UIDevice.isSimulator {
                    SettingsLink(color: .green, icon: "shield.lefthalf.filled", id: "App Privacy Report") {}
                }
            }
            
            Section {
                if !UIDevice.isSimulator {
                    if Configuration().developerMode {
                        SettingsLink(color: .gray, icon: "hammer.fill", id: "Developer Mode", status: "On") {
                            EmptyView()
                        }
                    }
                    SettingsLink(color: .blue, icon: "hand.raised.fill", id: "Lockdown Mode", status: "Off") {
                        EmptyView()
                    }
                }
            } header: {
                Text("Security")
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
