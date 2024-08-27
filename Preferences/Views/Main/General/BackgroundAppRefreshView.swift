//
//  BackgroundAppRefreshView.swift
//  Preferences
//
//  Settings > General > Background App Refresh
//

import SwiftUI

struct BackgroundAppRefreshView: View {
    // Variables
    @State private var backgroundAppRefresh = true
    
    var body: some View {
        CustomList(title: "Background App Refresh") {
            if UIDevice.CellularTelephonyCapability {
                Section {
                    CustomNavigationLink(title: "Background App Refresh", status: "On", destination: SelectOptionList(title: "Background App Refresh", options: ["Off", "Wi-Fi", "Wi-Fi & Cellular Data"], selected: "Wi-Fi & Cellular Data"))
                } footer: {
                    Text("Allow apps to refresh their content when on Wi-Fi or cellular in the background. Turning off apps may help preserve battery life.")
                }
            } else {
                Section {
                    Toggle("Background App Refresh", isOn: $backgroundAppRefresh)
                } footer: {
                    Text("Allow apps to refresh their content when on Wi-Fi in the background. Turning off apps may help preserve battery life.")
                }
            }
            
            Section {
                if backgroundAppRefresh {
                    IconToggle(enabled: .constant(true), icon: "appleMaps", title: "Maps")
                    IconToggle(enabled: .constant(true), icon: "appleMusic", title: "Music")
                    IconToggle(enabled: .constant(true), icon: "appleNews", title: "News")
                } else {
                    SettingsLabel(icon: "appleMaps", id: "Maps")
                    SettingsLabel(icon: "appleMusic", id: "Music")
                    SettingsLabel(icon: "appleNews", id: "News")
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
