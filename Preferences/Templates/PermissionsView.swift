/*
Abstract:
A Section container for displaying controls to manage what permission an app has.
*/

import SwiftUI

/// A Section container for displaying controls to manage what permission an app has.
/// ```swift
/// var body: some View {
///     List {
///         PermissionsView(appName: "Example", cellularEnabled: .constant(true))
///     }
/// }
/// ```
/// - Parameter appName: The String name of the app to manage permissions for.
/// - Parameter background:A Bool for if the Background App Refresh option is available.
/// - Parameter camera:A Bool for if the Camera option is available.
/// - Parameter cellular:A Bool for if the Cellular option is available.
/// - Parameter faceID:A Bool for if the Face ID option is available.
/// - Parameter focus:A Bool for if the Focus option is available.
/// - Parameter liveActivity:A Bool for if the Live Activity option is available.
/// - Parameter liveActivityToggle:A Bool for if the Background App Refresh toggle is available.
/// - Parameter location:A Bool for if the Location option is available.
/// - Parameter notifications:A Bool for if the Notifications option is available.
/// - Parameter phone:A Bool for if the Phone option is available.
/// - Parameter photos:A Bool for if the Photos option is available.
/// - Parameter siri:A Bool for if the Siri option is available.
struct PermissionsView: View {
    // Variables
    var appName: String
    var background: Bool = false
    var camera: Bool = false
    var cellular: Bool = true
    var faceID: Bool = false
    var focus: Bool = false
    var liveActivity: Bool = false
    var liveActivityToggle: Bool = false
    var location: Bool = true
    var notifications: Bool = true
    var phone: Bool = false
    var photos: Bool = false
    var siri: Bool = true

    @State private var backgroundAppRefreshEnabled = true
    @State private var cameraEnabled = true
    @Binding var cellularEnabled: Bool
    @State private var focusEnabled = false
    @State private var faceIdEnabled = true
    @State private var liveActivityEnabled = true
    @State private var showingSheet = false
    
    let table = "PSSystemPolicy"
    
    var body: some View {
        Section {
            if focus {
                IconToggle(enabled: $focusEnabled, color: .indigo, icon: "moon.fill", title: "FOCUS", table: table)
            }
            if location {
                SettingsLink(color: .blue, icon: "location.fill", id: "LOCATION_SERVICES".localize(table: table), status: "Never") {}
            }
            if photos {
                SettingsLink(icon: "applePhotos", id: "PHOTOS".localize(table: table), status: "PHOTOS_LIMITED_AUTHORIZATION".localize(table: table)) {}
            }
            if camera {
                IconToggle(enabled: $cameraEnabled, color: .gray, icon: "camera.fill", title: "CAMERA", table: table)
            }
            if faceID {
                IconToggle(enabled: $faceIdEnabled, color: .green, icon: "faceid", title: "Face ID")
            }
            if siri {
                if UIDevice.IntelligenceCapability {
                    SettingsLink(icon: "appleIntelligence", id: "Apple Intelligence & Siri") {
                        SiriDetailView(appName: appName)
                    }
                } else {
                    SettingsLink(icon: "appleSiri", id: "Siri") {
                        SiriDetailView(appName: appName)
                    }
                }
                SettingsLink(color: .gray, icon: "magnifyingglass", id: "Search") {
                    SearchDetailView(appName: appName, appTitle: false)
                }
            }
            if notifications {
                SettingsLink(color: .red, icon: "bell.badge.fill", id: "NOTIFICATIONS".localize(table: table), subtitle: appName == "Maps" ? "Banners, Sounds" : "Banners, Sounds, Badges") {}
            }
            if liveActivity {
                SettingsLink(color: .blue, icon: "clock.badge.fill", id: "LIVE_ACTIVITIES".localize(table: table)) {}
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
                SettingsLink(color: .green, icon: "phone.arrow.down.left.fill", id: "Incoming Calls", status: "Banner") {}
                SettingsLink(color: .red, icon: "phone.badge.waveform.fill", id: "Announce Calls", status: "Never") {}
            }
        } header: {
            Text("ALLOW_ACCESS_FORMAT".localize(table: table, appName))
        } footer: {
            if appName == "Maps" {
                Text("[About Apple Maps & Privacy...](mapsOBK://)")
            } else if appName == "Music" {
                Text("Use cellular data for downloads, streaming, updating your library, and loading artwork.")
            }
        }
        .onOpenURL { url in
            if url.scheme == "mapsOBK" {
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
