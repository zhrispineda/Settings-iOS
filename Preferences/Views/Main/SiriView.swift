//
//  SiriView.swift
//  Preferences
//
//  Settings > Siri
//

import SwiftUI
import ContactsUI
import TipKit

struct SiriView: View {
    @AppStorage("SiriEnabled") private var siriEnabled = false
    @AppStorage("SiriTipDismissed") private var learnMoreTapped = false
    @State private var showingDisableSiriAlert = false
    @State private var showingDisableSiriPopup = false
    @State private var showingEnableSiriAlert = false
    @State private var showingEnableSiriPopup = false
    @State private var allowSiriWhenLockedEnabled = true
    @AppStorage("SiriMyInfoContact") private var myInfoContact = String()
    
    @AppStorage("SuggestAppsBeforeSearching") private var showSuggestionsEnabled = true
    @State private var showingResetHiddenSuggestionsAlert = false
    @State private var showingResetHiddenSuggestionsPopup = false
    
    @AppStorage("SuggestionsAllowNotifications") private var allowNotificationsEnabled = true
    @AppStorage("SuggestionsShowAppLibrary") private var showAppLibraryEnabled = true
    @AppStorage("SuggestionsShowWhenSharing") private var showWhenSharingEnabled = true
    @AppStorage("SuggestionsShowWhenListening") private var showWhenListeningEnabled = true
    
    @State private var opacity: Double = 0
    @State private var frameY: Double = 0
    @State private var siriPrivacySheet = false
    @State private var intelligencePrivacySheet = false

    let table = "AssistantSettings"
    let gmTable = "AssistantSettings-GM"
    let exTable = "AssistantSettings-ExternalAIModel"
    let contactPickerDelegate = ContactPickerDelegate()
    let apps = [
        AppInfo(name: "App Store", icon: "com.apple.AppStore", showOnSimulator: false),
        AppInfo(name: "Books", icon: "com.apple.iBooks", showOnSimulator: false),
        AppInfo(name: "Calendar", icon: "com.apple.mobilecal", showOnSimulator: true),
        AppInfo(name: "Contacts", icon: "com.apple.MobileAddressBook", showOnSimulator: true),
        AppInfo(name: "Files", icon: "com.apple.DocumentsApp", showOnSimulator: true),
        AppInfo(name: "Fitness", icon: "com.apple.Fitness", showOnSimulator: true),
        AppInfo(name: "Health", icon: "com.apple.Health", showOnSimulator: true),
        AppInfo(name: "Maps", icon: "com.apple.Maps", showOnSimulator: true),
        AppInfo(name: "Messages", icon: "com.apple.MobileSMS", showOnSimulator: true),
        AppInfo(name: "News", icon: "com.apple.news", showOnSimulator: true),
        AppInfo(name: "Passwords", icon: "com.apple.Passwords", showOnSimulator: true),
        AppInfo(name: "Photos", icon: "com.apple.mobileslideshow", showOnSimulator: true),
        AppInfo(name: "Reminders", icon: "com.apple.reminders", showOnSimulator: true),
        AppInfo(name: "Safari", icon: "com.apple.mobilesafari", showOnSimulator: true),
        AppInfo(name: "Shortcuts", icon: "com.apple.shortcuts", showOnSimulator: true),
        AppInfo(name: "Wallet", icon: "com.apple.Passbook", showOnSimulator: true),
        AppInfo(name: "Translate", icon: "com.apple.Translate", showOnSimulator: false)
    ]
    var groupedApps: [String: [AppInfo]] {
        let filteredApps = UIDevice.IsSimulated ? apps.filter { $0.showOnSimulator } : apps
        return Dictionary(grouping: filteredApps, by: { String($0.name.prefix(1)) })
    }

