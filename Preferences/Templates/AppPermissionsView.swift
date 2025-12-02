/*
Abstract:
A view for displaying options regarding Privacy & Security based on the given permission String.
*/

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
    @State private var showingSheet = false
    var permission: String
    var appClipPermission = ""
    let appClipsEligible = ["BT_PERIPHERAL", "CAMERA", "MICROPHONE"]
    var bundle = ""
    
    // Tables
    let table = "Privacy"
    let privacy = "/System/Library/PrivateFrameworks/Settings/PrivacySettingsUI.framework"
    let dsTable = "Dim-Sum"
    let focusTable = "/System/Library/PreferenceBundles/FocusSettings.bundle"
    let health = "/System/Library/PreferenceBundles/Privacy/HealthPrivacySettings.bundle"
    let sensorkit = "/System/Library/PreferenceBundles/Privacy/SensorKitPrivacySettings.bundle"
    let wellness = "/System/Library/PrivateFrameworks/HealthToolbox.framework"
    let wellTable = "WellnessDashboard-Localizable"
    var body: some View {
        CustomList(title: permission.localized(path: privacy, table: table)) {
            // Primary explanation header
            switch permission {
            case "App Clips":
                Section {} footer: {
                    if appClipPermission == "CAMERA" || permission == "CAMERA" {
                        Text("CAMERA_HEADER".localized(path: privacy, table: table))
                    }
                }
            case "CAMERA":
                Section {} footer: {
                    Text("CAMERA_HEADER".localized(path: privacy, table: table))
                }
            case "FOCUS":
                Section {} footer: {
                    Text("AVAILABILITY_STATUS_EXPLANATION".localized(path: focusTable))
                }
            case "MOTION":
                Section {
                    Toggle("FITNESS_TRACKING".localized(path: privacy, table: table), isOn: $fitnessTracking)
                } footer: {
                    Text("FITNESS_TRACKING_PRIVACY", tableName: table)
                }
            case "Research Sensor & Usage Data":
                Section {
                    Button("ENABLE_SENSORKIT_BUTTON".localized(path: sensorkit)) {}
                } footer: {
                    Text("\("DESCRIPTION_SENSORKIT".localized(path: sensorkit)) [\("LEARN_MORE".localized(path: sensorkit))](pref://)")
                }
            default:
                EmptyView()
            }
            
            // Content and footer section
            Section {
                if appClipsEligible.contains(permission) {
                    SLink("App Clips", icon: "com.apple.graphic-icon.app-clips", status: "0") {
                        AppPermissionsView(permission: "App Clips", appClipPermission: permission)
                    }
                }
            } header: {
                if permission == "FOCUS" {
                    Text("AVAILABILITY_STATUS_SHARING_HEADER".localized(path: focusTable))
                }
            } footer: {
                switch permission {
                case "BT_PERIPHERAL", "CAMERA", "MEDIALIBRARY", "MICROPHONE", "MOTION", "NEARBY_INTERACTIONS", "PASSKEYS", "REMINDERS", "SPEECH_RECOGNITION", "WILLOW":
                    Text("\(permission)_FOOTER".localized(path: privacy, table: table))
                case "App Clips":
                    switch appClipPermission {
                    case "BT_PERIPHERAL":
                        Text("BT_PERIPHERAL_CLIPS_FOOTER".localized(path: privacy, table: dsTable))
                    case "CAMERA":
                        Text("CAMERA_CLIPS_FOOTER".localized(path: privacy, table: dsTable))
                    case "MICROPHONE":
                        Text("MICROPHONE_CLIPS_FOOTER".localized(path: privacy, table: dsTable))
                    default:
                        Text("App clips that have requested access to use \(appClipPermission) will appear here.")
                    }
                case "FOCUS":
                    Text("AVAILABILITY_STATUS_APP_LIST_FOOTER".localized(path: focusTable))
                case "Research Sensor & Usage Data":
                    EmptyView()
                default:
                    Text("Applications that have requested the ability to use \(permission) will appear here.")
                }
            }
        }
        .onOpenURL { url in
            if url.absoluteString == "pref://" {
                showingSheet = true
            }
        }
        .sheet(isPresented: $showingSheet) {
            OnBoardingKitView(bundleID: "com.apple.onboarding.\(bundle)")
                .ignoresSafeArea()
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

#Preview("Research Sensor & Usage Data") {
    NavigationStack {
        AppPermissionsView(permission: "Research Sensor & Usage Data")
    }
}
