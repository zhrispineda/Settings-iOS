//
//  PermissionsView.swift
//  Preferences
//
//

import SwiftUI

struct PermissionsView: View {
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
    
    var body: some View {
        Section {
            if focus {
                IconToggle(enabled: $focusEnabled, color: .indigo, icon: "moon.fill", title: "Focus")
            }
            if location {
                SettingsLink(color: .blue, icon: "location.fill", id: "Location", status: "Never", content: {})
            }
            if photos {
                SettingsLink(icon: "applePhotos", id: "Photos", status: "Limited Access", content: {})
            }
            if camera {
                IconToggle(enabled: $cameraEnabled, color: .gray, icon: "camera.fill", title: "Camera")
            }
            if faceID {
                IconToggle(enabled: $faceIdEnabled, color: .green, icon: "faceid", title: "Face ID")
            }
            if siri {
                SettingsLink(icon: "appleSiri", id: "Siri & Search", content: {})
            }
            if notifications {
                SettingsLink(color: .red, icon: "bell.badge.fill", id: "Notifications", subtitle: "Banners, Sounds, Badges") {}
            }
            if liveActivity {
                SettingsLink(color: .blue, icon: "clock.badge.fill", larger: true, id: "Live Activities") {}
            }
            if liveActivityToggle {
                IconToggle(enabled: $liveActivityEnabled, color: .blue, icon: "clock.badge.fill", title: "Live Activities")
            }
            if background {
                IconToggle(enabled: $backgroundAppRefreshEnabled, color: .gray, icon: "gear", title: "Background App Refresh")
            }
            if cellular {
                IconToggle(enabled: $cellularEnabled, color: .green, icon: "antenna.radiowaves.left.and.right", title: "Cellular Data")
            }
            if phone {
                SettingsLink(color: .green, icon: "phone.arrow.down.left.fill", id: "Incoming Calls", status: "Banner") {}
                SettingsLink(color: .red, icon: "phone.badge.waveform.fill", id: "Announce Calls", status: "Never") {}
            }
        } header: {
            Text("\nAllow \(appName) To Access")
        } footer: {
            if appName == "Maps" {
                Text("[About Apple Maps & Privacy](POPOVER)")
            } else if appName == "Music" {
                Text("Use cellular data for downloads, streaming, updating your library, and loading artwork.")
            }
        }
    }
}

#Preview {
    NavigationStack {
        CustomList(title: "Example") {
            PermissionsView(appName: "Example", cellularEnabled: .constant(true))
        }
    }
}
