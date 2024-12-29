//
//  SensitiveContentWarningView.swift
//  Preferences
//
//  Settings > Privacy & Security > Sensitive Content Warning
//

import SwiftUI

struct SensitiveContentWarningView: View {
    // Variables
    @Environment(\.colorScheme) private var colorScheme
    @State private var sensitiveContentWarningEnabled = false
    @State private var airDropEnabled = true
    @State private var contactsEnabled = true
    @State private var messagesEnabled = true
    @State private var videoMessagesEnabled = true
    @State private var improveSensitiveContentWarningEnabled = false
    @State private var showingSheet = false
    let table = "CommunicationSafetySettingsUI"
    
    var body: some View {
        CustomList(title: "Sensitive Content Warning".localize(table: table)) {
            Section {
                Toggle("Sensitive Content Warning".localize(table: table), isOn: $sensitiveContentWarningEnabled.animation())
            } footer: {
                Text(.init("Detect nude photos and videos before they are viewed on your Device, and receive guidance to help make a safe choice. Apple does not have access to the photos or videos. [Learn more…](%@)".localize(table: table, "https://support.apple.com/en-us/105071")))
            }
            
            Section {
                Button("View Safety Resources".localize(table: table)) {}
            } footer: {
                Text("Resources to help you make a safe choice when receiving photos or videos containing nudity.", tableName: table)
            }
            
            if sensitiveContentWarningEnabled {
                Section {
                    IconToggle(enabled: $airDropEnabled, color: colorScheme == .dark ? .blue : .white, icon: "airdrop", title: "AirDrop", iconColor: .blue)
                    IconToggle(enabled: $contactsEnabled, icon: "appleContacts", title: "Contacts".localize(table: table))
                    IconToggle(enabled: $messagesEnabled, icon: "appleMessages", title: "Messages".localize(table: table))
                    IconToggle(enabled: $videoMessagesEnabled, color: .green, icon: "video.bubble.fill", title: "Video Messages".localize(table: table))
                } header: {
                    Text("App & Service Access", tableName: table)
                }
                
                Section {
                    Toggle("Improve Sensitive Content Warning".localize(table: table), isOn: $improveSensitiveContentWarningEnabled)
                } header: {
                    Text("Analytics & Improvements", tableName: table)
                } footer: {
                    Text(.init("Help Apple improve Sensitive Content Warning by sharing analytics and usage data. Analytics and data are aggregated in a form that is not personally identifiable. No messages or media are shared with Apple. [%@](pref://)".localize(table: table, "About Improve Sensitive Content Warning & Privacy…".localize(table: table))))
                }
            }
        }
        .onOpenURL { url in
            if url.scheme == "pref" {
                showingSheet = true
            }
        }
        .sheet(isPresented: $showingSheet) {
            OnBoardingView(table: "ImproveSensitiveContentWarning")
        }
    }
}

#Preview {
    NavigationStack {
        SensitiveContentWarningView()
    }
}
