//
//  SiriSearchView.swift
//  Preferences
//
//  Settings > Siri
//

import SwiftUI

struct SiriView: View {
    // Variables
    let apps = ["Calendar", "Contacts", "Files", "Health", "Maps", "Messages", "News", "Photos", "Reminders", "Safari", "Settings", "Wallet", "Watch"]
    
    @State private var siriEnabled = true
    @State private var showingDisableSiriAlert = false
    @State private var showingDisableSiriPopup = false
    @State private var showingEnableSiriAlert = false
    @State private var showingEnableSiriPopup = false
    @State private var allowSiriWhenLockedEnabled = true
    
    @State private var showSuggestionsEnabled = true
    @State private var showingResetHiddenSuggestionsAlert = false
    @State private var showingResetHiddenSuggestionsPopup = false
    
    @State private var allowNotificationsEnabled = true
    @State private var showAppLibraryEnabled = true
    @State private var showWhenSharingEnabled = true
    @State private var showWhenListeningEnabled = true
    
    @State private var opacity: Double = 0
    @State private var frameY: Double = 0
    
    let table = "AssistantSettings"
    
    var body: some View {
        CustomList {
            Placard(title: "ASSISTANT".localize(table: table), icon: "appleSiri", description: "PLACARD_DESCRIPTION".localize(table: table))
                .overlay { // For calculating opacity of the principal toolbar item
                    GeometryReader { geo in
                        Color.clear
                            .onChange(of: geo.frame(in: .scrollView).minY) {
                                frameY = geo.frame(in: .scrollView).minY
                                opacity = frameY / -30
                            }
                    }
                }
            
            Section {
                CustomNavigationLink(title: "LANGUAGE".localize(table: table), status: "English (United States)", destination: SiriLanguageView())
                if !siriEnabled {
                    CustomNavigationLink(title: "VOICE".localize(table: table), status: "\("REGION_en-US".localize(table: table)) (Voice 4)", destination: SiriVoiceView())
                }
                if !UIDevice.IsSimulator {
                    CustomNavigationLink(title: "ACTIVATION_COMPACT".localize(table: table), status: "ACTIVATION_OFF".localize(table: table), destination: EmptyView())
                }
//                Toggle("Press \(Device().isPhone ? "\(Device().hasHomeButton ? "Home" : "Side") Button" : "Top Button") for Siri", isOn: $siriEnabled)
//                    .alert("Turn Off Siri?", isPresented: $showingDisableSiriAlert) {
//                        Button("Turn Off Siri") {}
//                        Button("Cancel", role: .cancel) {}
//                    } message: {
//                        Text("The information Siri uses to respond to your requests will be removed from Apple servers. If you want to use Siri later, it will take some time to re-send this information.")
//                    }
//                    .alert("Enable Siri?", isPresented: $showingEnableSiriAlert) {
//                        Button("Enable Siri") {}
//                        Button("Cancel", role: .cancel) {}
//                    } message: {
//                        Text("Siri sends information like your voice input, contacts, and location to Apple to process your requests.")
//                    }
//                    .confirmationDialog("Turn Off Siri", isPresented: $showingDisableSiriPopup, titleVisibility: .visible) {
//                        Button("Turn Off Siri") {}
//                        Button("Cancel", role: .cancel) {
//                            siriEnabled = true
//                        }
//                    } message: {
//                        Text("The information Siri uses to respond to your requests will be removed from Apple servers. If you want to use Siri later, it will take some time to re-send this information.")
//                    }
//                    .confirmationDialog("Enable Siri", isPresented: $showingEnableSiriPopup, titleVisibility: .visible) {
//                        Button("Enable Siri") {}
//                        Button("Cancel", role: .cancel) {}
//                    } message: {
//                        Text("Siri sends information like your voice input, contacts, and location to Apple to process your requests.")
//                    }
//                    .onChange(of: siriEnabled) {
//                        siriEnabled ? (Device().isPhone ? showingEnableSiriPopup.toggle() : showingEnableSiriAlert.toggle()) : (Device().isPhone ? showingDisableSiriPopup.toggle() : showingDisableSiriAlert.toggle())
//                    }
                if siriEnabled {
                    if !UIDevice.IsSimulator {
                        Toggle("ASSISTANT_LOCK_SCREEN_ACCESS".localize(table: table), isOn: $allowSiriWhenLockedEnabled)
                    }
                    CustomNavigationLink(title: "VOICE".localize(table: table), status: "\("REGION_en-US".localize(table: table)) (Voice 4)", destination: SiriVoiceView())
                    NavigationLink("VOICE_FEEDBACK".localize(table: table), destination: SiriResponsesView())
                    if !UIDevice.IsSimulator {
                        NavigationLink("ANNOUNCE_CALLS_TITLE".localize(table: table), destination: EmptyView())
                        NavigationLink("ANNOUNCE_MESSAGES_TITLE".localize(table: table), destination: EmptyView())
                    }
                    Button {} label: { // TODO: Popover
                        HStack {
                            Text("MyInfo", tableName: table)
                                .foregroundStyle(Color["Label"])
                            Spacer()
                            Text("None", tableName: table)
                                .foregroundStyle(Color(UIColor.secondaryLabel))
                            Image(systemName: "chevron.right")
                                .foregroundStyle(Color(UIColor.tertiaryLabel))
                        }
                    }
                }
                NavigationLink("ASSISTANT_HISTORY_LABEL".localize(table: table)) {}
                NavigationLink("MESSAGE_TITLE".localize(table: table), destination: {
                    CustomList(title: "MESSAGE_TITLE".localize(table: table)) {}
                })
            } header: {
                Text("SIRI_REQUESTS", tableName: table)
            } footer: {
                Text(.init(UIDevice.IsSimulator ? "[\("SIRI_REQUESTS_ABOUT_LINK_TEXT".localize(table: table))](#)" : "\("SIRI_REQUESTS_DEVICE_PROCESSING_FOOTER_TEXT_IPHONE".localize(table: table))" + " [\("SIRI_REQUESTS_ABOUT_LINK_TEXT".localize(table: table))](#)"))
//                Text(siriEnabled ? "Voice input is processed on \(UIDevice.current.model), but transcripts of your requests are sent to Apple. [About Siri & Privacy...](#)" : "Siri can help you get things done just by asking. [About Siri & Privacy...](#)")
            }
            
            Section {
                Toggle("SUGGESTIONS_SHOW_BEFORE_SEARCHING".localize(table: table), isOn: $showSuggestionsEnabled)
                Button("SUGGESTIONS_RESET_HIDDEN_NAME".localize(table: table)) { UIDevice.iPhone ? showingResetHiddenSuggestionsAlert.toggle() : showingResetHiddenSuggestionsPopup.toggle() }
                    .alert("SUGGESTIONS_RESET_HIDDEN_TITLE".localize(table: table), isPresented: $showingResetHiddenSuggestionsPopup) {
                        Button("SUGGESTIONS_RESET_HIDDEN_TITLE".localize(table: table), role: .destructive) {}
                        Button("SUGGESTIONS_RESET_HIDDEN_CANCEL".localize(table: table), role: .cancel) {}
                    } message: {
                        Text("SUGGESTIONS_RESET_HIDDEN_PROMPT", tableName: table)
                    }
                    .confirmationDialog("SUGGESTIONS_RESET_HIDDEN_PROMPT".localize(table: table), isPresented: $showingResetHiddenSuggestionsAlert, titleVisibility: .visible) {
                        Button("SUGGESTIONS_RESET_HIDDEN_TITLE".localize(table: table), role: .destructive) {}
                        Button("SUGGESTIONS_RESET_HIDDEN_CANCEL".localize(table: table), role: .cancel) {}
                    }
                Toggle("SUGGESTIONS_ALLOW_NOTIFICATIONS".localize(table: table), isOn: $allowNotificationsEnabled)
                Toggle("SUGGESTIONS_SHOW_IN_APPLIBRARY".localize(table: table), isOn: $showAppLibraryEnabled)
                Toggle("SUGGESTIONS_SHOW_WHEN_SHARING".localize(table: table), isOn: $showWhenSharingEnabled)
                Toggle("SUGGESTIONS_SHOW_WHEN_LISTENING".localize(table: table), isOn: $showWhenListeningEnabled)
            } header: {
                Text("SUGGESTIONS_GROUP", tableName: table)
            } footer: {
                Text("SUGGESTIONS_FOOTER", tableName: table)
            }
            
            Section {
                SettingsLink(color: .white, iconColor: .blue, icon: "appclip", id: "APP_CLIPS".localize(table: table)) {
                    SiriAppClipsView()
                }
                SettingsLink(icon: "appleHome Screen & App Library", id: "APPS_GROUP".localize(table: table)) {
                    CustomList(title: "APPS") {
                        ForEach(apps, id: \.self) { app in
                            SettingsLink(icon: "apple\(app)", id: app) {
                                SiriDetailView(appName: app, title: app)
                            }
                        }
                    }
                }
            } header: {
                Text("APP_ACCESS_GROUP", tableName: table)
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("ASSISTANT", tableName: table)
                    .fontWeight(.semibold)
                    .font(.subheadline)
                    .opacity(frameY < 50.0 ? opacity : 0) // Only fade when passing the help section title at the top
            }
        }
    }
}

#Preview {
    NavigationStack {
        SiriView()
    }
}
