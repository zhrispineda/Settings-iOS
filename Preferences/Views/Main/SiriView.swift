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
    
    var body: some View {
        CustomList {
            SectionHelp(title: "Siri", icon: "appleSiri", description: "Siri is an intelligent assistant that helps you find information and get things done. [Learn more...](#)")
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
                CustomNavigationLink(title: "Language", status: "English (United States)", destination: SiriLanguageView())
                if !siriEnabled {
                    CustomNavigationLink(title: "Voice", status: "American (Voice 4)", destination: SiriVoiceView())
                }
                if !UIDevice.IsSimulator {
                    CustomNavigationLink(title: "Talk to Siri", status: "Off", destination: EmptyView())
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
                        Toggle("Allow Siri When Locked", isOn: $allowSiriWhenLockedEnabled)
                    }
                    CustomNavigationLink(title: "Voice", status: "American (Voice 4)", destination: SiriVoiceView())
                    NavigationLink("Siri Responses", destination: SiriResponsesView())
                    if !UIDevice.IsSimulator {
                        NavigationLink("Announce Calls", destination: EmptyView())
                        NavigationLink("Announce Notifications", destination: EmptyView())
                    }
                    Button {} label: { // TODO: Popover
                        HStack {
                            Text("My Information")
                                .foregroundStyle(Color["Label"])
                            Spacer()
                            Text("None")
                                .foregroundStyle(Color(UIColor.secondaryLabel))
                            Image(systemName: "chevron.right")
                                .foregroundStyle(Color(UIColor.tertiaryLabel))
                        }
                    }
                }
                NavigationLink("Siri & Dictation History") {}
                NavigationLink("Messaging with Siri", destination: {
                    CustomList(title: "Messaging with Siri") {}
                })
            } header: {
                Text("Siri Requests")
            } footer: {
                Text(UIDevice.IsSimulator ? "[About Siri & Privacy...](#)" : "Voice input is processed on \(UIDevice.current.model), but transcripts of your requests are sent to Apple. [About Siri & Privacy...](#)")
//                Text(siriEnabled ? "Voice input is processed on \(UIDevice.current.model), but transcripts of your requests are sent to Apple. [About Siri & Privacy...](#)" : "Siri can help you get things done just by asking. [About Siri & Privacy...](#)")
            }
            
            Section {
                Toggle("Suggest Apps Before Searching", isOn: $showSuggestionsEnabled)
                Button("Reset Hidden Suggestions") { UIDevice.iPhone ? showingResetHiddenSuggestionsAlert.toggle() : showingResetHiddenSuggestionsPopup.toggle() }
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
                Toggle("Allow Notifications", isOn: $allowNotificationsEnabled)
                Toggle("Show in App Library", isOn: $showAppLibraryEnabled)
                Toggle("Show When Sharing", isOn: $showWhenSharingEnabled)
                Toggle("Show Listening Suggestions", isOn: $showWhenListeningEnabled)
            } header: {
                Text("Suggestions")
            } footer: {
                Text("Apple can make suggestions in Search, on Home Screen and Lock Screen, when sharing, or when you may want to listen to media.")
            }
            
            Section {
                SettingsLink(color: .white, iconColor: .blue, icon: "appclip", id: "App Clips") {
                    SiriAppClipsView()
                }
                SettingsLink(icon: "appleHome Screen & App Library", id: "Apps") {
                    CustomList(title: "Apps") {
                        ForEach(apps, id: \.self) { app in
                            SettingsLink(icon: "apple\(app)", id: app) {
                                SiriDetailView(appName: app, title: app)
                            }
                        }
                    }
                }
            } header: {
                Text("Siri App Access")
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Siri")
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
