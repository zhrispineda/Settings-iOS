/*
Abstract:
A view for displaying options regarding Privacy & Security based on the given permissionName String.
*/

import SwiftUI

/// A `CustomList` container for displaying options regarding Privacy & Security based on the given `permissionName` String.
///
/// ```swift
/// AppPermissionsView(permissionName: "App Clips")
/// ```
///
/// ```swift
/// AppPermissionsView(permissionName: "App Clips", appClipPermission: "Camera")
/// ```
///
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
            case "CAMERA":
                Section {} footer: {
                    Text("CAMERA_HEADER", tableName: table)
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
            case "Research Sensor & Usage Data":
                Section {
                    Button("Enable Sensor & Usage Data Collection") {}
                } footer: {
                    Text("Sensor & Usage Data is sensitive research data that allows apps and studies to access certain important sources of information that are otherwise unavailable. [Learn more about Sensor & Usage Data...](#)")
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
                case "ACCESSORY_SETUP", "BT_PERIPHERAL", "CAMERA", "LOCAL_NETWORK", "MEDIALIBRARY", "MICROPHONE", "MOTION", "NEARBY_INTERACTIONS", "PASSKEYS", "REMINDERS", "SPEECH_RECOGNITION", "WILLOW":
                    Text("\(permissionName)_FOOTER".localize(table: table))
                case "App Clips":
                    switch appClipPermission {
                    case "CAMERA", "MICROPHONE":
                        Text("App clips that have requested access to the \(appClipPermission.lowercased()) will appear here.")
                    default:
                        Text("App clips that have requested access to use \(appClipPermission) will appear here.")
                    }
                case "FOCUS":
                    Text("Apps that have requested the ability to see and share your Focus status will appear here.")
                case "HEALTH", "Research Sensor & Usage Data":
                    EmptyView()
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
