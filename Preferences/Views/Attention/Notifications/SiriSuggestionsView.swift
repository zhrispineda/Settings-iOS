//
//  SiriSuggestionsView.swift
//  Preferences
//
//  Settings > Notifications > Siri Suggestions
//

import SwiftUI

struct SiriSuggestionsView: View {
    // Variables
    @AppStorage("AllowNotificationsToggle") private var allowNotifications = true
    let table = "NotificationsSettings"
    
    var body: some View {
        CustomList(title: "SIRI_SUGGESTIONS".localize(table: table)) {
            Section {
                Toggle("ALLOW_NOTIFICATIONS".localize(table: table), isOn: $allowNotifications.animation())
            }
            
            if allowNotifications {
                if let url = URL(string: "ibooks://*"), UIApplication.shared.canOpenURL(url) {
                    IconToggle("Books", isOn: .constant(true), icon: "appleBooks")
                }
                if let url = URL(string: "freeform://*"), UIApplication.shared.canOpenURL(url) {
                    IconToggle("Freeform", isOn: .constant(true), icon: "appleFreeform")
                }
                if let url = URL(string: "maps://*"), UIApplication.shared.canOpenURL(url) {
                    IconToggle("Maps", isOn: .constant(true), icon: "appleMaps")
                }
                if let url = URL(string: "music://*"), UIApplication.shared.canOpenURL(url) {
                    IconToggle("Music", isOn: .constant(true), icon: "appleMusic")
                }
                if let url = URL(string: "applenews://*"), UIApplication.shared.canOpenURL(url) {
                    IconToggle("News", isOn: .constant(true), icon: "appleNews")
                }
                if let url = URL(string: "notes://*"), UIApplication.shared.canOpenURL(url) {
                    IconToggle("Notes", isOn: .constant(true), icon: "appleNotes")
                }
                if let url = URL(string: "podcasts://*"), UIApplication.shared.canOpenURL(url) {
                    IconToggle("Podcasts", isOn: .constant(true), icon: "applePodcasts")
                }
                if let url = URL(string: "shortcuts://*"), UIApplication.shared.canOpenURL(url) {
                    IconToggle("Shortcuts", isOn: .constant(true), icon: "appleShortcuts")
                }
                IconToggle("Siri", isOn: .constant(true), icon: "appleSiri")
                if let url = URL(string: "stocks://*"), UIApplication.shared.canOpenURL(url) {
                    IconToggle("Stocks", isOn: .constant(true), icon: "appleStocks")
                }
                if let url = URL(string: "translate://*"), UIApplication.shared.canOpenURL(url) {
                    IconToggle("Translate", isOn: .constant(true), icon: "appleTranslate")
                }
                if let url = URL(string: "voicememos://*"), UIApplication.shared.canOpenURL(url) {
                    IconToggle("Voice Memos", isOn: .constant(true), icon: "appleVoiceMemos")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SiriSuggestionsView()
    }
}
