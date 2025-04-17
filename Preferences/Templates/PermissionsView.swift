/*
Abstract:
A Section container for displaying controls to manage what permission an app has.
*/

import SwiftUI

/// A Section container for displaying controls to manage what permission an app has.
///
/// ```swift
/// var body: some View {
///     List {
///         PermissionsView(appName: "Example", cellularEnabled: .constant(true))
///     }
/// }
/// ```
///
/// - Parameter appName: The String name of the app to manage permissions for.
/// - Parameter background: A Bool for if the Background App Refresh option is available.
/// - Parameter camera: A Bool for if the Camera option is available.
/// - Parameter cellular: A Bool for if the Cellular option is available.
/// - Parameter faceID: A Bool for if the Face ID option is available.
/// - Parameter focus: A Bool for if the Focus option is available.
/// - Parameter liveActivity: A Bool for if the Live Activity option is available.
/// - Parameter liveActivityToggle: A Bool for if the Background App Refresh toggle is available.
/// - Parameter location: A Bool for if the Location option is available.
/// - Parameter notifications: A Bool for if the Notifications option is available.
/// - Parameter phone: A Bool for if the Phone option is available.
/// - Parameter photos: A Bool for if the Photos option is available.
/// - Parameter siri: A Bool for if the Siri option is available.
struct PermissionsView: View {
    // Variables
    var appName: String
    var background = false
    var camera = false
    var cellular = true
    var faceID = false
    var focus = false
    var liveActivity = false
    var liveActivityToggle = false
    var location = true
    var notifications = true
    var phone = false
    var photos = false
    var siri = true

    @State private var backgroundAppRefreshEnabled = true
    @State private var cameraEnabled = true
    @Binding var cellularEnabled: Bool
    @State private var focusEnabled = false
    @State private var faceIDEnabled = true
    @State private var liveActivityEnabled = true
    @State private var showingSheet = false
    
    let table = "PSSystemPolicy"
    let notifTable = "NotificationsSettings"
    
    var body: some View {
        Section {
            if focus {
                IconToggle(enabled: $focusEnabled, color: .indigo, icon: "moon.fill", title: "FOCUS", table: table)
            }
            if location {
                SLink("LOCATION_SERVICES".localize(table: table), color: .blue, icon: "location.fill", status: "NEVER_AUTHORIZATION".localize(table: "LocationServicesPrivacy")) {}
            }
            if photos {
                SLink("PHOTOS".localize(table: table), icon: "applePhotos", status: "PHOTOS_LIMITED_AUTHORIZATION".localize(table: table)) {}
            }
            if camera {
                IconToggle(enabled: $cameraEnabled, color: .gray, icon: "camera.fill", title: "CAMERA", table: table)
            }
            if faceID {
                IconToggle(enabled: $faceIDEnabled, color: .green, icon: "faceid", title: "FACE_ID".localize(table: "Pearl"))
            }
            if siri {
                if UIDevice.IntelligenceCapability {
                    SLink("Apple Intelligence & Siri", icon: "appleIntelligence") {
                        SiriDetailView(appName: appName)
                    }
                } else {
                    SLink("Siri", icon: "appleSiri") {
                        SiriDetailView(appName: appName)
                    }
                }
                SLink("Search", color: .gray, icon: "magnifyingglass") {
                    SearchDetailView(appName: appName, appTitle: false)
                }
            }
            if notifications {
                SLink("NOTIFICATIONS".localize(table: table), color: .red, icon: "bell.badge.fill", subtitle: appName == "Maps" ? "\("BANNER_ALERTS".localize(table: notifTable)), \("SOUNDS".localize(table: notifTable))" : "\("BANNER_ALERTS".localize(table: notifTable)), \("SOUNDS".localize(table: notifTable)), \("BADGES".localize(table: notifTable))") {}
            }
            if liveActivity {
                SLink("LIVE_ACTIVITIES".localize(table: table), color: .blue, icon: "clock.badge.fill") {}
            }
            if liveActivityToggle {
                IconToggle(enabled: $liveActivityEnabled, color: .blue, icon: "clock.badge.fill", title: "LIVE_ACTIVITIES", table: table)
            }
            if background {
                IconToggle(enabled: $backgroundAppRefreshEnabled, color: .gray, icon: "arrow.clockwise.app.stack.fill", title: "BACKGROUND_APP_REFRESH", table: table)
            }
            if cellular && UIDevice.CellularTelephonyCapability {
                IconToggle(enabled: $cellularEnabled, color: .green, icon: "antenna.radiowaves.left.and.right", title: "CELLULAR_DATA", table: table)
            }
            if phone {
                SLink("INCOMING_CALL_STYLE_LIST_BANNER".localize(table: "ICBSettingsBundle"), color: .green, icon: "phone.arrow.down.left.fill", status: "Banner") {}
                SLink("ANNOUNCE_CALLS_TITLE".localize(table: "AssistantSettings"), color: .red, icon: "phone.badge.waveform.fill", status: "NEVER".localize(table: "MessagesSettings")) {}
            }
        } header: {
            Text("ALLOW_ACCESS_FORMAT".localize(table: table, appName))
        } footer: {
            if appName == "Maps" {
                Text("[\("ABOUT_PRIVACY".localize(table: "PrivacyDisclosureUI", "Maps"))](pref://)")
            } else if appName == "Music" && UIDevice.CellularTelephonyCapability {
                Text("CELLULAR_FOOTER_DOWNLOADS_ONLY", tableName: "MusicSettings")
            }
        }
        .onOpenURL { url in
            if url.scheme == "pref" {
                showingSheet = true
            }
        }
        .sheet(isPresented: $showingSheet) {
            OnBoardingKitView(bundleID: "com.apple.onboarding.maps")
                .ignoresSafeArea()
        }
    }
}

#Preview {
    NavigationStack {
        CustomList(title: "Maps", topPadding: true) {
            PermissionsView(appName: "Maps", cellularEnabled: .constant(true))
        }
    }
}
