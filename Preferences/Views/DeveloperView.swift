//
//  DeveloperView.swift
//  Preferences
//
//  Settings > Developer
//

import SwiftUI

struct DeveloperView: View {
    // Variables
    @State private var darkAppearanceEnabled = false
    @State private var showingDisplayZoomSheet = false
    @State private var uiAutomationEnabled = false
    @State private var fastAppTerminationEnabled = false
    
    @State private var additionalLoggingEnabled = false
    @State private var allowHttpServicesEnabled = false
    @State private var disableRateLimitingEnabled = false
    @State private var nfcPassKeyOptionalEnabled = false
    
    @State private var resetLocalDataNextLaunch = false
    
    @State private var widgetKitDeveloperModeEnabled = false
    
    @State private var displayRecentShortcutsEnabled = false
    
    @State private var displayUpcomingMediaEnabled = false
    
    @State private var displayDonationsLockScreenEnabled = false
    
    @State private var allowAnyDomainsEnabled = false
    @State private var allowUnverifiedSources = false
    
    @State private var enableMidiCi = false
    
    @State private var showGraphicsHudEnabled = false
    @State private var logGraphicsPerformanceEnabled = false
    
    @State private var hidLoggingEnabled = false
    @State private var heartRateLogging = false
    @State private var showAudioOutput = false
    let table = "DTSettings"
    
