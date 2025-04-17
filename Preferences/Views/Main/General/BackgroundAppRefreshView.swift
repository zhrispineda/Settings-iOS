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
                    IconToggle("Books", isOn: .constant(true), icon: "appleBooks")
                    IconToggle("Freeform", isOn: .constant(true), icon: "appleFreeform")
                    IconToggle("Maps", isOn: .constant(true), icon: "appleMaps")
                    IconToggle("Music", isOn: .constant(true), icon: "appleMusic")
                    IconToggle("News", isOn: .constant(true), icon: "appleNews")
                    IconToggle("Notes", isOn: .constant(true), icon: "appleNotes")
                    IconToggle("Podcasts", isOn: .constant(true), icon: "applePodcasts")
                    IconToggle("Shortcuts", isOn: .constant(true), icon: "appleShortcuts")
                    IconToggle("Siri", isOn: .constant(true), icon: "appleSiri")
                    IconToggle("Stocks", isOn: .constant(true), icon: "appleStocks")
                    IconToggle("Translate", isOn: .constant(true), icon: "appleTranslate")
                    IconToggle("Voice Memos", isOn: .constant(true), icon: "appleVoiceMemos")
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
