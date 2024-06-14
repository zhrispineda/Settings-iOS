//
//  SensitiveContentWarningView.swift
//  Preferences
//
//  Settings > Privacy & Security > Sensitive Content Warning
//

import SwiftUI

struct SensitiveContentWarningView: View {
    // Variables
    @State private var sensitiveContentWarningEnabled = false
    @State private var airDropEnabled = true
    @State private var contactsEnabled = true
    @State private var messagesEnabled = true
    @State private var videoMessagesEnabled = true
    @State private var improveSensitiveContentWarningEnabled = false
    
    var body: some View {
        CustomList(title: "Sensitive Content Warning") {
            Section {
                Toggle("Sensitive Content Warning", isOn: $sensitiveContentWarningEnabled.animation())
            } footer: {
                Text("Detect nude photos and videos before they are viewed on your \(Device().model), and receive guidance to help make a safe choice. Apple does not have access to the photos or videos. [Learn more...](https://support.apple.com/en-us/105071)")
            }
            
            Section {
                Button("View Safety Resources") {}
            } footer: {
                Text("Resources to help you make a safe choice when receiving photos or videos containing nudity.")
            }
            
            if sensitiveContentWarningEnabled {
                Section {
                    IconToggle(enabled: $airDropEnabled, color: .white, icon: "airdrop", title: "AirDrop")
                    IconToggle(enabled: $contactsEnabled, icon: "applecontacts", title: "Contacts")
                    IconToggle(enabled: $messagesEnabled, icon: "applemessages", title: "Messages")
                    IconToggle(enabled: $videoMessagesEnabled, color: .green, icon: "video.bubble.fill", title: "Video Messages")
                } header: {
                    Text("App & Service Access")
                }
                
                Section {
                    Toggle("Improve Sensitive Content Warning", isOn: $improveSensitiveContentWarningEnabled)
                } header: {
                    Text("Analytics & Improvements")
                } footer: {
                    Text("Help Apple improve Sensitive Content Warning by sharing analytics and usage data. Analytics and data aggregated in a form that is not personally identifiable. No messages or media are shared with Apple. [About Improve Sensitive Content Warning & Privacy...](#)")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SensitiveContentWarningView()
    }
}