    var body: some View {
        CustomList {
            // MARK: Placard Section
            if UIDevice.IntelligenceCapability {
                Section {
                    Placard(title: "Apple Intelligence & Siri".localize(table: table), icon: "com.apple.application-icon.apple-intelligence", description: UIDevice.iPhone ? "PLACARD_DESCRIPTION_GM".localize(table: gmTable) : "PLACARD_DESCRIPTION_GM_IPAD".localize(table: gmTable), frameY: $frameY, opacity: $opacity)
                    if !UIDevice.IsSimulator {
                        Button("GM_TURN_ON_GM_BUTTON_TITLE".localize(table: gmTable)) {}
                    }
                } footer: {
                    if !UIDevice.IsSimulator {
                        Text(UIDevice.iPhone ? "GM_MODEL_TURN_ON_IPHONE" : "GM_MODEL_TURN_ON_IPAD", tableName: gmTable)
                    }
                }
            } else {
                Placard(title: "ASSISTANT".localize(table: table), icon: "com.apple.application-icon.siri", description: "PLACARD_DESCRIPTION".localize(table: table), frameY: $frameY, opacity: $opacity)
            }
            
            // MARK: Siri Requests Section
            Section {
                if siriEnabled {
                    SettingsLink("VOICE".localize(table: table), status: "", destination: SiriVoiceView()) // \("REGION_en-US".localize(table: table)) (Voice 4)
                } else {
                    SettingsLink("LANGUAGE".localize(table: table), status: "English (United States)", destination: SiriLanguageView())
                }
                if !UIDevice.IsSimulator {
                    SettingsLink("ACTIVATION_COMPACT".localize(table: table), status: "ACTIVATION_OFF".localize(table: table), destination: EmptyView())
                }
                if siriEnabled {
                    if !UIDevice.IsSimulator {
                        Toggle("ASSISTANT_LOCK_SCREEN_ACCESS".localize(table: table), isOn: $allowSiriWhenLockedEnabled)
                    }
                    SettingsLink("VOICE".localize(table: table), status: "\("REGION_en-US".localize(table: table)) (Voice 4)", destination: SiriVoiceView())
                    NavigationLink("VOICE_FEEDBACK".localize(table: table)) {
                        CustomViewController("/System/Library/PrivateFrameworks/AssistantSettingsSupport.framework/AssistantSettingsSupport", controller: "AssistantAudioFeedbackController")
                            .navigationTitle("VOICE_FEEDBACK".localize(table: table))
                    }
                    if UIDevice.IsSimulator {
                        NavigationLink("ANNOUNCE_CALLS_TITLE".localize(table: table), destination: EmptyView())
                        NavigationLink("ANNOUNCE_MESSAGES_TITLE".localize(table: table), destination: EmptyView())
                    }
                    // My Information
                    Button {
                        openContactPicker()
                    } label: {
                        HStack {
                            Text("MyInfo", tableName: table)
                            Spacer()
                            Text(myInfoContact.isEmpty ? "None".localize(table: table) : myInfoContact)
                                .foregroundStyle(Color(UIColor.secondaryLabel))
                            Image(systemName: "chevron.right")
                                .foregroundStyle(Color(UIColor.tertiaryLabel))
                        }
                    }
                    .foregroundStyle(.primary)
                }
                NavigationLink("ASSISTANT_HISTORY_LABEL".localize(table: table)) {
                    BundleControllerView("/System/Library/PrivateFrameworks/AssistantSettingsSupport.framework/AssistantSettingsSupport", controller: "AssistantHistoryViewController", title: "ASSISTANT_HISTORY_LABEL", table: table)
                }
//                NavigationLink("MESSAGE_TITLE".localize(table: table), destination: {
//                    CustomList(title: "MESSAGE_TITLE".localize(table: table)) {}
//                })
            } header: {
                Text("SIRI_REQUESTS", tableName: table)
            } footer: {
                Text(.init(UIDevice.IsSimulator ? "[\("SIRI_REQUESTS_ABOUT_LINK_TEXT".localize(table: table))](pref://siri)" : "\("SIRI_REQUESTS_DEVICE_PROCESSING_FOOTER_TEXT_IPHONE".localize(table: table))" + " [\("SIRI_REQUESTS_ABOUT_LINK_TEXT".localize(table: table))](pref://siri)"))
            }
            
            // MARK: Extensions Section
//            if UIDevice.IntelligenceCapability {
//                Section {
//                    NavigationLink("EXTERNAL_AI_MODEL_NAME".localize(table: exTable)) {}
//                } header: {
//                    Text("EXTERNAL_AI_MODEL_GROUP", tableName: exTable)
//                } footer: {
//                    Text(UIDevice.iPhone ? "EXTERNAL_AI_MODEL_FOOTER_IPHONE" : "EXTERNAL_AI_MODEL_FOOTER_IPAD", tableName: exTable)
//                }
//            }
            
            // MARK: Suggestions Section
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
            
            // MARK: Apple Intelligence and Siri App Access Section
            Section {
                SLink("APP_CLIPS".localize(table: table), icon: "com.apple.graphic-icon.app-clips") {
                    BundleControllerView("/System/Library/PrivateFrameworks/AssistantSettingsSupport.framework/AssistantSettingsSupport", controller: "AssistantAppClipSettingsController", title: "APP_CLIPS", table: table)
                }
                SLink("APPS_GROUP".localize(table: table), icon: "com.apple.graphic-icon.home-screen") {
                    CustomList(title: "APPS".localize(table: table)) {
                        ForEach(groupedApps.keys.sorted(), id: \.self) { key in
                            ForEach(groupedApps[key]!, id: \.name) { app in
                                SLink(app.name, icon: app.icon) {
                                    SiriDetailView(appName: app.name, title: app.name)
                                }
                            }
                        }
                    }
                }
            } header: {
                Text(UIDevice.IntelligenceCapability ? "GM_APP_ACCESS_GROUP" : "APP_ACCESS_GROUP", tableName: UIDevice.IntelligenceCapability ? gmTable : table)
            } footer: {
                if UIDevice.IntelligenceCapability {
                    Text("\("GM_PRIVACY_FOOTER_TEXT".localize(table: gmTable)) [\("GM_PRIVACY_FOOTER_LINK_TEXT".localize(table: gmTable))](pref://intelligence)")
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(UIDevice.IntelligenceCapability ? "ASSISTANT_AND_GM".localize(table: gmTable) : "ASSISTANT".localize(table: table))
                    .fontWeight(.semibold)
                    .font(.subheadline)
                    .opacity(frameY < 50.0 ? opacity : 0)
            }
        }
        .onOpenURL { url in
            if url.absoluteString == "pref://siri" {
                siriPrivacySheet.toggle()
            } else if url.absoluteString == "pref://intelligence" {
                intelligencePrivacySheet.toggle()
            }
        }
        .sheet(isPresented: $siriPrivacySheet) {
            OnBoardingKitView(bundleID: "com.apple.onboarding.siri")
                .ignoresSafeArea()
        }
        .sheet(isPresented: $intelligencePrivacySheet) {
            OnBoardingKitView(bundleID: "com.apple.onboarding.intelligenceengine")
                .ignoresSafeArea()
        }
    }

    func openContactPicker() {
        let controller = CNContactPickerViewController()
        
        controller.delegate = contactPickerDelegate
        contactPickerDelegate.onSelectContact = { contact in
            myInfoContact = "\(contact.givenName) \(contact.familyName)"
        }
        
        UIWindow.controller.present(controller, animated: true)
    }
}

class ContactPickerDelegate: NSObject, CNContactPickerDelegate {
    var onSelectContact: ((CNContact) -> Void) = { _ in }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        onSelectContact(contact)
    }
}

struct SiriRoute: @preconcurrency Routable {
    @MainActor func destination() -> AnyView {
        AnyView(SiriView())
    }
}

#Preview {
    NavigationStack {
        SiriView()
    }
}
