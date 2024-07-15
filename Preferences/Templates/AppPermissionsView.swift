//
//  AppPermissionsView.swift
//  Preferences
//

import SwiftUI

/// A ``CustomList`` template for displaying options regarding Privacy & Security based on the given ``permissionName``.
/// ```swift
/// AppPermissionsView(permissionName: "Contacts")
/// ```
/// ```swift
/// AppPermissionsView(permissionName: "Camera", appClipPermission: "Camera")
/// ```
/// - Parameter permissionName: The ``String`` to display as the permission for the ``View``.
/// - Parameter appClipsPermission: The  optional ``String`` to use when relating to App Clips.
struct AppPermissionsView: View {
    @State private var fitnessTracking = true
    @State private var healthEnabled = true
    @State private var messagesEnabled = true
    var permissionName = String()
    var appClipPermission = String()
    let appClipsEligible = ["Bluetooth", "Microphone", "Camera"]
    
    var body: some View {
        CustomList(title: permissionName) {
            if permissionName == "Calendars" {
                Section {
                    VStack(alignment: .leading) {
                        ZStack {
                            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                                .foregroundStyle(Color(UIColor.systemGray5))
                                .shadow(radius: 5.0)
                                .frame(width: 280, height: 75)
                                .padding(.top, 40)
                            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                                .foregroundStyle(Color(UIColor.systemGray5))
                                .shadow(radius: 5.0)
                                .frame(width: 300, height: 75)
                                .padding(.top, 20)
                            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                                .foregroundStyle(Color(UIColor.systemGray5))
                                .shadow(radius: 5.0)
                                .frame(width: 320, height: 75)
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("SUNDAY, MAR 10")
                                        .foregroundColor(.red)
                                        .font(.caption)
                                    HStack {
                                        RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                                            .foregroundStyle(Color(UIColor.systemPurple))
                                            .frame(width: 3, height: 30)
                                        VStack(alignment: .leading) {
                                            Text("**Daylight Saving Time**")
                                                .font(.caption)
                                                .foregroundStyle(.secondary)
                                            Text("**all-day**")
                                                .font(.caption)
                                                .foregroundStyle(.secondary)
                                        }
                                    }
                                }
                                .padding(15)
                                Spacer()
                            }
                        }
                        .drawingGroup()
                        .padding()
                        .padding(.top, -30)
                        Text("Full Calendar Access")
                            .bold()
                            .font(.callout)
                            .padding(.leading)
                        Text("3 calendars, 50 events in the next year")
                            .foregroundStyle(.secondary)
                            .font(.caption2)
                            .padding(.leading)
                    }
                } footer: {
                    Text("Calendar events may include additional data, such as location, email addresses, or notes.")
                }
            } else if permissionName == "Photos" {
                Section {
                    VStack(alignment: .leading) {
                        Text("**Full Photo Library Access**")
                        Text("No Items")
                            .foregroundStyle(.secondary)
                    }
                    .padding(3)
                } footer: {
                    Text("Photos may contain data associated with location, depth information, captions, and audio.")
                }
            } else if permissionName == "Camera" || appClipPermission == "Camera" {
                Section {} footer: {
                    Text("Photos and videos taken with the camera may contain other information, such as where and when they were taken, and the depth of field.")
                }
            } else if permissionName == "Health" {
                Section {} footer: {
                    Text("Your data is encrypted on your device and can only be shared with your permission. \n[Learn more about Health & Privacy...](#)")
                }
                .padding(-15)
                
                Section {
                    NavigationLink("Headphone Audio Levels", destination: HeadphoneAudioLevelsView())
                }
                
                Section {
                    Text("None")
                        .foregroundStyle(.secondary)
                } header: {
                    Text("Apps")
                } footer: {
                    Text("As apps request permission to update your Health data, they will be added to the list.")
                }
                
                Section {
                    Text("None")
                        .foregroundStyle(.secondary)
                } header: {
                    Text("Research Studies")
                } footer: {
                    Text("As research studies request permission to read your data, they will be added to the list. You can review and manage all of the studies you are enrolled in by going to the Research app.")
                }
            } else if permissionName == "Wallet" {
                Section {} footer: {
                    Text("Your data is encrypted on your device and can only be shared with your permission.")
                }
            } else if permissionName == "Focus" {
                Section {} footer: {
                    Text("Your Focus status tells apps and people that you have notifications silenced.")
                }
            } else if permissionName == "Research Sensor & Usage Data" {
                Section {
                    Button("Enable Sensor & Usage Data Collection") {}
                } footer: {
                    Text("Sensor & Usage Data is sensitive research data that allows apps and studies to access certain important sources of information that are otherwise unavailable. [Learn more about Sensor & Usage Data...](#)")
                }
            } else if permissionName == "Motion & Fitness" {
                Section {
                    Toggle("Fitness Tracking", isOn: $fitnessTracking)
                } footer: {
                    Text("Motion & Fitness Tracking stores your data on your device which can be used to estimate your body motion, mobility, step counts, stairs climbed, and more.")
                }
            }
            
