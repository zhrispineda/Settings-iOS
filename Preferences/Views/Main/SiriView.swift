//
//  SiriView.swift
//  Preferences
//
//  Settings > [Apple Intelligence & Siri/Siri]
//

import SwiftUI
import ContactsUI

struct SiriView: View {
    @AppStorage("SiriEnabled") private var siriEnabled = false
    @AppStorage("SiriTipDismissed") private var learnMoreTapped = false
    @State private var showingDisableSiriAlert = false
    @State private var showingDisableSiriPopup = false
    @State private var showingEnableSiriAlert = false
    @State private var showingEnableSiriPopup = false
    @State private var allowSiriWhenLockedEnabled = true
    @AppStorage("SiriMyInfoContact") private var myInfoContact = ""
    
    @AppStorage("SuggestAppsBeforeSearching") private var showSuggestionsEnabled = true
    @State private var showingResetHiddenSuggestionsAlert = false
    @State private var showingResetHiddenSuggestionsPopup = false
    
    @AppStorage("SuggestionsAllowNotifications") private var allowNotificationsEnabled = true
    @AppStorage("SuggestionsShowAppLibrary") private var showAppLibraryEnabled = true
    @AppStorage("SuggestionsShowWhenSharing") private var showWhenSharingEnabled = true
    @AppStorage("SuggestionsShowWhenListening") private var showWhenListeningEnabled = true
    
    @State private var titleVisible = false
    @State private var siriPrivacySheet = false
    @State private var intelligencePrivacySheet = false
    @State private var showingSiriHelpSheet = false
    @State private var showingIntelligenceHelpSheet = false
    
    let path = "/System/Library/PrivateFrameworks/AssistantSettingsSupport.framework"
    let table = "AssistantSettings"
    let gmTable = "AssistantSettings-GM"
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
    var title: String {
        return UIDevice.IntelligenceCapability
        ? "ASSISTANT_AND_GM".localized(path: path, table: gmTable)
        : "ASSISTANT".localized(path: path, table: table)
    }
    var groupedApps: [String: [AppInfo]] {
        let filteredApps = UIDevice.IsSimulated ? apps.filter { $0.showOnSimulator } : apps
        return Dictionary(grouping: filteredApps, by: { String($0.name.prefix(1)) })
    }
    private var privacyFooter: String {
        UIDevice.iPhone
            ? "SIRI_REQUESTS_DEVICE_PROCESSING_FOOTER_TEXT_IPHONE".localized(path: path, table: table)
            : "SIRI_REQUESTS_DEVICE_PROCESSING_FOOTER_TEXT_IPAD".localized(path: path, table: table)
    }
    
