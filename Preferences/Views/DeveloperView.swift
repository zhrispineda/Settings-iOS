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
    @State private var uiAutomationEnabled = true
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
    
    var body: some View {
        CustomList(title: "Developer") {
            Section(content: {
                Toggle("Dark Appearance", isOn: $darkAppearanceEnabled)
            }, header: {
                Text("Appearance")
            })
            
            Section(content: {
                NavigationLink(destination: {}, label: {
                    HRowLabels(title: "View", subtitle: "Default")
                })
            }, header: {
                Text("Display Zoom")
            }, footer: {
                Text("Choose a view for \(UIDevice().localizedModel). Zoomed shows larger controls. Standard shows more content.")
            })
            
            Section(content: {
                Button("Clear Trusted Computer", action: {})
            }, header: {
                Text("Paired Devices")
            }, footer: {
                Text("Removing trusted computers will delete all of the records of computers that you have paired with previously.")
            })
            
            Section(content: {
                Toggle("Enable UI Automation", isOn: $uiAutomationEnabled)
            }, header: {
                Text("UI Automation")
            })
            
            Section(content: {
                Toggle("Fast App Termination", isOn: $fastAppTerminationEnabled)
            }, header: {
                Text("State Restoration Testing")
            }, footer: {
                Text("Terminate instead of suspending apps when backgrounded to force apps to be relaunched when they are foregrounded.")
            })
            
            if DeviceInfo().isPhone { // MARK: Wallet Testing
                Section(content: {
                    Toggle("Additional Logging", isOn: $additionalLoggingEnabled)
                    Toggle("Allow HTTP Services", isOn: $allowHttpServicesEnabled)
                    Toggle("Disable Rate Limiting", isOn: $disableRateLimitingEnabled)
                    Toggle("NFC Pass Key Optional", isOn: $nfcPassKeyOptionalEnabled)
                }, header: {
                    Text("Wallet Testing")
                })
            }
            
            Section(content: {
                NavigationLink("AirPlay Suggestions", destination: {})
                Button("Reset Media Services", action: {})
            }, header: {
                Text("Media Services Testing")
            })
            
            Section(content: {
                Toggle("Reset Local Data on Next Launch", isOn: $resetLocalDataNextLaunch)
            }, header: {
                Text("News Testing")
            }, footer: {
                Text("Reset layouts, images, and other cached elements. Private data will not be affected.")
            })
            
            Section(content: {
                NavigationLink("TV Provider", destination: {})
            }, header: {
                Text("TV Provider Testing")
            })
            
            Section(content: {
                NavigationLink("TV App", destination: {})
            }, header: {
                Text("TV App Testing")
            })
            
            Section(content: {
                Button("Reindex All Items", action: {})
                Button("Reindex All Items with Identifiers", action: {})
            }, header: {
                Text("CoreSpotlight Testing")
            })
            
            Section(content: {
                Toggle("WidgetKit Developer Mode", isOn: $widgetKitDeveloperModeEnabled)
            }, header: {
                Text("WidgetKit Testing")
            }, footer: {
                Text("When turned on, your widgets will not be subject to the standard WidgetKit constraints to allow for debugging.")
            })
            
            Section(content: {
                Toggle("Display Recent Shortcuts", isOn: $displayRecentShortcutsEnabled)
            }, header: {
                Text("Shortcuts Testing")
            }, footer: {
                Text("When turned on, the Siri Suggestions Widget & Siri Watch Face show the most recently provided shortcuts rather than current predictions.")
            })
            
            Section(content: {
                Toggle("Display Upcoming Media", isOn: $displayUpcomingMediaEnabled)
            }, footer: {
                Text("When turned on, Siri Suggestions in Search will show Upcoming Media Intents donated via INUpcomingMediaManager.")
            })
            
            Section(content: {
                Toggle("Display Donations on Lock Screen", isOn: $displayDonationsLockScreenEnabled)
            }, footer: {
                Text("When turned on, the most recently donated shortcuts will be shown on the Lock Screen.")
            })
            
            Section(content: {
                Button("Force Sync Shortcuts to Watch", action: {})
            }, footer: {
                Text("To force sync shortcuts, make sure Apple Watch is connected to its charger.")
            })
            
            Section(content: {
                Toggle("Allow Any Domain", isOn: $allowAnyDomainsEnabled)
                Toggle("Allow Unverified Sources", isOn: $allowUnverifiedSources)
            }, header: {
                Text("Siri Event Suggestions Testing")
            }, footer: {
                Text("These settings affect Siri Event Suggestions from Mail and Safari. Enable Allow Any Domain to allow e-mails or web pages which have not yet been approved for Siri Event Suggestions by Apple. Enable Allow Unverified Sources to bypass DKIM or SSL authenticity verification for Siri Event Suggestions in Mail and Safari.")
            })
            
            Section(content: {
                Toggle("Enable MIDI-CI", isOn: $enableMidiCi)
            }, header: {
                Text("Enable MIDI-CI")
            })
            
            Section(content: {
                Toggle("Show Graphics HUD", isOn: $showGraphicsHudEnabled)
                Toggle("Log Graphics Performance", isOn: $logGraphicsPerformanceEnabled)
            }, header: {
                Text("Graphics HUD")
            }, footer: {
                Text("The graphics performance HUD shows framerate, GPU time, memory usage, and can log performance data for later analysis.")
            })
        }
    }
}

#Preview {
    DeveloperView()
}
