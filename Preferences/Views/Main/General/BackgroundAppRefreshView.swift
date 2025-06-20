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
    @AppStorage("BackgroundAppRefreshPicker") private var backgroundAppRefreshPicker = "NONE"
    let table = "AutomaticContentDownload"
    
    var body: some View {
        CustomList(title: "AUTO_CONTENT_DOWNLOAD".localize(table: table)) {
            if UIDevice.CellularTelephonyCapability {
                Section {
                    SettingsLink("AUTO_CONTENT_DOWNLOAD".localize(table: table), status: backgroundAppRefreshPicker.localize(table: table), destination: SelectOptionList("AUTO_CONTENT_DOWNLOAD", options: ["NONE", "WIFI_ONLY", "WIFI_AND_CELLULAR"], selected: "WIFI_AND_CELLULAR", table: table))
                } footer: {
                    Text("FOOTER_WIFI_AND_CELLULAR", tableName: table)
                }
            } else {
                Section {
                    Toggle("AUTO_CONTENT_DOWNLOAD".localize(table: table), isOn: $backgroundAppRefreshToggle)
                } footer: {
                    Text("FOOTER_WIFI", tableName: table)
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
        }
    }
}

#Preview {
    NavigationStack {
        BackgroundAppRefreshView()
    }
}