    var body: some View {
        CustomList(title: "DEVELOPER".localize(table: table), topPadding: true) {
            if UIDevice.IsSimulator {
                // Appearance
                Section {
                    Toggle("APPEARANCE_DARK".localize(table: table), isOn: $darkAppearanceEnabled)
                } header: {
                    Text("APPEARANCE", tableName: table)
                }
            }
            
            if UIDevice.IsSimulator && UIDevice.iPhone || (UIDevice.iPad && UIDevice.ProDevice) {
                // Display Zoom
                Section {
                    if UIDevice.iPhone {
                        CustomNavigationLink("VIEW".localize(table: table), status: "Default", destination: DisplayZoomView())
                    } else {
                        Button {
                            showingDisplayZoomSheet.toggle()
                        } label: {
                            LabeledContent("VIEW".localize(table: table), value: "Default")
                        }
                        .foregroundStyle(Color["Label"])
                        .sheet(isPresented: $showingDisplayZoomSheet) {
                            NavigationStack {
                                DisplayZoomView(options: UIDevice.LargerSize ? ["Larger Text", "Default", "More Space"] : ["Default", "More Space"])
                            }
                        }
                    }
                } header: {
                    Text("DISPLAY_ZOOM", tableName: table)
                } footer: {
                    Text("DISPLAY_ZOOM_DESCRIPTION", tableName: table)
                }
            }
            
            // Paired Devices
            Section {
                Button("CLEAR_TRUSTED_COMPUTERS".localize(table: table)) {}
            } header: {
                Text("PAIRED_DEVICES", tableName: table)
            } footer: {
                Text("PAIRED_DEVICES_FOOTER", tableName: table)
            }
            
            // UI Automation
            Section("UI_AUTOMATION".localize(table: table)) {
                Toggle("ENABLE_UI_AUTOMATION".localize(table: table), isOn: $uiAutomationEnabled)
            }
            
            if !UIDevice.IsSimulator {
                // Performance
                Section {
                    //CustomNavigationLink("Hang Detection", status: "Off") {}
                    //CustomNavigationLink("Hang Detection", status: "Off") {}
                } header: {
                    Text("PERFORMANCE_GROUP", tableName: table)
                }
            }
            
            Section {
                Toggle("FAST_APP_TERMINATION".localize(table: table), isOn: $fastAppTerminationEnabled)
            } header: {
                Text("STATE_RESTORATION_TESTING", tableName: table)
            } footer: {
                Text("STATE_RESTORATION_TESTING_FOOTER", tableName: table)
            }
            
            if UIDevice.iPhone { // MARK: Wallet Testing
                Section("WALLET_TESTING".localize(table: table)) {
                    Toggle("ADDITIONAL_LOGGING".localize(table: table), isOn: $additionalLoggingEnabled)
                    Toggle("ALLOW_HTTP_SERVICES".localize(table: table), isOn: $allowHttpServicesEnabled)
                    Toggle("DISABLE_RATE_LIMITING".localize(table: table), isOn: $disableRateLimitingEnabled)
                    Toggle("NFC_PASS_KEY_OPTIONAL".localize(table: table), isOn: $nfcPassKeyOptionalEnabled)
                }
            }
            
            Section("MEDIA_SERVICES_TESTING".localize(table: table)) {
                Button("RESET_MEDIA_SERVICES".localize(table: table)) {}
            }
            
            Section {
                Toggle("RESET_LOCAL_DATA_ON_NEXT_LAUNCH".localize(table: table), isOn: $resetLocalDataNextLaunch)
            } header: {
                Text("NEWS_TESTING", tableName: table)
            } footer: {
                Text("NEWS_TESTING_FOOTER", tableName: table)
            }
            
            Section("TV_PROVIDER_TESTING".localize(table: table)) {
                NavigationLink("TV_PROVIDERS".localize(table: table), destination: DTVProviderView())
            }
            
            Section {
                NavigationLink("TV_APP".localize(table: table), destination: TVAppView())
            } header: {
                Text("TV_APP_TESTING", tableName: table)
            }
            
            Section("CORESPOTLIGHT_TESTING".localize(table: table)) {
                Button("REINDEX_ALL_ITEMS".localize(table: table)) {}
                Button("REINDEX_ALL_ITEMS_WITH_IDENTIFIERS".localize(table: table)) {}
            }
            
            Section {
                Toggle("WIDGETKIT_DEVELOPER_MODE_ENABLED".localize(table: table), isOn: $widgetKitDeveloperModeEnabled)
            } header: {
                Text("WIDGETKIT_DEVELOPER_MODE_ENABLED", tableName: table)
            } footer: {
                Text("WIDGET_TESTING_FOOTER", tableName: table)
            }
            
            Section {
                Toggle("DISPLAY_DONATIONS_SPOTLIGHT".localize(table: table), isOn: $displayRecentShortcutsEnabled)
            } header: {
                Text("SIRI_ACTIONS_TESTING", tableName: table)
            } footer: {
                Text("SIRI_ACTIONS_FOOTER_SPOTLIGHT", tableName: table)
            }
            
            Section {
                Toggle("DISPLAY_UPCOMING_MEDIA".localize(table: table), isOn: $displayUpcomingMediaEnabled)
            } footer: {
                Text("SIRI_ACTIONS_FOOTER_UPCOMING_MEDIA", tableName: table)
            }
            
            Section {
                Toggle("DISPLAY_DONATIONS_LOCKSCREEN".localize(table: table), isOn: $displayDonationsLockScreenEnabled)
            } footer: {
                Text("SIRI_ACTIONS_FOOTER_LOCKSCREEN", tableName: table)
            }
            
            Section {
                Button("SIRI_ACTIONS_SYNC_WATCHOS".localize(table: table)) {}
            } footer: {
                Text("SIRI_ACTIONS_FOOTER_SYNC_WATCHOS", tableName: table)
            }
            
            Section {
                Toggle("SIRI_EVENT_SUGGESTIONS_TESTING_ALLOW_ANY_DOMAIN".localize(table: table), isOn: $allowAnyDomainsEnabled)
                Toggle("SIRI_EVENT_SUGGESTIONS_TESTING_ALLOW_UNVERIFIED_DOCUMENTS".localize(table: table), isOn: $allowUnverifiedSources)
            } header: {
                Text("SIRI_EVENT_SUGGESTIONS_TESTING_HEADER", tableName: table)
            } footer: {
                Text("SIRI_EVENT_SUGGESTIONS_TESTING_FOOTER", tableName: table)
            }
            
            Section("MIDI_CI_API_BETA".localize(table: table)) {
                Toggle("MIDI_CI_API_BETA_ENABLE".localize(table: table), isOn: $enableMidiCi)
            }
            
            Section {
                Toggle("SHOW_GRAPHICS_HUD".localize(table: table), isOn: $showGraphicsHudEnabled)
                Toggle("LOG_GRAPHICS_PERFORMANCE".localize(table: table), isOn: $logGraphicsPerformanceEnabled)
            } header: {
                Text("GRAPHICS_HUD", tableName: table)
            } footer: {
                Text("GRAPHICS_HUD_FOOTER", tableName: table)
            }
            
            Section {
                Toggle("BLUETOOTH_TESTING_HID_LOGGING_ENABLE".localize(table: table), isOn: $hidLoggingEnabled)
                Toggle("BLUETOOTH_TESTING_HRM_LOGGING_ENABLE".localize(table: table), isOn: $hidLoggingEnabled)
            } header: {
                Text("BLUETOOTH_LOGGING", tableName: table)
            } footer: {
                Text("BLUETOOTH_LOGGING_FOOTER", tableName: table)
            }
            
            Section {
                Toggle("PREFERRED_AUDIO_ROUTE_TESTING".localize(table: table), isOn: $showAudioOutput)
            } header: {
                Text("PREFERRED_AUDIO_ROUTE_TITLE", tableName: table)
            } footer: {
                Text("PREFERRED_AUDIO_ROUTE_FOOTER", tableName: table)
            }
        }
    }
}

#Preview {
    NavigationStack {
        DeveloperView()
    }
}
