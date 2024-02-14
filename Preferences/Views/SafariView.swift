//
//  SafariView.swift
//  Preferences
//
//  Settings > Safari
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
    @State private var showColorCompactTabBarEnabled = true
    @State private var automaticallySaveOfflineEnabled = false
    
    var body: some View {
        CustomList(title: "Safari") {
            Section(content: {
                SettingsLink(icon: "applesiri", id: "Siri & Search", content: {})
            }, header: {
                Text("Allow Safari to Access")
            })
            
            Section(content: {
                NavigationLink(destination: {}, label: {
                    HRowLabels(title: "Search Engine", subtitle: "Google")
                })
                Toggle("Also Use in Private Browsing", isOn: $alsoUsePrivateBrowsingEnabled)
                Toggle("Search Engine Suggestions", isOn: $searchEngineSuggestionsEnabled)
                Toggle("Safari Suggestions", isOn: $safariSuggestionsEnabled)
                NavigationLink(destination: {}, label: {
                    HRowLabels(title: "Quick Website Search", subtitle: "On")
                })
                Toggle("Preload Top Hit", isOn: $preloadTopHitEnabled)
            }, header: {
                Text("Search")
            }, footer: {
                Text("Private Browsing uses on-device information to provide search suggestions. No data is shared with the service provider. [About Siri Suggestions, Search & Privacy...](#)")
            })
            
            Section(content: {
                NavigationLink("AutoFill", destination: {})
                NavigationLink(destination: {}, label: { HRowLabels(title: "Favorites", subtitle: "Favorites")
                })
                if DeviceInfo().isTablet {
                    Toggle("Show Favorites Bar", isOn: $showFavoritesBarEnabled)
                    NavigationLink(destination: {}, label: {
                        HRowLabels(title: "Favorites Bar Appearance", subtitle: "Show Icons and Text")
                    })
                    Toggle("Show Links on Hover", isOn: $showLinksHoverEnabled)
                }
                Toggle("Block Pop-ups", isOn: $blockPopUpsEnabled)
                NavigationLink("Extensions", destination: {})
                NavigationLink(destination: {}, label: {
                    HRowLabels(title: "Downloads", subtitle: "On My \(DeviceInfo().model)")
                })
            }, header: {
                Text("General")
            })
            
            Section(content: {
                HStack {
                    Spacer()
                    VStack(spacing: 15) {
                        Button(action: {
                            separateTabBarEnabled = true
                        }, label: {
                            VStack(spacing: 15) {
                                Image("") // TODO: Images per device type, for both dark and light mode
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 100)
                                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
                                    .padding(.top)
                                Text(DeviceInfo().isTablet ? "Off" : "Tab Bar")
                                    .font(.subheadline)
                                Image(systemName: separateTabBarEnabled ? "checkmark.circle.fill" : "circle")
                                    .foregroundStyle(separateTabBarEnabled ? Color(UIColor.systemBackground) : Color(UIColor.tertiaryLabel), .blue)
                                    .font(.title)
                                    .fontWeight(.light)
                            }
                        })
                        .buttonStyle(.plain)
                    }
                    Spacer()
                    VStack(spacing: 15) {
                        Button(action: {
                            separateTabBarEnabled = false
                        }, label: {
                            VStack(spacing: 15) {
                                Image("") // TODO: Images per device type, for both dark and light mode
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 100)
                                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
                                    .padding(.top)
                                Text(DeviceInfo().isTablet ? "Split View & Slide Over" : "Single Tab")
                                    .font(.subheadline)
                                Image(systemName: !separateTabBarEnabled ? "checkmark.circle.fill" : "circle")
                                    .foregroundStyle(!separateTabBarEnabled ? Color(UIColor.systemBackground) : Color(UIColor.tertiaryLabel), .blue)
                                    .font(.title)
                                    .fontWeight(.light)
                            }
                        })
                        .buttonStyle(.plain)
                    }
                    Spacer()
                }
                if !UIDevice.current.name.contains("SE") {
                    Toggle("Landscape Tab Bar", isOn: $landscapeTabBarEnabled)
                }
                Toggle("Allow Website Tinting", isOn: $allowWebsiteTintingEnabled)
                NavigationLink(destination: {}, label: {
                    HRowLabels(title: "Open Links", subtitle: "In New Tab")
                })
                NavigationLink(destination: {}, label: {
                    HRowLabels(title: "Close Tabs", subtitle: "Manually")
                })
            }, header: {
                Text("Tabs")
            }, footer: {
                Text("Allow Safari to automatically close tabs that haven‘t recently been viewed.")
            })
            
            Section(content: {
                Button("New Profile", action: {})
            }, header: {
                Text("Profiles")
            }, footer: {
                VStack(alignment: .leading) {
                    Text("Profiles allow you to keep your browsing separated. You may want to set up a profile for work or school. Your history, cookies, and website data will be distinct per profile.\n")
                    Text("When you start using profiles, a default Personal profile will automatically be ceated based on your current settings. You can create additional profiles, add a name and an icon to each, and also set custom Favorites to personalize the experience.")
                }
            })
            
            Section(content: {
                Toggle("Prevent Cross-Site Tracking", isOn: $preventCrossSiteTrackingEnabled)
                NavigationLink(destination: {}, label: {
                    HRowLabels(title: "Hide IP Address", subtitle: "Off")
                })
                Toggle("Require Passcode to Unlock Private Browsing", isOn: $requirePasscodeUnlockPrivateBrowsingEnabled)
                Toggle("Fradulent Website Warning", isOn: $fradulentWebsiteWarningEnabled)
            }, header: {
                Text("Privacy & Security")
            }, footer: {
                Text("[About Safari & Privacy...](#)")
            })
            
            Section {
                Button("Clear History and Website Data", action: {})
            }
            
            Section(content: {
                NavigationLink("Page Zoom", destination: {})
                NavigationLink("Request Desktop Website", destination: {})
                NavigationLink("Reader", destination: {})
                NavigationLink("Camera", destination: {})
                NavigationLink("Microphone", destination: {})
                NavigationLink("Location", destination: {})
            }, header: {
                Text("Settings for Websites")
            })
            
            if DeviceInfo().isTablet {
                Section(content: {
                    Toggle("Show Color in Compact Tab Bar", isOn: $showColorCompactTabBarEnabled)
                }, header: {
                    Text("Accessibility")
                })
            }
            
            Section(content: {
                Toggle("Automatically Save Offline", isOn: $automaticallySaveOfflineEnabled)
            }, header: {
                Text("Reading List")
            }, footer: {
                Text("Automatically save all Reading List items from iCloud for offline reading.")
            })
            
            Section {
                NavigationLink("Advanced", destination: {})
            }
        }
    }
}

#Preview {
    SafariView()
}
