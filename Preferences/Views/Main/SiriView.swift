//
//  SiriView.swift
//  Preferences
//
//  Settings > Siri
//

import SwiftUI
import TipKit

struct SiriView: View {
    // Variables
    @Environment(\.colorScheme) private var colorScheme
    let apps = ["Calendar", "Contacts", "Files", "Health", "Maps", "Messages", "News", "Photos", "Reminders", "Safari", "Settings", "Wallet", "Watch"]
    
    @State private var siriEnabled = false
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
    let gmTable = "AssistantSettings-GM"
    let exTable = "AssistantSettings-ExternalAIModel"
    
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
            Section {
                TipView(AppleIntelligenceTip())
                    .tipBackground(Color.background)
                    .task {
                        do {
                            try Tips.configure([
                                .displayFrequency(.immediate),
                                .datastoreLocation(.applicationDefault)
                            ])
                        }
                        catch {
                            print("Error initializing TipKit \(error.localizedDescription)")
                        }
                    }
                Button("Learn More") {}
                    .bold()
                    .padding(.leading, 70)
            }
            
            // MARK: Siri Requests Section
            Section {
                if !UIDevice.IsSimulator {
                    CustomNavigationLink(title: "ACTIVATION_COMPACT".localize(table: table), status: "ACTIVATION_OFF".localize(table: table), destination: EmptyView())
                }
                if !siriEnabled {
                    CustomNavigationLink(title: "VOICE".localize(table: table), status: "", destination: SiriVoiceView()) // \("REGION_en-US".localize(table: table)) (Voice 4)
                } else {
                    CustomNavigationLink(title: "LANGUAGE".localize(table: table), status: "English (United States)", destination: SiriLanguageView())
                }
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
                    Button {} label: {
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
//                NavigationLink("MESSAGE_TITLE".localize(table: table), destination: {
//                    CustomList(title: "MESSAGE_TITLE".localize(table: table)) {}
//                })
            } header: {
                Text("SIRI_REQUESTS", tableName: table)
            } footer: {
                Text(.init(UIDevice.IsSimulator ? "[\("SIRI_REQUESTS_ABOUT_LINK_TEXT".localize(table: table))](#)" : "\("SIRI_REQUESTS_DEVICE_PROCESSING_FOOTER_TEXT_IPHONE".localize(table: table))" + " [\("SIRI_REQUESTS_ABOUT_LINK_TEXT".localize(table: table))](#)"))
            }
            
            // MARK: Extensions Section
            if UIDevice.IntelligenceCapability {
                Section {
                    NavigationLink("EXTERNAL_AI_MODEL_NAME".localize(table: exTable)) {}
                } header: {
                    Text("EXTERNAL_AI_MODEL_GROUP", tableName: exTable)
                } footer: {
                    Text(UIDevice.iPhone ? "EXTERNAL_AI_MODEL_FOOTER_IPHONE" : "EXTERNAL_AI_MODEL_FOOTER_IPAD", tableName: exTable)
                }
            }
            
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
                SettingsLink(color: colorScheme == .dark ? .blue : .white, iconColor: .blue, icon: "appclip", id: "APP_CLIPS".localize(table: table)) {
                    SiriAppClipsView()
                }
                SettingsLink(color: .indigo, icon: "app.grid.3x3", id: "APPS_GROUP".localize(table: table)) {
                    CustomList(title: "APPS".localize(table: table)) {
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
                Text(UIDevice.IntelligenceCapability ? "ASSISTANT_AND_GM".localize(table: gmTable) : "ASSISTANT".localize(table: table))
                    .fontWeight(.semibold)
                    .font(.subheadline)
                    .opacity(frameY < 50.0 ? opacity : 0) // Only fade when passing the help section title at the top
            }
        }
    }
    
    // Discover Apple Intelligence Tip Struct
    struct AppleIntelligenceTip: Tip {
        var title: Text {
            Text("Discover Apple Intelligence")
        }
        
        var message: Text? {
            Text("Enhance your writing, express your creative side, and simplify your tasks.")
        }
        
        var image: Image? {
            Image(systemName: "apple.intelligence")
                .symbolRenderingMode(.multicolor)
                
        }
    }
}

#Preview {
    NavigationStack {
        SiriView()
    }
}
