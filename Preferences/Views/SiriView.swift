//
//  SiriSearchView.swift
//  Preferences
//
//  Settings > Siri & Search
//

import SwiftUI

struct SiriView: View {
    // Variables
    let apps = ["Calendar", "Contacts", "Files", "Health", "Maps", "Messages", "News", "Photos", "Reminders", "Safari", "Settings", "Wallet"]
    
    @State private var siriEnabled = true
    @State private var showingDisableSiriAlert = false
    @State private var showingDisableSiriPopup = false
    @State private var showingEnableSiriAlert = false
    @State private var showingEnableSiriPopup = false
    @State private var allowSiriWhenLockedEnabled = true
    
    @State private var showSuggestionsEnabled = true
    @State private var showingResetHiddenSuggestionsAlert = false
    @State private var showingResetHiddenSuggestionsPopup = false
    @State private var showRecentsEnabled = true
    
    @State private var showInLookUpEnabled = true
    @State private var showInSpotlightEnabled = true
    
    @State private var allowNotificationsEnabled = true
    @State private var showAppLibraryEnabled = true
    @State private var showWhenSharingEnabled = true
    @State private var showWhenListeningEnabled = true
    
    var body: some View {
        CustomList(title: "Siri") {
            SectionHelp(title: "Siri", icon: "applesiri", description: "Customize your Siri settings-choose how to activate Siri and what Siri can do, such as announce calls and notifications and automatically send messages. [Learn more...](#)")
            
            Section {
                CustomNavigationLink(title: "Language", status: "English (United States)", destination: SiriLanguageView())
                CustomNavigationLink(title: "Listen for", status: "Off", destination: EmptyView())
                Toggle("Allow Siri When Locked", isOn: $allowSiriWhenLockedEnabled)
                Toggle("Press \(DeviceInfo().isPhone ? "\(DeviceInfo().hasHomeButton ? "Home" : "Side") Button" : "Top Button") for Siri", isOn: $siriEnabled)
                    .alert("Turn Off Siri?", isPresented: $showingDisableSiriAlert) {
                        Button("Turn Off Siri") {}
                        Button("Cancel", role: .cancel) {}
                    } message: {
                        Text("The information Siri uses to respond to your requests will be removed from Apple servers. If you want to use Siri later, it will take some time to re-send this information.")
                    }
                    .alert("Enable Siri?", isPresented: $showingEnableSiriAlert) {
                        Button("Enable Siri") {}
                        Button("Cancel", role: .cancel) {}
                    } message: {
                        Text("Siri sends information like your voice input, contacts, and location to Apple to process your requests.")
                    }
                    .confirmationDialog("Turn Off Siri", isPresented: $showingDisableSiriPopup, titleVisibility: .visible) {
                        Button("Turn Off Siri") {}
                        Button("Cancel", role: .cancel) {}
                    } message: {
                        Text("The information Siri uses to respond to your requests will be removed from Apple servers. If you want to use Siri later, it will take some time to re-send this information.")
                    }
                    .confirmationDialog("Enable Siri", isPresented: $showingEnableSiriPopup, titleVisibility: .visible) {
                        Button("Enable Siri") {}
                        Button("Cancel", role: .cancel) {}
                    } message: {
                        Text("Siri sends information like your voice input, contacts, and location to Apple to process your requests.")
                    }
                    .onChange(of: siriEnabled) {
                        siriEnabled ? (DeviceInfo().isPhone ? showingEnableSiriPopup.toggle() : showingEnableSiriAlert.toggle()) : (DeviceInfo().isPhone ? showingDisableSiriPopup.toggle() : showingDisableSiriAlert.toggle())
                    }
                CustomNavigationLink(title: "Siri Voice", status: "American (Voice 4)", destination: SiriVoiceView())
                NavigationLink("Siri Responses", destination: SiriResponsesView())
                NavigationLink("Announce Calls", destination: EmptyView())
                NavigationLink("Announce Notifications", destination: EmptyView())
                Button(action: {}, label: { // TODO: Popover
                    HStack {
                        Text("My Information")
                            .foregroundStyle(Color["Label"])
                        Spacer()
                        Text("None")
                            .foregroundStyle(Color(UIColor.secondaryLabel))
                        Image(systemName: "chevron.right")
                            .foregroundStyle(Color(UIColor.tertiaryLabel))
                    }
                })
                NavigationLink("Messaging with Siri", destination: {
                    CustomList(title: "Messaging with Siri") {}
                })
            } header: {
                Text("Siri Requests")
            } footer: {
                Text("Voice input is processed on \(DeviceInfo().model), but transcripts of your requests are sent to Apple. [About Ask Siri & Privacy...](#)")
            }
            
            Section {
                Toggle("Suggest Apps Before Searching", isOn: $showSuggestionsEnabled)
                Button("Reset Hidden Suggestions", action: { DeviceInfo().isPhone ? showingResetHiddenSuggestionsAlert.toggle() : showingResetHiddenSuggestionsPopup.toggle() })
                    .alert("Reset", isPresented: $showingResetHiddenSuggestionsPopup) {
                        Button("Reset", role: .destructive) {}
                        Button("Cancel", role: .cancel) {}
                    } message: {
                        Text("Resetting will allow previously hidden suggestions to resume showing up again.")
                    }
                    .confirmationDialog("Resetting will allow previously hidden suggestions to resume showing up again.", isPresented: $showingResetHiddenSuggestionsAlert, titleVisibility: .visible) {
                        Button("Reset", role: .destructive) {}
                        Button("Cancel", role: .cancel) {}
                    }
                Toggle("Show Recents", isOn: $showRecentsEnabled)
                Toggle("Allow Notifications", isOn: $allowNotificationsEnabled)
                Toggle("Show in App Library", isOn: $showAppLibraryEnabled)
                Toggle("Show When Sharing", isOn: $showWhenSharingEnabled)
                Toggle("Show Listening Suggestions", isOn: $showWhenListeningEnabled)
            } header: {
                Text("Suggestions")
            } footer: {
                Text("Apple can make suggestions in Search, on Home Screen, and Lock Screen, when sharing, or when you may want to listen to media. [About Siri Suggestions, Search & Privacy...](#)")
            }
            
            Section {
                SettingsLink(color: .white, icon: "appclip", id: "App Clips") {
                    SiriAppClipsView()
                }
                SettingsLink(icon: "applehome screen & app library", id: "Apps") {
                    CustomList(title: "Apps") {
                        ForEach(apps, id: \.self) { app in
                            SettingsLink(icon: "apple\(app.lowercased())", id: app) {
                                SiriSearchDetailView(appName: app, title: app)
                            }
                        }
                        SettingsLink(icon: "apple watch", id: "Watch") {
                            SiriSearchDetailView(appName: "Watch", title: "Watch")
                        }
                    }
                }
            }
            
            Section {
                NavigationLink("Siri & Dictation History", destination: {})
            }
        }
    }
}

#Preview {
    NavigationStack {
        SiriView()
    }
}