            Section {
                if appClipsEligible.contains(permissionName) {
                    SettingsLink(color: .white, iconColor: .blue, icon: "appclip", id: "App Clips") {
                        AppPermissionsView(permissionName: "App Clips", appClipPermission: permissionName)
                    }
                } else if permissionName == "Focus" {
                    IconToggle(enabled: $messagesEnabled, icon: "appleMessages", title: "Messages")
                } else if permissionName == "Motion & Fitness" {
                    IconToggle(enabled: $healthEnabled, icon: "appleHealth", title: "Health")
                }
            } header: {
                if permissionName == "Focus" {
                    Text("Shared With")
                }
            } footer: {
                switch permissionName {
                case "App Clips":
                    switch appClipPermission {
                    case "Camera", "Microphone":
                        Text("App clips that have requested access to the \(appClipPermission.lowercased()) will appear here.")
                    default:
                        Text("App clips that have requested access to use \(appClipPermission) will appear here.")
                    }
                case "Calendars":
                    Text("Apps that have requested access to your calendar events will appear here.")
                case "Contacts", "Reminders":
                    Text("Applications that have requested access to your \(permissionName.lowercased()) will appear here.")
                case "Files & Folders":
                    Text("Applications that have requested access to files and folders will appear here.")
                case "Photos":
                    Text("Apps that have requested access to your photos will appear here.")
                case "Accessories":
                    Text("Apps that have access to one or more accessories will appear here. Additional paired accessories can be found in Home app, Bluetooth, and Wi-Fi settings.")
                case "Local Network":
                    Text("Apps that have requested permission to find and communicate with devices on your local network will appear here.")
                case "Microphone":
                    Text("Applications that have requested access to the microphone will appear here.")
                case "Camera":
                    Text("Apps that have requested access to the camera will appear here.")
                case "Health", "Research Sensor & Usage Data":
                    EmptyView()
                case "Wallet":
                    Text("Apps that have requested access to your financial account will appear here.")
                case "Speech Recognition":
                    Text("Applications that have requested access to speech recognition will appear here. Speech recognition sends recorded voice to Apple to process your requests.")
                case "Persona Virtual Camera":
                    Text("Applications that have requested access to the Persona virtual camera will appear here.")
                case "HomeKit":
                    Text("Applications that have requested access to home data will appear here.")
                case "Media & Apple Music":
                    Text("Apps that have requested access to Apple Music, your music and video activity, and your media library will appear here.")
                case "Files and Folders":
                    Text("Applications that have requested access to files and folders will appear here.")
                case "Focus":
                    Text("Apps that have requested the ability to see and share your Focus status will appear here.")
                case "Passkeys Access for Web Browsers":
                    Text("Applications that have requested the ability to see which websites and apps you have saved passkeys for.")
                case "Motion & Fitness":
                    Text("Apps that have requested access to your motion and fitness activity will appear here.")
                case "Nearby Interactions":
                    Text("Nearby Interaction uses Ultra Wideband and Bluetooth to precisely measure the distance between your iPhone and other devices or items.")
                default:
                    Text("Applications that have requested the ability to use \(permissionName) will appear here.")
                }
            }
        }
    }
}

#Preview("Camera") {
    NavigationStack {
        AppPermissionsView(permissionName: "App Clips")
    }
}

#Preview("Calendars") {
    NavigationStack {
        AppPermissionsView(permissionName: "Calendars")
    }
}

#Preview("Photos") {
    NavigationStack {
        AppPermissionsView(permissionName: "Photos")
    }
}

#Preview("Health") {
    NavigationStack {
        AppPermissionsView(permissionName: "Health")
    }
}

#Preview("Wallet") {
    NavigationStack {
        AppPermissionsView(permissionName: "Wallet")
    }
}

#Preview("Focus") {
    NavigationStack {
        AppPermissionsView(permissionName: "Focus")
    }
}
