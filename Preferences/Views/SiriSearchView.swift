//
//  SiriSearchView.swift
//  Preferences
//
//  Settings > Siri & Search
//

import SwiftUI

struct SiriSearchView: View {
    // Variables
    let apps = ["Calendar", "Contacts", "Files", "Health", "Maps", "Messages", "News", "Photos", "Reminders", "Safari", "Settings", "Wallet"]
    
    @State private var siriEnabled = true
    @State private var showingDisableSiriAlert = false
    @State private var showingDisableSiriPopup = false
    @State private var showingEnableSiriAlert = false
    @State private var showingEnableSiriPopup = false
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
        CustomList(title: "Siri & Search") {
            Section {
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
                CustomNavigationLink(title: "Language", status: "English (United States)", destination: SiriLanguageView())
                CustomNavigationLink(title: "Siri Voice", status: "American (Voice 4)", destination: SiriVoiceView())
                NavigationLink("Siri Responses", destination: SiriResponsesView())
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
                NavigationLink("Siri & Dictation History", destination: SiriDictationHistoryView())
                NavigationLink("Messaging with Siri", destination: {
                    CustomList(title: "Messaging with Siri") {}
                })
            } header: {
                Text("Ask Siri")
            } footer: {
                Text("Siri can help you get things done just by asking. [About Ask Siri & Privacy...](#)")
            }
            
            Section {
                Toggle("Show Suggestions", isOn: $showSuggestionsEnabled)
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
            } header: {
                Text("Before Searching")
            }
            
            Section {
                Toggle("Show in Look Up", isOn: $showInLookUpEnabled)
                Toggle("Show in Spotlight", isOn: $showInSpotlightEnabled)
            } header: {
                Text("Content from Apple")
            } footer: {
                Text("Apple can show content when looking up text or objects in photos, or when searching. [About Siri Suggestions, Search & Privacy...](#)")
            }
            
            Section {
                Toggle("Allow Notifications", isOn: $allowNotificationsEnabled)
                Toggle("Show in App Library", isOn: $showAppLibraryEnabled)
                Toggle("Show When Sharing", isOn: $showWhenSharingEnabled)
                Toggle("Show When Listening", isOn: $showWhenListeningEnabled)
            } header: {
                Text("Suggestions from Apple")
            } footer: {
                Text("Apple can make suggestions in apps, on Home Screen, and on Lock Screen, or when sharing, searching, or using Look Up, and Keyboard. [About Siri Suggestions, Search & Privacy...](#)")
            }
            
            Section {
                SettingsLink(color: .white, icon: "appclip", id: "App Clips") {
                    SiriAppClipsView()
                }
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
}

#Preview {
    NavigationStack {
        SiriSearchView()
    }
}
