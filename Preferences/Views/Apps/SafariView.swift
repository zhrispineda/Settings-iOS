//
//  SafariView.swift
//  Preferences
//
//  Settings > Apps > Safari
//

import SwiftUI

struct SafariView: View {
    // Variables
    @State private var alsoUsePrivateBrowsingEnabled = true
    @State private var searchEngineSuggestionsEnabled = true
    @State private var safariSuggestionsEnabled = true
    @State private var preloadTopHitEnabled = true
    @State private var showFavoritesBarEnabled = false
    @State private var showLinksHoverEnabled = false
    @State private var blockPopUpsEnabled = true
    @State private var separateTabBarEnabled = true
    @State private var landscapeTabBarEnabled = true
    @State private var allowWebsiteTintingEnabled = true
    
    @State private var preventCrossSiteTrackingEnabled = true
    @State private var requirePasscodeUnlockPrivateBrowsingEnabled = false
    @State private var fradulentWebsiteWarningEnabled = true
    @State private var highlightsEnabled = false
    
    @State private var showColorCompactTabBarEnabled = true
    @State private var automaticallySaveOfflineEnabled = false
    
    var body: some View {
        CustomList(title: "Safari") {
            Section {
                SettingsLink(icon: "appleSiri", id: "Siri & Search") {
                    SiriDetailView(appName: "Safari")
                }
            } header: {
                Text("Allow Safari to Access")
            }
            
            CustomNavigationLink(title: "Default Browser App", status: "Safari", destination: EmptyView())
            
            Section {
                CustomNavigationLink(title: "Search Engine", status: "Google", destination: SelectOptionList(title: "Search Engine", options: ["Google", "Yahoo", "Bing", "DuckDuckGo", "Ecosia"], selected: "Google"))
                Toggle("Also Use in Private Browsing", isOn: $alsoUsePrivateBrowsingEnabled)
                Toggle("Search Engine Suggestions", isOn: $searchEngineSuggestionsEnabled)
                Toggle("Safari Suggestions", isOn: $safariSuggestionsEnabled)
                CustomNavigationLink(title: "Quick Website Search", status: "On", destination: QuickWebsiteSearchView())
                Toggle("Preload Top Hit", isOn: $preloadTopHitEnabled)
            } header: {
                Text("Search")
            } footer: {
                Text("Private Browsing uses on-device information to provide search suggestions. No data is shared with the service provider. [About Siri Suggestions, Search & Privacy...](#)")
            }
            
            Section {
                NavigationLink("AutoFill", destination: AutoFillView())
                CustomNavigationLink(title: "Favorites", status: "Favorites", destination: FavoritesView())
                if Device().isTablet {
                    Toggle("Show Favorites Bar", isOn: $showFavoritesBarEnabled)
                    CustomNavigationLink(title: "Favorites Bar Appearance", status: "Show Icons and Text", destination: EmptyView())
                    Toggle("Show Links on Hover", isOn: $showLinksHoverEnabled)
                }
                Toggle("Block Pop-ups", isOn: $blockPopUpsEnabled)
                NavigationLink("Extensions", destination: ExtensionsView())
                CustomNavigationLink(title: "Downloads", status: "On My \(Device().model)", destination: DownloadsView())
            } header: {
                Text("General")
            }
            
            Section {
                HStack {
                    Spacer()
                    VStack(spacing: 15) {
                        Button {
                            separateTabBarEnabled = true
                        } label: {
                            VStack(spacing: 15) {
                                Image("") // TODO: Images per device type, for both dark and light mode
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 100)
                                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
                                    .padding(.top)
                                Text(Device().isTablet ? "Off" : "Tab Bar")
                                    .font(.subheadline)
                                Image(systemName: separateTabBarEnabled ? "checkmark.circle.fill" : "circle")
                                    .foregroundStyle(separateTabBarEnabled ? Color(UIColor.systemBackground) : Color(UIColor.tertiaryLabel), .blue)
                                    .font(.title)
                                    .fontWeight(.light)
                            }
                        }
                        .buttonStyle(.plain)
                    }
                    Spacer()
                    VStack(spacing: 15) {
                        Button {
                            separateTabBarEnabled = false
                        } label: {
                            VStack(spacing: 15) {
                                Image("") // TODO: Images per device type, for both dark and light mode
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 100)
                                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
                                    .padding(.top)
                                Text(Device().isTablet ? "Split View & Slide Over" : "Single Tab")
                                    .font(.subheadline)
                                Image(systemName: !separateTabBarEnabled ? "checkmark.circle.fill" : "circle")
                                    .foregroundStyle(!separateTabBarEnabled ? Color(UIColor.systemBackground) : Color(UIColor.tertiaryLabel), .blue)
                                    .font(.title)
                                    .fontWeight(.light)
                            }
                        }
                        .buttonStyle(.plain)
                    }
                    Spacer()
                }
                if !UIDevice.current.name.contains("SE") {
                    Toggle("Landscape Tab Bar", isOn: $landscapeTabBarEnabled)
                }
                Toggle("Allow Website Tinting", isOn: $allowWebsiteTintingEnabled)
                CustomNavigationLink(title: "Open Links", status: "In New Tab", destination: SelectOptionList(title: "Open Links", options: ["In New Tab", "In Background"], selected: "In New Tab"))
                CustomNavigationLink(title: "Close Tabs", status: "Manually", destination: SelectOptionList(title: "Close Tabs", options: ["Manually", "After One Day", "After One Week", "After One Month"], selected: "Manually"))
            } header: {
                Text("Tabs")
            } footer: {
                Text("Allow Safari to automatically close tabs that haven‘t recently been viewed.")
            }
            
