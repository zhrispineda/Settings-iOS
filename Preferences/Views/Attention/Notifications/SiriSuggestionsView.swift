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
                    IconToggle(enabled: .constant(true), icon: "appleBooks", title: "Books")
                }
                if let url = URL(string: "freeform://*"), UIApplication.shared.canOpenURL(url) {
                    IconToggle(enabled: .constant(true), icon: "appleFreeform", title: "Freeform")
                }
                if let url = URL(string: "maps://*"), UIApplication.shared.canOpenURL(url) {
                    IconToggle(enabled: .constant(true), icon: "appleMaps", title: "Maps")
                }
                if let url = URL(string: "music://*"), UIApplication.shared.canOpenURL(url) {
                    IconToggle(enabled: .constant(true), icon: "appleMusic", title: "Music")
                }
                if let url = URL(string: "applenews://*"), UIApplication.shared.canOpenURL(url) {
                    IconToggle(enabled: .constant(true), icon: "appleNews", title: "News")
                }
                if let url = URL(string: "notes://*"), UIApplication.shared.canOpenURL(url) {
                    IconToggle(enabled: .constant(true), icon: "appleNotes", title: "Notes")
                }
                if let url = URL(string: "podcasts://*"), UIApplication.shared.canOpenURL(url) {
                    IconToggle(enabled: .constant(true), icon: "applePodcasts", title: "Podcasts")
                }
                if let url = URL(string: "shortcuts://*"), UIApplication.shared.canOpenURL(url) {
                    IconToggle(enabled: .constant(true), icon: "appleShortcuts", title: "Shortcuts")
                }
                IconToggle(enabled: .constant(true), icon: "appleSiri", title: "Siri")
                if let url = URL(string: "stocks://*"), UIApplication.shared.canOpenURL(url) {
                    IconToggle(enabled: .constant(true), icon: "appleStocks", title: "Stocks")
                }
                if let url = URL(string: "translate://*"), UIApplication.shared.canOpenURL(url) {
                    IconToggle(enabled: .constant(true), icon: "appleTranslate", title: "Translate")
                }
                if let url = URL(string: "voicememos://*"), UIApplication.shared.canOpenURL(url) {
                    IconToggle(enabled: .constant(true), icon: "appleVoiceMemos", title: "Voice Memos")
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
