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
                    CustomNavigationLink("AUTO_CONTENT_DOWNLOAD".localize(table: table), status: backgroundAppRefreshPicker.localize(table: table), destination: SelectOptionList(title: "AUTO_CONTENT_DOWNLOAD", options: ["NONE", "WIFI_ONLY", "WIFI_AND_CELLULAR"], selected: "WIFI_AND_CELLULAR", table: table))
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
                    SLabel("Books", icon: "appleBooks")
                    SLabel("Freeform", icon: "appleFreeform")
                    SLabel("Maps", icon: "appleMaps")
                    SLabel("Music", icon: "appleMusic")
                    SLabel("News", icon: "appleNews")
                    SLabel("Notes", icon: "appleNotes")
                    SLabel("Podcasts", icon: "applePodcasts")
                    SLabel("Shortcuts", icon: "appleShortcuts")
                    SLabel("Siri", icon: "appleSiri")
                    SLabel("Stocks", icon: "appleStocks")
                    SLabel("Translate", icon: "appleTranslate")
                    SLabel("Voice Memos", icon: "appleVoiceMemos")
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
