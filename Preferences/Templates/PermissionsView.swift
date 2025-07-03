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
    let ICBSettings = "/System/Library/PreferenceBundles/ICBSettingsBundle.bundle"
    let privacy = "/System/Library/OnBoardingBundles/com.apple.onboarding.maps.bundle"
    
    var body: some View {
        Section {
            if focus {
                IconToggle("FOCUS", isOn: $focusEnabled, icon: "com.apple.graphic-icon.focus", table: table)
            }
            if location {
                SLink("LOCATION_SERVICES".localize(table: table), icon: "com.apple.graphic-icon.location", status: "NEVER_AUTHORIZATION".localize(table: "LocationServicesPrivacy")) {}
            }
            if photos {
                SLink("PHOTOS".localize(table: table), icon: "com.apple.mobileslideshow", status: "PHOTOS_LIMITED_AUTHORIZATION".localize(table: table)) {}
            }
            if camera {
                IconToggle("CAMERA", isOn: $cameraEnabled, icon: "com.apple.graphic-icon.camera", table: table)
            }
            if faceID {
                IconToggle("FACE_ID", isOn: $faceIDEnabled, icon: "com.apple.graphic-icon.face-id", table: table)
            }
            if siri {
                if UIDevice.IntelligenceCapability {
                    SLink("Apple Intelligence & Siri", icon: "com.apple.graphic-icon.intelligence") {
                        SiriDetailView(appName: appName)
                    }
                } else {
                    SLink("Siri", icon: "com.apple.application-icon.siri") {
                        SiriDetailView(appName: appName)
                    }
                }
                SLink("Search", icon: "com.apple.graphic-icon.search") {
                    SearchDetailView(appName: appName, appTitle: false)
                }
            }
            if notifications {
                SLink("NOTIFICATIONS".localize(table: table), icon: "com.apple.graphic-icon.notifications", subtitle: appName == "Maps" ? "\("BANNER_ALERTS".localize(table: notifTable)), \("SOUNDS".localize(table: notifTable))" : "\("BANNER_ALERTS".localize(table: notifTable)), \("SOUNDS".localize(table: notifTable)), \("BADGES".localize(table: notifTable))") {}
            }
            if liveActivity {
                SLink("LIVE_ACTIVITIES".localize(table: table), icon: "com.apple.graphic-icon.live-activities") {}
            }
            if liveActivityToggle {
                IconToggle("LIVE_ACTIVITIES", isOn: $liveActivityEnabled, icon: "com.apple.graphic-icon.live-activities", table: table)
            }
            if background {
                IconToggle("BACKGROUND_APP_REFRESH", isOn: $backgroundAppRefreshEnabled, icon: "com.apple.graphic-icon.background-app-refresh", table: table)
            }
            if cellular && UIDevice.CellularTelephonyCapability {
                IconToggle("CELLULAR_DATA", isOn: $cellularEnabled, icon: "com.apple.graphic-icon.cellular-settings", table: table)
            }
            if phone {
                SLink("INCOMING_CALL_STYLE_LIST_BANNER".localized(path: ICBSettings, table: "ICBSettingsBundle"), icon: "com.apple.graphic-icon.incoming-phone-calls", status: "Banner") {}
                SLink("ANNOUNCE_CALLS_TITLE".localize(table: "AssistantSettings"), icon: "com.apple.graphic-icon.announce-phone-calls", status: "NEVER".localize(table: "MessagesSettings")) {}
            }
        } header: {
            Text("ALLOW_ACCESS_FORMAT".localize(table: table, appName))
        } footer: {
            if appName == "Maps" {
                Text("[\("BUTTON_TITLE".localized(path: privacy, table: "Maps"))](pref://maps)")
            } else if appName == "Music" && UIDevice.CellularTelephonyCapability {
                Text("CELLULAR_FOOTER_DOWNLOADS_ONLY", tableName: "MusicSettings")
            }
        }
        .onOpenURL { url in
            if url.absoluteString == "pref://maps" {
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
