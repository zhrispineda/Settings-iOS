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
                Toggle("ALLOW_NOTIFICATIONS".localize(table: table), isOn: $allowNotifications)
            }
            
            if allowNotifications {
                if let url = URL(string: "ibooks://*"), UIApplication.shared.canOpenURL(url) {
                    IconToggle(enabled: .constant(true), icon: "appleBooks", title: "Books")
                }
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
            }
        }
    }
}

#Preview {
    NavigationStack {
        SiriSuggestionsView()
    }
}
