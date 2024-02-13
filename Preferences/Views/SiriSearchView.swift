//
//  SiriSearchView.swift
//  Preferences
//
//  Settings > Siri & Search
//

import SwiftUI

struct SiriSearchView: View {
    // Variables
    @State private var siriEnabled = true
    @State private var showingDisableSiriAlert = false
    @State private var showSuggestionsEnabled = true
    @State private var showingResetHiddenSuggestionsAlert = false
    @State private var showRecentsEnabled = true
    
    @State private var showInLookUpEnabled = true
    @State private var showInSpotlightEnabled = true
    
    @State private var allowNotificationsEnabled = true
    @State private var showAppLibraryEnabled = true
    @State private var showWhenSharingEnabled = true
    @State private var showWhenListeningEnabled = true
    
    var body: some View {
        CustomList(title: "Siri & Search") {
            Section(content: {
                Toggle("Press \(DeviceInfo().isPhone ? "\(DeviceInfo().hasHomeButton ? "Home" : "Side") Button" : "Top Button") for Siri", isOn: $siriEnabled)
                NavigationLink(destination: {}, label: {
                    HRowLabels(title: "Language", subtitle: "English (United States)")
                })
                NavigationLink(destination: {}, label: {
                    HRowLabels(title: "Siri Voice", subtitle: "American (Voice 4)")
                })
                NavigationLink("Siri Responses", destination: {})
                Button(action: {}, label: { // TODO: Popover
                    HStack {
                        Text("My Information")
                            .foregroundStyle(Color(UIColor.label))
                        Spacer()
                        Text("None")
                            .foregroundStyle(Color(UIColor.secondaryLabel))
                        Image(systemName: "chevron.right")
                            .foregroundStyle(Color(UIColor.tertiaryLabel))
                    }
                })
                NavigationLink("Siri & Dictation History", destination: {})
                NavigationLink("Messaging with Siri", destination: {})
            }, header: {
                Text("Ask Siri")
            }, footer: {
                Text("Siri can help you get things done just by asking. [About Ask Siri & Privacy...](#)")
            })
            
            Section(content: {
                Toggle("Show Suggestions", isOn: $showSuggestionsEnabled)
                Button("Reset Hidden Suggestions", action: { showingResetHiddenSuggestionsAlert.toggle() })
                    .confirmationDialog("Resetting will allow previously hidden suggestions to resume showing up again.", isPresented: $showingResetHiddenSuggestionsAlert, titleVisibility: .visible) {
                        Button("Reset", role: .destructive) {}
                        Button("Cancel", role: .cancel) {}
                    }
                Toggle("Show Recents", isOn: $showRecentsEnabled)
            }, header: {
                Text("Before Searching")
            })
            
            Section(content: {
                Toggle("Show in Look Up", isOn: $showInLookUpEnabled)
                Toggle("Show in Spotlight", isOn: $showInSpotlightEnabled)
            }, header: {
                Text("Content from Apple")
            }, footer: {
                Text("Apple can show content when looking up text or objects in photos, or when searching. [About Siri Suggestions, Search & Privacy...](#)")
            })
            
            Section(content: {
                Toggle("Allow Notifications", isOn: $allowNotificationsEnabled)
                Toggle("Show in App Library", isOn: $showAppLibraryEnabled)
                Toggle("Show When Sharing", isOn: $showWhenSharingEnabled)
                Toggle("Show When Listening", isOn: $showWhenListeningEnabled)
            }, header: {
                Text("Suggestions from Apple")
            }, footer: {
                Text("Apple can make suggestions in apps, on Home Screen, and on Lock Screen, or when sharing, searching, or using Look Up, and Keyboard. [About Siri Suggestions, Search & Privacy...](#)")
            })
            
            Section {
                SettingsLink(icon: "appclip", id: "App Clips", content: {})
                SettingsLink(icon: "applecalendar", id: "Calendar", content: {})
                SettingsLink(icon: "applecontacts", id: "Contacts", content: {})
                SettingsLink(icon: "applefiles", id: "Files", content: {})
                SettingsLink(icon: "applehealth", id: "Health", content: {})
                SettingsLink(icon: "applemaps", id: "Maps", content: {})
                SettingsLink(icon: "applemessages", id: "Messages", content: {})
                SettingsLink(icon: "applenews", id: "News", content: {})
                SettingsLink(icon: "applephotos", id: "Photos", content: {})
                SettingsLink(icon: "applereminders", id: "Reminders", content: {})
                SettingsLink(icon: "applesafari", id: "Safari", content: {})
                SettingsLink(icon: "applesettings", id: "Settings", content: {})
                SettingsLink(icon: "appleshortcuts", id: "Shortcuts", content: {})
                SettingsLink(icon: "applewallet", id: "Wallet", content: {})
                SettingsLink(icon: "apple watch", id: "Watch", content: {})
            }
        }
    }
}

#Preview {
    NavigationStack {
        SiriSearchView()
    }
}
