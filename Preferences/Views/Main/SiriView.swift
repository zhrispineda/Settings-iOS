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
    @Environment(\.colorScheme) private var colorScheme
    let apps = ["Calendar", "Contacts", "Files", "Health", "Maps", "Messages", "News", "Photos", "Reminders", "Safari", "Settings", "Wallet", "Watch"]
    
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
    
    let table = "AssistantSettings"
    let gmTable = "AssistantSettings-GM"
    let exTable = "AssistantSettings-ExternalAIModel"
    let contactPickerDelegate = ContactPickerDelegate()
    
    init() {
        try? Tips.configure()
    }
    
    var body: some View {
        CustomList {
            // MARK: Placard Section
            if UIDevice.IntelligenceCapability {
                Section {
                    Placard(title: "Apple Intelligence & Siri".localize(table: table), icon: "appleIntelligence", description: UIDevice.iPhone ? "PLACARD_DESCRIPTION_GM".localize(table: gmTable) : "PLACARD_DESCRIPTION_GM_IPAD".localize(table: gmTable), frameY: $frameY, opacity: $opacity)
                    if !UIDevice.IsSimulator {
                        Button("GM_WAITLIST_SPECIFIER_TITLE".localize(table: gmTable)) {}
                    }
                } footer: {
                    if !UIDevice.IsSimulator {
                        Text("GM_MODEL_NOT_YET_QUEUED", tableName: gmTable)
                    }
                }
            } else {
                Placard(title: "ASSISTANT".localize(table: table), icon: "appleSiri", description: "PLACARD_DESCRIPTION".localize(table: table), frameY: $frameY, opacity: $opacity)
            }
            
            // MARK: TipKit Section
            if !learnMoreTapped {
                Section {
                    AppleIntelligenceTipView()
                        .onTapGesture {
                            learnMoreTapped = true
                        }
                }
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
                if !siriEnabled {
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
                Text(.init(UIDevice.IsSimulator ? "[\("SIRI_REQUESTS_ABOUT_LINK_TEXT".localize(table: table))](#)" : "\("SIRI_REQUESTS_DEVICE_PROCESSING_FOOTER_TEXT_IPHONE".localize(table: table))" + " [\("SIRI_REQUESTS_ABOUT_LINK_TEXT".localize(table: table))](#)"))
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
                SLink("APP_CLIPS".localize(table: table), color: colorScheme == .dark ? .blue : .white, iconColor: .blue, icon: "appclip") {
                    BundleControllerView("/System/Library/PrivateFrameworks/AssistantSettingsSupport.framework/AssistantSettingsSupport", controller: "AssistantAppClipSettingsController", title: "APP_CLIPS", table: table)
                }
                SLink("APPS_GROUP".localize(table: table), color: .indigo, icon: "app.grid.3x3") {
                    CustomList(title: "APPS".localize(table: table)) {
                        ForEach(apps, id: \.self) { app in
                            SLink(app, icon: "apple\(app)") {
                                SiriDetailView(appName: app, title: app)
                            }
                        }
                    }
                }
            } header: {
                Text(UIDevice.IntelligenceCapability ? "GM_APP_ACCESS_GROUP" : "APP_ACCESS_GROUP", tableName: UIDevice.IntelligenceCapability ? gmTable : table)
            }
            
            // MARK: Apple Intelligence Privacy Footer
            Section {} footer: {
                if UIDevice.IntelligenceCapability {
                    Text("\("GM_PRIVACY_FOOTER_TEXT".localize(table: gmTable)) [\("GM_PRIVACY_FOOTER_LINK_TEXT".localize(table: gmTable))](#)")
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
