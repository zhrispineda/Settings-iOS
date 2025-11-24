//
//  BackgroundAppRefreshView.swift
//  Preferences
//
//  Settings > General > Background App Refresh
//

import SwiftUI

struct BackgroundAppRefreshView: View {
    @AppStorage("BackgroundAppRefreshToggle") private var backgroundAppRefreshToggle = true
    @AppStorage("BackgroundAppRefreshPicker") private var backgroundAppRefreshPicker = "Wi-Fi & Cellular Data"
    let path = "/System/Library/PreferenceBundles/BackgroundAppRefresh.bundle"
    
    var body: some View {
        CustomList(title: "Background App Refresh".localized(path: path)) {
            if UIDevice.CellularTelephonyCapability {
                Section {
                    SettingsLink(
                        "Background App Refresh".localized(path: path),
                        status: backgroundAppRefreshPicker.localized(path: path),
                        destination: SelectOptionList(
                            "Background App Refresh".localized(path: path),
                            options: ["Off", "Wi-Fi", "Wi-Fi & Cellular Data"],
                            selected: $backgroundAppRefreshPicker,
                            path: path
                        )
                    )
                } footer: {
                    Text("Allow apps to refresh their content when on Wi-Fi or cellular in the background. Turning off apps may help preserve battery life.".localized(path: path))
                }
            } else {
                Section {
                    Toggle("Background App Refresh".localized(path: path), isOn: $backgroundAppRefreshToggle)
                } footer: {
                    Text("Allow apps to refresh their content when on Wi-Fi in the background. Turning off apps may help preserve battery life.".localized(path: path))
                }
            }
            
            Section {
                if backgroundAppRefreshToggle {
                    IconToggle("Books", isOn: .constant(true), icon: "com.apple.iBooks")
                    IconToggle("Freeform", isOn: .constant(true), icon: "com.apple.freeform")
                    IconToggle("Maps", isOn: .constant(true), icon: "com.apple.Maps")
                    IconToggle("Music", isOn: .constant(true), icon: "com.apple.Music")
                    IconToggle("News", isOn: .constant(true), icon: "com.apple.news")
                    IconToggle("Notes", isOn: .constant(true), icon: "com.apple.mobilenotes")
                    IconToggle("Podcasts", isOn: .constant(true), icon: "com.apple.podcasts")
                    IconToggle("Shortcuts", isOn: .constant(true), icon: "com.apple.shortcuts")
                    IconToggle("Siri", isOn: .constant(true), icon: "com.apple.application-icon.siri")
                    IconToggle("Stocks", isOn: .constant(true), icon: "com.apple.stocks")
                    IconToggle("Translate", isOn: .constant(true), icon: "com.apple.Translate")
                    IconToggle("Voice Memos", isOn: .constant(true), icon: "com.apple.VoiceMemos")
                } else {
                    SLabel("Books", icon: "com.apple.iBooks")
                    SLabel("Freeform", icon: "com.apple.freeform")
                    SLabel("Maps", icon: "com.apple.Maps")
                    SLabel("Music", icon: "com.apple.Music")
                    SLabel("News", icon: "com.apple.news")
                    SLabel("Notes", icon: "com.apple.mobilenotes")
                    SLabel("Podcasts", icon: "com.apple.podcasts")
                    SLabel("Shortcuts", icon: "com.apple.shortcuts")
                    SLabel("Siri", icon: "com.apple.application-icon.siri")
                    SLabel("Stocks", icon: "com.apple.stocks")
                    SLabel("Translate", icon: "com.apple.Translate")
                    SLabel("Voice Memos", icon: "com.apple.VoiceMemos")
                }
            }
            .disabled(backgroundAppRefreshPicker == "Off")
        }
    }
}

#Preview {
    NavigationStack {
        BackgroundAppRefreshView()
    }
}
