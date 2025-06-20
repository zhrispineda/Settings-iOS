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
    let dsTable = "Dim-Sum"
    let focusTable = "FocusSettings"
    let healthTable = "HealthPrivacySettings"
    let sensorTable = "SensorKitPrivacySettings"
    let wellTable = "WellnessDashboard-Localizable"
    
    var body: some View {
        CustomList(title: permission.localize(table: table)) {
            // Primary explanation header
            switch permission {
            case "App Clips":
                Section {} footer: {
                    if appClipPermission == "CAMERA" || permission == "CAMERA" {
                        Text("CAMERA_HEADER", tableName: table)
                    }
                }
            case "CAMERA":
                Section {} footer: {
                    Text("CAMERA_HEADER", tableName: table)
                }
            case "FOCUS":
                Section {} footer: {
                    Text("AVAILABILITY_STATUS_EXPLANATION", tableName: focusTable)
                }
            case "HEALTH":
                Section {} footer: {
                    Text("\("PRIVACY_DISCLOSURE_FOOTER".localize(table: healthTable)) \n[\("PRIVACY_DISCLOSURE_FOOTER_LEARN_MORE".localize(table: healthTable))](pref://)")
                }
                
                Section {
                    NavigationLink("HEADPHONE_AUDIO_LEVELS".localize(table: healthTable), destination: HeadphoneAudioLevelsView())
                }
                
                Section {
                    Text("APPS_NONE", tableName: wellTable)
                        .foregroundStyle(.secondary)
                } header: {
                    Text("APPS_LIST_HEADER", tableName: wellTable)
                } footer: {
                    Text("APPS_LIST_EXPLANATION", tableName: wellTable)
                }
                
                Section {
                    Text("NONE", tableName: wellTable)
                        .foregroundStyle(.secondary)
                } header: {
                    Text("RESEARCH_STUDIES_LIST_HEADER", tableName: wellTable)
                } footer: {
                    Text("RESEARCH_STUDIES_LIST_EXPLANATION", tableName: wellTable)
                }
            case "MOTION":
                Section {
                    Toggle("FITNESS_TRACKING".localize(table: table), isOn: $fitnessTracking)
                } footer: {
                    Text("FITNESS_TRACKING_PRIVACY", tableName: table)
                }
            case "Research Sensor & Usage Data":
                Section {
                    Button("ENABLE_SENSORKIT_BUTTON".localize(table: sensorTable)) {}
                } footer: {
                    Text("\("DESCRIPTION_SENSORKIT".localize(table: sensorTable)) [\("LEARN_MORE".localize(table: sensorTable))](pref://)")
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
                    Text("AVAILABILITY_STATUS_SHARING_HEADER", tableName: "FocusSettings")
                }
            } footer: {
                switch permission {
                case "BT_PERIPHERAL", "CAMERA", "MEDIALIBRARY", "MICROPHONE", "MOTION", "NEARBY_INTERACTIONS", "PASSKEYS", "REMINDERS", "SPEECH_RECOGNITION", "WILLOW":
                    Text("\(permission)_FOOTER".localize(table: table))
                case "App Clips":
                    switch appClipPermission {
                    case "BT_PERIPHERAL":
                        Text("BT_PERIPHERAL_CLIPS_FOOTER", tableName: dsTable)
                    case "CAMERA":
                        Text("CAMERA_CLIPS_FOOTER", tableName: dsTable)
                    case "MICROPHONE":
                        Text("MICROPHONE_CLIPS_FOOTER", tableName: dsTable)
                    default:
                        Text("App clips that have requested access to use \(appClipPermission) will appear here.")
                    }
                case "FOCUS":
                    Text("AVAILABILITY_STATUS_APP_LIST_FOOTER", tableName: "FocusSettings")
                case "HEALTH", "Research Sensor & Usage Data":
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
