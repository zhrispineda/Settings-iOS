//
//  AppStoreView.swift
//  Preferences
//
//  Settings > App Store
//

import SwiftUI

struct AppStoreView: View {
    // Variables
    @State private var cellularEnabled = true
    
    @State private var appDownloadsEnabled = false
    @State private var appUpdatesEnabled = true
    @State private var inAppContentEnabled = true
    
    @State private var automaticDownloadsEnabled = false
    @State private var inAppRatingsReviewEnabled = true
    @State private var offloadUnusedAppsEnabled = false
    
    var body: some View {
        CustomList(title: "App Store") {
            PermissionsView(appName: "App Store", cellularEnabled: $cellularEnabled)
            
            LanguageView()
            
            Section {
                Toggle(isOn: $appDownloadsEnabled) {
                    Text("App Downloads")
                    Text("Automatically install free and paid apps purchased on other devices.")
                }
                Toggle(isOn: $appDownloadsEnabled) {
                    Text("App Updates")
                    Text("Automatically install free and paid apps purchased on other devices.")
                }
                Toggle(isOn: $appDownloadsEnabled) {
                    Text("In-App Content")
                    Text("Automatically install free and paid apps purchased on other devices.")
                }
            } header: {
                Text("Automatic Downloads")
            }
            
            Section {
                Toggle("Automatic Downloads", isOn: $automaticDownloadsEnabled)
                CustomNavigationLink(title: "App Downloads", status: "Always Allow", destination: EmptyView())
            } header: {
                Text("Cellular Data")
            } footer: {
                Text("Allow all apps to download automatically using cellular data. When roaming, permission to download is always required.")
            }
            .disabled(!cellularEnabled)
            
            Section {
                CustomNavigationLink(title: "Video Autoplay", status: "On", destination: EmptyView())
            } footer: {
                Text("Automatically play app preview videos in the App Store.")
            }
            
            Section {
                Toggle("In-App Ratings & Reviews", isOn: $inAppRatingsReviewEnabled)
            } footer: {
                Text("Help developers and other users know what you think by letting apps ask for product feedback.")
            }
            
            Section {
                Toggle("Offload Unused Apps", isOn: $offloadUnusedAppsEnabled)
            } footer: {
                Text("Automatically remove unused apps, but keep all documents and data. Reinstalling the app will place back your data, if the app is still available in the App Store.")
            }
            
            Section {
                Button("App Store & Arcade Privacy") {}
                Button("Personalized Recommendations") {}
            } header: {
                Text("Privacy")
            }
        }
    }
}

#Preview {
    NavigationStack {
        AppStoreView()
    }
}
