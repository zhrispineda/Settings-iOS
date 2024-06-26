//
//  NewsView.swift
//  Preferences
//
//  Settings > Apps > News
//

import SwiftUI

struct NewsView: View {
    // Variables
    @State private var liveActivitiesEnabled = true
    @State private var backgroundAppRefreshEnabled = true
    @State private var restrictStoriesTodayEnabled = false
    @State private var showingRestrictDialog = false
    @State private var showingRestrictAlert = false
    @State private var downloadIssuesEnabled = true
    @State private var resetIdentifierEnabled = false
    
    var body: some View {
        CustomList(title: "News") {
            Section {
                SettingsLink(icon: "appleSiri", id: "Siri & Search") {
                    SiriDetailView(appName: "News")
                }
                IconToggle(enabled: $liveActivitiesEnabled, color: .blue, icon: "clock.badge.fill", title: "Live Activities")
                IconToggle(enabled: $backgroundAppRefreshEnabled, color: .gray, icon: "gear", title: "Background App Refresh")
            } header: {
                Text("Allow News to Access")
            }
            
            Section {
                Toggle("Restrict Stories in Today", isOn: $restrictStoriesTodayEnabled)
                    .alert("Restrict Stories?", isPresented: $showingRestrictAlert) {
                        Button("Turn On") {}
                        Button("Cancel", role: .cancel) {
                            restrictStoriesTodayEnabled.toggle()
                        }
                    } message: {
                        Text("Turning on this setting will limit the stories shown in Today. Top Stories, Trending Stories, and Featured Stories will be removed.")
                    }
                    .confirmationDialog("Turning on this setting will limit the stories shown in Today. Top Stories, Trending Stories, and Featured Stories will be removed.", isPresented: $showingRestrictDialog, titleVisibility: .visible) {
                        Button("Turn On") {}
                        Button("Cancel", role: .cancel) {
                            restrictStoriesTodayEnabled.toggle()
                        }
                    }
                    .onChange(of: restrictStoriesTodayEnabled) {
                        if restrictStoriesTodayEnabled {
                            Device().isPhone ? showingRestrictDialog.toggle() : showingRestrictAlert.toggle()
                        }
                    }
            } header: {
                Text("News Settings")
            } footer: {
                Text("Only stories from channels you follow will appear in Today. All other sources will be blocked.")
            }
            
            Section {
                Toggle("Download Issues", isOn: $downloadIssuesEnabled)
            } header: {
                Text("Automatic Downloads")
            } footer: {
                Text("Automatically download magazine issues for offline reading. Requires an Apple News+ subscription.")
            }
            
            Section {
                Button("About Apple News & Privacy") {}
                Button("Apple News Newsletters & Privacy") {}
                Toggle("Reset Identifier", isOn: $resetIdentifierEnabled)
            } footer: {
                Text("Turn on to reset the identifier used by Apple News and Stocks to report statistics to news publishers. The identifier will be reset the next time you open Apple News.")
            }
        }
    }
}

#Preview {
    NewsView()
}
