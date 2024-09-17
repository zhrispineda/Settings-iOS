//
//  BackgroundAppRefreshView.swift
//  Preferences
//
//  Settings > General > Background App Refresh
//

import SwiftUI

struct BackgroundAppRefreshView: View {
    // Variables
    @AppStorage("BackgroundAppRefreshToggle") private var backgroundAppRefreshToggle = true
    @AppStorage("BackgroundAppRefreshPicker") private var backgroundAppRefreshPicker = "On"
    
    var body: some View {
        CustomList(title: "Background App Refresh") {
            if UIDevice.CellularTelephonyCapability {
                Section {
                    CustomNavigationLink(title: "Background App Refresh", status: backgroundAppRefreshPicker, destination: SelectOptionList(title: "Background App Refresh", options: ["Off", "Wi-Fi", "Wi-Fi & Cellular Data"], selected: "Wi-Fi & Cellular Data"))
                } footer: {
                    Text("Allow apps to refresh their content when on Wi-Fi or cellular in the background. Turning off apps may help preserve battery life.")
                }
            } else {
                Section {
                    Toggle("Background App Refresh", isOn: $backgroundAppRefreshToggle)
                } footer: {
                    Text("Allow apps to refresh their content when on Wi-Fi in the background. Turning off apps may help preserve battery life.")
                }
            }
            
            Section {
                if backgroundAppRefreshToggle {
                    IconToggle(enabled: .constant(true), icon: "appleBooks", title: "Books")
                    IconToggle(enabled: .constant(true), icon: "appleFreeform", title: "Freeform")
                    IconToggle(enabled: .constant(true), icon: "appleMaps", title: "Maps")
                    IconToggle(enabled: .constant(true), icon: "appleMusic", title: "Music")
                    IconToggle(enabled: .constant(true), icon: "appleNews", title: "News")
                    IconToggle(enabled: .constant(true), icon: "appleNotes", title: "Notes")
                    IconToggle(enabled: .constant(true), icon: "applePodcasts", title: "Podcasts")
                    IconToggle(enabled: .constant(true), icon: "appleShortcuts", title: "Shortcuts")
                    IconToggle(enabled: .constant(true), icon: "appleSiri", title: "Siri")
                    IconToggle(enabled: .constant(true), icon: "appleStocks", title: "Stocks")
                    IconToggle(enabled: .constant(true), icon: "appleTranslate", title: "Translate")
                    IconToggle(enabled: .constant(true), icon: "appleVoiceMemos", title: "Voice Memos")
                } else {
                    SettingsLabel(icon: "appleBooks", id: "Books")
                    SettingsLabel(icon: "appleFreeform", id: "Freeform")
                    SettingsLabel(icon: "appleMaps", id: "Maps")
                    SettingsLabel(icon: "appleMusic", id: "Music")
                    SettingsLabel(icon: "appleNews", id: "News")
                    SettingsLabel(icon: "appleNotes", id: "Notes")
                    SettingsLabel(icon: "applePodcasts", id: "Podcasts")
                    SettingsLabel(icon: "appleShortcuts", id: "Shortcuts")
                    SettingsLabel(icon: "appleSiri", id: "Siri")
                    SettingsLabel(icon: "appleStocks", id: "Stocks")
                    SettingsLabel(icon: "appleTranslate", id: "Translate")
                    SettingsLabel(icon: "appleVoiceMemos", id: "Voice Memos")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        BackgroundAppRefreshView()
    }
}