    var body: some View {
        CustomList(title: titleVisible ? title : "") {
            // MARK: Placard Section
            if UIDevice.IntelligenceCapability {
                Section {
                    Placard(
                        title: "ASSISTANT_AND_GM".localized(path: path, table: gmTable),
                        icon: "com.apple.application-icon.apple-intelligence",
                        description: UIDevice.iPhone
                        ? "PLACARD_DESCRIPTION_GM".localized(path: path, table: gmTable).replacing("]", with: "](pref://helpkit)")
                        : "PLACARD_DESCRIPTION_GM_IPAD".localized(path: path, table: gmTable).replacing("]", with: "](pref://helpkit)"),
                        beta: true,
                        isVisible: $titleVisible
                    )
                    if !UIDevice.IsSimulator {
                        Button("GM_TURN_ON_GM_BUTTON_TITLE".localized(path: path, table: gmTable)) {}
                    }
                } footer: {
                    if !UIDevice.IsSimulator {
                        Text(UIDevice.iPhone ? "GM_MODEL_TURN_ON_IPHONE".localized(path: path, table: gmTable) : "GM_MODEL_TURN_ON_IPAD".localized(path: path, table: gmTable))
                    }
                }
            } else {
                Placard(
                    title: "ASSISTANT".localized(path: path, table: table),
                    icon: "com.apple.application-icon.siri",
                    description: "PLACARD_DESCRIPTION".localized(path: path, table: table).replacing("]", with: "](pref://helpkit)"),
                    isVisible: $titleVisible
                )
            }
            
            // MARK: Siri Requests Section
            Section {
                if siriEnabled {
                    SettingsLink("VOICE".localized(path: path, table: table), status: "", destination: SiriVoiceView())
                } else {
                    SettingsLink("LANGUAGE".localized(path: path, table: table), status: "English (United States)", destination: SiriLanguageView())
                }
                if !UIDevice.IsSimulator {
                    SettingsLink("ACTIVATION_COMPACT".localized(path: path, table: table), status: "ACTIVATION_OFF".localized(path: path, table: table), destination: EmptyView())
                }
                SettingsLink("VOICE".localized(path: path, table: table), status: "\("REGION_en-US".localized(path: path, table: table)) (Voice 4)", destination: SiriVoiceView())
                if siriEnabled {
                    if !UIDevice.IsSimulator {
                        Toggle("ASSISTANT_LOCK_SCREEN_ACCESS".localized(path: path, table: table), isOn: $allowSiriWhenLockedEnabled)
                    }
                    NavigationLink("VOICE_FEEDBACK".localized(path: path, table: table)) {
                        CustomViewController(
                            "/System/Library/PrivateFrameworks/AssistantSettingsSupport.framework/AssistantSettingsSupport",
                            controller: "AssistantAudioFeedbackController"
                        )
                        .navigationTitle("VOICE_FEEDBACK".localized(path: path, table: table))
                    }
                    if UIDevice.IsSimulator {
                        NavigationLink("ANNOUNCE_CALLS_TITLE".localized(path: path, table: table), destination: EmptyView())
                        NavigationLink("ANNOUNCE_MESSAGES_TITLE".localized(path: path, table: table), destination: EmptyView())
                    }
                    // My Information
                    Button {
                        openContactPicker()
                    } label: {
                        HStack {
                            Text("MyInfo".localized(path: path, table: table))
                            Spacer()
                            Text(myInfoContact.isEmpty ? "None".localized(path: path, table: table) : myInfoContact)
                                .foregroundStyle(Color(UIColor.secondaryLabel))
                            Image(systemName: "chevron.right")
                                .foregroundStyle(Color(UIColor.tertiaryLabel))
                        }
                    }
                    .foregroundStyle(.primary)
                }
                NavigationLink("ASSISTANT_HISTORY_LABEL".localized(path: path, table: table)) {
                    ControllerBridgeView(
                        "/System/Library/PrivateFrameworks/AssistantSettingsSupport.framework/AssistantSettingsSupport",
                        controller: "AssistantHistoryViewController",
                        title: "ASSISTANT_HISTORY_LABEL".localized(path: path, table: table)
                    )
                }
            } header: {
                Text("SIRI_REQUESTS".localized(path: path, table: table))
            } footer: {
                PSFooterHyperlinkView(
                    footerText: "\(privacyFooter) \("SIRI_REQUESTS_ABOUT_LINK_TEXT".localized(path: path, table: table))",
                    linkText: "SIRI_REQUESTS_ABOUT_LINK_TEXT".localized(path: path, table: table),
                    onLinkTap: {
                        siriPrivacySheet = true
                    }
                )
            }
            
            // MARK: Suggestions Section
            Section {
                Toggle("SUGGESTIONS_SHOW_BEFORE_SEARCHING".localized(path: path, table: table), isOn: $showSuggestionsEnabled)
                Button("SUGGESTIONS_RESET_HIDDEN_NAME".localized(path: path, table: table)) {
                    UIDevice.iPhone ? showingResetHiddenSuggestionsAlert.toggle() : showingResetHiddenSuggestionsPopup.toggle()
                }
                .alert("SUGGESTIONS_RESET_HIDDEN_TITLE".localized(path: path, table: table), isPresented: $showingResetHiddenSuggestionsPopup) {
                    Button("SUGGESTIONS_RESET_HIDDEN_TITLE".localized(path: path, table: table), role: .destructive) {}
                    Button("SUGGESTIONS_RESET_HIDDEN_CANCEL".localized(path: path, table: table), role: .cancel) {}
                } message: {
                    Text("SUGGESTIONS_RESET_HIDDEN_PROMPT".localized(path: path, table: table))
                }
                .confirmationDialog("SUGGESTIONS_RESET_HIDDEN_PROMPT".localized(path: path, table: table), isPresented: $showingResetHiddenSuggestionsAlert, titleVisibility: .visible) {
                    Button("SUGGESTIONS_RESET_HIDDEN_TITLE".localized(path: path, table: table), role: .destructive) {}
                    Button("SUGGESTIONS_RESET_HIDDEN_CANCEL".localized(path: path, table: table), role: .cancel) {}
                }
                Toggle("SUGGESTIONS_ALLOW_NOTIFICATIONS".localized(path: path, table: table), isOn: $allowNotificationsEnabled)
                Toggle("SUGGESTIONS_SHOW_IN_APPLIBRARY".localized(path: path, table: table), isOn: $showAppLibraryEnabled)
                Toggle("SUGGESTIONS_SHOW_WHEN_SHARING".localized(path: path, table: table), isOn: $showWhenSharingEnabled)
                Toggle("SUGGESTIONS_SHOW_WHEN_LISTENING".localized(path: path, table: table), isOn: $showWhenListeningEnabled)
            } header: {
                Text("SUGGESTIONS_GROUP".localized(path: path, table: table))
            } footer: {
                Text("SUGGESTIONS_FOOTER".localized(path: path, table: table))
            }
            
            // MARK: Apple Intelligence and Siri App Access Section
            Section {
                SLink(
                    "APP_CLIPS".localized(path: path, table: table),
                    icon: "com.apple.graphic-icon.app-clips",
                    destination: ControllerBridgeView(
                        "/System/Library/PrivateFrameworks/AssistantSettingsSupport.framework/AssistantSettingsSupport",
                        controller: "AssistantAppClipSettingsController",
                        title: "APP_CLIPS".localized(path: path, table: table)
                    )
                )
                SLink("APPS_GROUP".localized(path: path, table: table), icon: "com.apple.graphic-icon.home-screen") {
                    CustomList(title: "APPS".localized(path: path, table: table)) {
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
                Text(UIDevice.IntelligenceCapability ? "GM_APP_ACCESS_GROUP".localized(path: path, table: gmTable) : "APP_ACCESS_GROUP".localized(path: path, table: table))
            } footer: {
                if UIDevice.IntelligenceCapability {
                    PSFooterHyperlinkView(
                        footerText: "\("GM_PRIVACY_FOOTER_TEXT".localized(path: path, table: gmTable)) \("GM_PRIVACY_FOOTER_LINK_TEXT".localized(path: path, table: gmTable))",
                        linkText: "GM_PRIVACY_FOOTER_LINK_TEXT".localized(path: path, table: gmTable),
                        onLinkTap: {
                            intelligencePrivacySheet = true
                        }
                    )
                }
            }
        }
        .onOpenURL { url in
            if url.absoluteString == "pref://helpkit" {
                if UIDevice.IntelligenceCapability {
                    showingIntelligenceHelpSheet.toggle()
                } else {
                    showingSiriHelpSheet.toggle()
                }
            }
        }
        .sheet(isPresented: $siriPrivacySheet) {
            OBPrivacySplashController(bundleID: "com.apple.onboarding.siri")
                .ignoresSafeArea()
        }
        .sheet(isPresented: $intelligencePrivacySheet) {
            OBPrivacySplashController(bundleID: "com.apple.onboarding.intelligenceengine")
                .ignoresSafeArea()
        }
        .sheet(isPresented: $showingSiriHelpSheet) {
            HLPHelpViewController(topicID: UIDevice.iPhone ? "ipha48873ed6" : "ipadf4e2ae5b")
                .ignoresSafeArea(edges: .bottom)
                .interactiveDismissDisabled()
        }
        .sheet(isPresented: $showingIntelligenceHelpSheet) {
            HLPHelpViewController(topicID: UIDevice.iPhone ? "iphc28624b81" : "ipade5045bb1")
                .ignoresSafeArea(edges: .bottom)
                .interactiveDismissDisabled()
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

#Preview {
    NavigationStack {
        SiriView()
    }
}
