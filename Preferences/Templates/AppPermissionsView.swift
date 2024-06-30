//
//  AppPermissionsView.swift
//  Preferences
//

import SwiftUI

/// A ``View`` template for displaying options regarding Privacy & Security based on the given ``permissionName``.
/// ```swift
/// AppPermissionsView(permissionName: "Contacts")
/// ```
/// - Parameter permissionName: The ``String`` to display as the permission for the ``View``.
/// - Parameter appClipsPermission: The  optional ``String`` to use when relating to App Clips.
struct AppPermissionsView: View {
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
                                .frame(width: 275, height: 80)
                                .padding(.top, 40)
                            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                                .foregroundStyle(Color(UIColor.systemGray5))
                                .shadow(radius: 5.0)
                                .frame(width: 300, height: 80)
                                .padding(.top, 20)
                            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                                .foregroundStyle(Color(UIColor.systemGray5))
                                .shadow(radius: 5.0)
                                .frame(width: 320, height: 80)
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
                        Text("**Full Calendar Access**")
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
            }
            
            if permissionName == "Photos" {
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
            }
            
            if permissionName == "Camera" || appClipPermission == "Camera" {
                Section {} footer: {
                    Text("Photos and videos taken with the camera may contain other information, such as where and when they were taken, and the depth of field.")
                }
            }
            
            if permissionName == "Health" {
                Section {} footer: {
                    Text("Your data is encrypted on your device and can only be shared with your permission. \n[Learn more about Health & Privacy...](#)")
                }
                .padding(-15)
                
                Section {
                    NavigationLink("Headphone Audio Level", destination: HeadphoneAudioLevelsView())
                }
                
                Section {
                    Text("None")
                        .foregroundStyle(.secondary)
                } header: {
                    Text("Apps and Services")
                } footer: {
                    Text("As apps and services request permission to update your Health data, they will be added to the list.")
                }
                
                Section {
                    Text("None")
                        .foregroundStyle(.secondary)
                } header: {
                    Text("Research Studies")
                } footer: {
                    Text("As research studies request permission to read your data, they will be added to the list. You can review and manage all of the studies you are enrolled in by going to the Research app.")
                }
            }
            
            if permissionName == "Wallet" {
                Section {} footer: {
                    Text("Your data is encrypted on your device and can only be shared with your permission.")
                }
            }
            
            if permissionName == "Focus" {
                Section {} footer: {
                    Text("Your Focus status tells apps and people that you have notifications silenced.")
                }
            }
            
            Section {
                if appClipsEligible.contains(permissionName) {
                    SettingsLink(color: .white, icon: "appclip", id: "App Clips", content: {
                        AppPermissionsView(permissionName: "App Clips", appClipPermission: permissionName)
                    })
                }
            } header: {
                if permissionName == "Focus" {
                    Text("Shared With")
                }
            } footer: {
                switch permissionName {
                case "App Clips":
                    switch appClipPermission {
                    case "Camera":
                        Text("App clips that have requested the ability to the camera will appear here.")
                    case "Microphone":
                        Text("App clips that have requested the ability to the microphone will appear here.")
                    default:
                        Text("App clips that have requested the ability to use \(appClipPermission) will appear here.")
                    }
                case "Calendars":
                    Text("Apps that have requested access to your calendar events will appear here.")
                case "Contacts", "Reminders":
                    Text("Applications that have requested the ability to your \(permissionName.lowercased()) will appear here.")
                case "Photos":
                    Text("Apps that have requested the ability to your \(permissionName.lowercased()) will appear here.")
                case "Local Network":
                    Text("Apps that have requested permission to find and communicate with devices on your local network will appear here.")
                case "Microphone":
                    Text("Applications that have requested access to the microphone will appear here.")
                case "Camera":
                    Text("Apps that have requested to access the camera will appear here.")
                case "Health":
                    EmptyView()
                case "Research Sensor & Usage Data":
                    EmptyView()
                case "Wallet":
                    Text("Apps that have requested access to banking and financial accounts will appear here.")
                case "Speech Recognition":
                    Text("Applications that have requested access to speech recognition will appear here. Speech recognition sends recorded voice to Apple to process your requests.")
                case "Persona Virtual Camera":
                    Text("Applications that have requested access to the Persona virtual camera will appear here.")
                case "Home":
                    Text("Applications that have requested access to home data will appear here.")
                case "Media & Apple Music":
                    Text("Apps that have requested access to Apple Music, your music and video activity, and your media library will appear here.")
                case "Files and Folders":
                    Text("Applications that have requested access to files and folders will appear here.")
                case "Focus":
                    Text("Apps that have requested the ability to see and share your Focus status will appear here.")
                case "Passkeys Access for Web Browsers":
                    Text("Applications that have requested the ability to see which websites and apps you have saved passkeys for.")
                default:
                    Text("Applications that have requested the ability to use \(permissionName) will appear here.")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AppPermissionsView(permissionName: "Calendars")
    }
}
