import SwiftUI

/// A `CustomList` container for displaying options regarding Privacy & Security based on the given `permission` String.
///
/// ```swift
/// AppPermissionsView(permission: "App Clips")
/// ```
///
/// ```swift
/// AppPermissionsView(permission: "App Clips", appClipPermission: "Camera")
/// ```
///
/// - Parameter permission: The String to display as the navigation title.
/// - Parameter appClipsPermission: The  optional String to use when relating to App Clips.
struct AppPermissionsView: View {
    @AppStorage("PrivacyFitnessTrackingToggle") private var fitnessTracking = true
    var permission: String
    var appClipPermission = ""
    private let appClipsEligible = ["BT_PERIPHERAL", "CAMERA", "MICROPHONE"]
    
    // Tables
    private let table = "Privacy"
    private let privacyPath = "/System/Library/PrivateFrameworks/Settings/PrivacySettingsUI.framework"
    private let clipsTable = "Dim-Sum"
    private let focusTable = "/System/Library/PreferenceBundles/FocusSettings.bundle"
    
    var body: some View {
        CustomList(title: permission.localized(path: privacyPath, table: table)) {
            // Primary explanation header
            switch permission {
            case "App Clips":
                Section {} footer: {
                    if appClipPermission == "CAMERA" || permission == "CAMERA" {
                        Text("CAMERA_HEADER".localized(path: privacyPath, table: table))
                    }
                }
            case "CAMERA":
                Section {} footer: {
                    Text("CAMERA_HEADER".localized(path: privacyPath, table: table))
                }
            case "FOCUS":
                Section {} footer: {
                    Text("AVAILABILITY_STATUS_EXPLANATION".localized(path: focusTable))
                }
            case "MOTION":
                Section {
                    Toggle("FITNESS_TRACKING".localized(path: privacyPath, table: table), isOn: $fitnessTracking)
                } footer: {
                    Text("FITNESS_TRACKING_PRIVACY".localized(path: privacyPath, table: table))
                }
            default:
                EmptyView()
            }
            
            // Content and footer section
            Section {
                if appClipsEligible.contains(permission) {
                    SLink(
                        "App Clips",
                        icon: "com.apple.graphic-icon.app-clips",
                        status: "0",
                        destination: AppPermissionsView(permission: "App Clips", appClipPermission: permission)
                    )
                }
            } header: {
                if permission == "FOCUS" {
                    Text("AVAILABILITY_STATUS_SHARING_HEADER".localized(path: focusTable))
                }
            } footer: {
                switch permission {
                case "BT_PERIPHERAL", "CAMERA", "MEDIALIBRARY", "MICROPHONE", "MOTION", "NEARBY_INTERACTIONS", "PASSKEYS", "REMINDERS", "SPEECH_RECOGNITION", "WILLOW":
                    Text("\(permission)_FOOTER".localized(path: privacyPath, table: table))
                case "App Clips":
                    switch appClipPermission {
                    case "BT_PERIPHERAL":
                        Text("BT_PERIPHERAL_CLIPS_FOOTER".localized(path: privacyPath, table: clipsTable))
                    case "CAMERA":
                        Text("CAMERA_CLIPS_FOOTER".localized(path: privacyPath, table: clipsTable))
                    case "MICROPHONE":
                        Text("MICROPHONE_CLIPS_FOOTER".localized(path: privacyPath, table: clipsTable))
                    default:
                        EmptyView()
                    }
                case "FOCUS":
                    Text("AVAILABILITY_STATUS_APP_LIST_FOOTER".localized(path: focusTable))
                default:
                    EmptyView()
                }
            }
        }
    }
}

#Preview("App Clips") {
    NavigationStack {
        AppPermissionsView(permission: "App Clips", appClipPermission: "CAMERA")
    }
}

#Preview("Camera") {
    NavigationStack {
        AppPermissionsView(permission: "CAMERA")
    }
}

#Preview("Focus") {
    NavigationStack {
        AppPermissionsView(permission: "FOCUS")
    }
}
