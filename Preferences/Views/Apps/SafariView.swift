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
        CustomList(title: "Safari", topPadding: true) {
            Section {
                SettingsLink(icon: "appleSiri", id: "Siri & Search") {
                    SiriDetailView(appName: "Safari")
                }
            } header: {
                Text("Allow Safari to Access")
            }
            
            CustomNavigationLink("Default Browser App", status: "Safari", destination: EmptyView())
            
            Section {
                CustomNavigationLink("Search Engine", status: "Google", destination: SelectOptionList(title: "Search Engine", options: ["Google", "Yahoo", "Bing", "DuckDuckGo", "Ecosia"], selected: "Google"))
                Toggle("Also Use in Private Browsing", isOn: $alsoUsePrivateBrowsingEnabled)
                Toggle("Search Engine Suggestions", isOn: $searchEngineSuggestionsEnabled)
                Toggle("Safari Suggestions", isOn: $safariSuggestionsEnabled)
                CustomNavigationLink("Quick Website Search", status: "On", destination: QuickWebsiteSearchView())
                Toggle("Preload Top Hit", isOn: $preloadTopHitEnabled)
            } header: {
                Text("Search")
            } footer: {
                Text("\(UIDevice.iPad ? "Private Browsing uses on-device information to provide search suggestions. No data is shared with the service provider. " : "")[About Siri Suggestions, Search & Privacy...](#)")
            }
            
            Section {
                NavigationLink("AutoFill", destination: AutoFillView())
                CustomNavigationLink("Favorites", status: "Favorites", destination: FavoritesView())
                if UIDevice.iPad {
                    Toggle("Show Favorites Bar", isOn: $showFavoritesBarEnabled)
                    CustomNavigationLink("Favorites Bar Appearance", status: "Show Icons and Text", destination: EmptyView())
                    Toggle("Show Links on Hover", isOn: $showLinksHoverEnabled)
                }
                Toggle("Block Pop-ups", isOn: $blockPopUpsEnabled)
                NavigationLink("Extensions", destination: ExtensionsView())
                CustomNavigationLink("Downloads", status: "On My \(UIDevice.current.model)", destination: DownloadsView())
            } header: {
                Text("General")
            }
            
            Section {
                HStack {
                    Spacer()
                    VStack(spacing: 10) {
                        Button {
                            separateTabBarEnabled = true
                        } label: {
                            VStack(spacing: 15) {
                                Image(UIDevice.iPad ? "SeparateTabBarRectangular_Light" : UIDevice.HomeButtonCapability ? "Lowered_TabBar_LegacyHomeButton" : UIDevice.WideNotch ? "Lowered_TabBar_WideNotch" : UIDevice.NarrowNotch ? "Lowered_TabBar_NarrowNotch" : "Lowered_TabBar_D7x")
                                    .resizable()
                                    .foregroundStyle(.blue)
                                    .scaledToFit()
                                    .frame(height: 100)
                                    .padding(.top)
                                Text(UIDevice.iPad ? "Separate Tab Bar" : "Tab Bar")
                                    .font(.subheadline)
                                Image(systemName: separateTabBarEnabled ? "checkmark.circle.fill" : "circle")
                                    .foregroundStyle(separateTabBarEnabled ? Color(UIColor.systemBackground) : Color(UIColor.tertiaryLabel), .blue)
                                    .font(.title2)
                                    .fontWeight(.light)
                            }
                        }
                        .buttonStyle(.plain)
                    }
                    Spacer()
                    VStack(spacing: 10) {
                        Button {
                            separateTabBarEnabled = false
                        } label: {
                            VStack(spacing: 15) {
                                Image(UIDevice.iPad ? "Compact_Tab_Bar_Setting" : UIDevice.HomeButtonCapability ? "Classic_SingleTab_LegacyHomeButton" : UIDevice.WideNotch ? "Classic_SingleTab_WideNotch" : UIDevice.NarrowNotch ? "Classic_SingleTab_NarrowNotch" : "Classic_SingleTab_D7x")
                                    .resizable()
                                    .foregroundStyle(.blue)
                                    .scaledToFit()
                                    .frame(height: 100)
                                    .padding(.top)
                                Text(UIDevice.iPad ? "Compact Tab Bar" : "Single Tab")
                                    .font(.subheadline)
                                Image(systemName: !separateTabBarEnabled ? "checkmark.circle.fill" : "circle")
                                    .foregroundStyle(!separateTabBarEnabled ? Color(UIColor.systemBackground) : Color(UIColor.tertiaryLabel), .blue)
                                    .font(.title2)
                                    .fontWeight(.light)
                            }
                        }
                        .buttonStyle(.plain)
                    }
                    Spacer()
                }
                .alignmentGuide(.listRowSeparatorLeading) { _ in
                    return 0
                }
                if !UIDevice.current.model.contains("SE") {
                    Toggle("Landscape Tab Bar", isOn: $landscapeTabBarEnabled)
                }
                Toggle("Allow Website Tinting", isOn: $allowWebsiteTintingEnabled)
                CustomNavigationLink("Open Links", status: "In New Tab", destination: SelectOptionList(title: "Open Links", options: ["In New Tab", "In Background"], selected: "In New Tab"))
                CustomNavigationLink("Close Tabs", status: "Manually", destination: SelectOptionList(title: "Close Tabs", options: ["Manually", "After One Day", "After One Week", "After One Month"], selected: "Manually"))
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
                CustomNavigationLink("Hide IP Address", status: "Off", destination: HideAddressView())
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
            
            if UIDevice.iPad {
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