            Section {
                Button("New Profile") {}
            } header: {
                Text("Profiles")
            } footer: {
                VStack(alignment: .leading) {
                    Text("Profiles allow you to keep your browsing separated. You may want to set up a profile for work or school. Your history, cookies, and website data will be distinct per profile.\n")
                    Text("When you start using profiles, a default Personal profile will automatically be ceated based on your current settings. You can create additional profiles, add a name and an icon to each, and also set custom Favorites to personalize the experience.")
                }
            }
            
            Section {
                Toggle("Prevent Cross-Site Tracking", isOn: $preventCrossSiteTrackingEnabled)
                CustomNavigationLink(title: "Hide IP Address", status: "Off", destination: HideAddressView())
                Toggle("Require Passcode to Unlock Private Browsing", isOn: $requirePasscodeUnlockPrivateBrowsingEnabled)
                Toggle("Fradulent Website Warning", isOn: $fradulentWebsiteWarningEnabled)
                Toggle("Highlights", isOn: $highlightsEnabled)
            } header: {
                Text("Privacy & Security")
            } footer: {
                Text("[About Safari & Privacy...](#)")
            }
            
            Section {
                Button("Clear History and Website Data") {}
            }
            
            Section {
                NavigationLink("Page Zoom", destination: PageZoomView())
                NavigationLink("Request Desktop Website", destination: RequestDesktopWebsiteView())
                NavigationLink("Reader", destination: SafariReaderView())
                NavigationLink("Camera", destination: SafariCameraView())
                NavigationLink("Microphone", destination: SafariMicrophoneView())
                NavigationLink("Location", destination: SafariLocationView())
            } header: {
                Text("Settings for Websites")
            }
            
            if Device().isTablet {
                Section {
                    Toggle("Show Color in Compact Tab Bar", isOn: $showColorCompactTabBarEnabled)
                } header: {
                    Text("Accessibility")
                }
            }
            
            Section {
                Toggle("Automatically Save Offline", isOn: $automaticallySaveOfflineEnabled)
            } header: {
                Text("Reading List")
            } footer: {
                Text("Automatically save all Reading List items from iCloud for offline reading.")
            }
            
            Section {
                NavigationLink("Advanced", destination: SafariAdvancedView())
            }
        }
    }
}

#Preview {
    NavigationStack {
        SafariView()
    }
}
