/*
Abstract:
A view for displaying options regarding Privacy & Security based on the given permissionName String.
*/

import SwiftUI

/// A `CustomList` container for displaying options regarding Privacy & Security based on the given `permissionName` String.
/// ```swift
/// AppPermissionsView(permissionName: "Contacts")
/// ```
/// ```swift
/// AppPermissionsView(permissionName: "Camera", appClipPermission: "Camera")
/// ```
/// - Parameter permissionName: The String to display as the navigation title.
/// - Parameter appClipsPermission: The  optional String to use when relating to App Clips.
struct AppPermissionsView: View {
    @AppStorage("PrivacyFitnessTrackingToggle") private var fitnessTracking = true
    var permissionName = String()
    var appClipPermission = String()
    let appClipsEligible = ["BT_PERIPHERAL", "CAMERA", "MICROPHONE"]
    let table = "Privacy"
    
    var body: some View {
        CustomList(title: permissionName.localize(table: table)) {
            // Primary explanation header
            switch permissionName {
            case "App Clips":
                Section {} footer: {
                    if appClipPermission == "CAMERA" {
                        Text("CAMERA_HEADER", tableName: table)
                    }
                }
            case "CALENDARS":
                Section {
                    VStack(alignment: .leading) {
                        ZStack {
                            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                                .foregroundStyle(Color(UIColor.systemGray5))
                                .shadow(radius: 1)
                                .frame(width: 280, height: 75)
                                .padding(.top, 40)
                            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                                .foregroundStyle(Color(UIColor.systemGray5))
                                .shadow(radius: 1)
                                .frame(width: 300, height: 75)
                                .padding(.top, 20)
                            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                                .foregroundStyle(Color(UIColor.systemGray5))
                                .shadow(radius: 1)
                                .frame(width: 320, height: 75)
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("SUNDAY, MAR 10")
                                        .foregroundColor(.red)
                                        .font(.caption)
                                        .fontWeight(.semibold)
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
                        Text("CALENDARS_PREVIEW_TABLE_TITLE", tableName: table)
                            .bold()
                            .font(.callout)
                            .padding(.leading)
                        Text("3 calendars, 50 events in the next year")
                            .foregroundStyle(.secondary)
                            .font(.subheadline)
                            .padding(.leading)
                    }
                } footer: {
                    Text("CALENDARS_PRIVACY_DESCRIPTION", tableName: table)
                }
            case "CAMERA":
                Section {} footer: {
                    Text("CAMERA_HEADER", tableName: table)
                }
            case "CONTACTS":
                Section {
                    Text("0 Contacts")
                        .fontWeight(.semibold)
                } footer: {
                    Text("CONTACTS_PRIVACY_FOOTER", tableName: table)
                }
            case "FOCUS":
                Section {} footer: {
                    Text("Your Focus status tells apps and people that you have notifications silenced.")
                }
            case "HEALTH":
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
            case "MOTION":
                Section {
                    Toggle("FITNESS_TRACKING".localize(table: table), isOn: $fitnessTracking)
                } footer: {
                    Text("FITNESS_TRACKING_PRIVACY", tableName: table)
                }
            case "PHOTOS":
                Section {
                    VStack(alignment: .leading) {
                        Text("**Full Photo Library Access**")
                        Text("No Items")
                            .foregroundStyle(.secondary)
                    }
                    .padding(3)
                } footer: {
                    Text("PHOTOS_GRID_FOOTER", tableName: table)
                }
            case "Research Sensor & Usage Data":
                Section {
                    Button("Enable Sensor & Usage Data Collection") {}
                } footer: {
                    Text("Sensor & Usage Data is sensitive research data that allows apps and studies to access certain important sources of information that are otherwise unavailable. [Learn more about Sensor & Usage Data...](#)")
                }
            case "WALLET":
                Section {} footer: {
                    Text("Your data is encrypted on your device and can only be shared with your permission.")
                }
            default:
                EmptyView()
            }
            
            // Content and footer section
            Section {
                if appClipsEligible.contains(permissionName) {
                    SettingsLink(color: .white, iconColor: .blue, icon: "appclip", id: "App Clips") {
                        AppPermissionsView(permissionName: "App Clips", appClipPermission: permissionName)
                    }
                }
            } header: {
                if permissionName == "FOCUS" {
                    Text("Shared With")
                }
            } footer: {
                switch permissionName {
                case "ACCESSORY_SETUP", "BT_PERIPHERAL", "CAMERA", "FILEACCESS", "LOCAL_NETWORK", "MEDIALIBRARY", "MICROPHONE", "MOTION", "NEARBY_INTERACTIONS", "PASSKEYS", "REMINDERS", "SPEECH_RECOGNITION", "WILLOW":
                    Text("\(permissionName)_FOOTER".localize(table: table))
                case "App Clips":
                    switch appClipPermission {
                    case "CAMERA", "MICROPHONE":
                        Text("App clips that have requested access to the \(appClipPermission.lowercased()) will appear here.")
                    default:
                        Text("App clips that have requested access to use \(appClipPermission) will appear here.")
                    }
                case "CALENDARS":
                    Text("CALENDARS_NO_APP_FOOTER", tableName: table)
                case "CONTACTS":
                    Text("CONTACTS_NO_APP_FOOTER", tableName: table)
                case "FOCUS":
                    Text("Apps that have requested the ability to see and share your Focus status will appear here.")
                case "HEALTH", "Research Sensor & Usage Data":
                    EmptyView()
                case "PHOTOS":
                    Text("PHOTOS_NO_APP_FOOTER", tableName: table)
                case "WALLET":
                    Text("Apps that have requested access to your financial account will appear here.")
                default:
                    Text("Applications that have requested the ability to use \(permissionName) will appear here.")
                }
            }
        }
    }
}

#Preview("App Clips") {
    NavigationStack {
        AppPermissionsView(permissionName: "App Clips", appClipPermission: "CAMERA")
    }
}

#Preview("Calendars") {
    NavigationStack {
        AppPermissionsView(permissionName: "CALENDARS")
    }
}
