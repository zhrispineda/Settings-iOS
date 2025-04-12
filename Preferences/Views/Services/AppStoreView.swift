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
    @State private var showingSheet = false
    let table = "StoreSettings"
    
    var body: some View {
        CustomList(title: "STORE_SETTINGS_TITLE".localize(table: table), topPadding: true) {
            // Allow App Store to Access
            PermissionsView(appName: "STORE_SETTINGS_TITLE".localize(table: table), cellularEnabled: $cellularEnabled)
            
            // Automatic Downloads
            Section("AUTO_DOWNLOAD_ON_CELL".localize(table: table)) {
                Toggle(isOn: $appDownloadsEnabled) {
                    Text("AUTO_DOWNLOAD_APPS", tableName: table)
                    Text("AUTO_DOWNLOADS_APPS_EXPLANATION", tableName: table)
                        .font(.footnote)
                }
                Toggle(isOn: $appDownloadsEnabled) {
                    Text("AUTO_DOWNLOAD_UPDATES", tableName: table)
                    Text("AUTO_DOWNLOAD_UPDATES_EXPLANATION", tableName: table)
                        .font(.footnote)
                }
                Toggle(isOn: $appDownloadsEnabled) {
                    Text("AUTO_DOWNLOAD_BACKGROUND_ASSETS", tableName: table)
                    Text("AUTO_DOWNLOAD_BACKGROUND_ASSETS_EXPLANATION", tableName: table)
                        .font(.footnote)
                }
            }
            
            // Cellular Data
            if UIDevice.CellularTelephonyCapability {
                Section {
                    Toggle("AUTO_DOWNLOAD_ON_CELL".localize(table: table), isOn: $automaticDownloadsEnabled)
                    CustomNavigationLink("AUTO_DOWNLOAD_APPS".localize(table: table), status: "ALWAYS_ALLOW".localize(table: table), destination: EmptyView())
                } header: {
                    Text("CELLULAR_DATA_HEADER", tableName: table)
                } footer: {
                    Text("ALWAYS_ALLOW_EXPLANATION", tableName: table)
                }
                .disabled(!cellularEnabled)
            }
            
            // Video Autoplay
            Section {
                CustomNavigationLink("AUTO_PLAY_VIDEO_SETTINGS_TITLE".localize(table: table), status: "AUTO_PLAY_VIDEO_MODE_ON".localize(table: table), destination: EmptyView())
            } footer: {
                Text("AUTO_PLAY_VIDEO_SETTINGS_DESCRIPTION", tableName: table)
            }
            
            // In-App Ratings & Reviews
            Section {
                Toggle("IN_APP_REVIEW_ON_CELL".localize(table: table), isOn: $inAppRatingsReviewEnabled)
            } footer: {
                Text("IN_APP_REVIEW_ON_CELL_EXPLANATION", tableName: table)
            }
            
            // Offload Unused Apps
            Section {
                Toggle("OFFLOAD_UNUSED_APPS_ON_CELL".localize(table: table), isOn: $offloadUnusedAppsEnabled)
            } footer: {
                Text("OFFLOAD_UNUSED_APPS_ON_CELL_EXPLANATION", tableName: table)
            }
            
            // Privacy
            Section {
                Button("PRIVACY_APP_STORE_ARCADE_CELL".localize(table: table)) {
                    showingSheet.toggle()
                }
                Link("PRIVACY_PERSONALIZED_RECOMMENDATIONS_CELL".localize(table: table), destination: URL(string: "itms-apps:///personalizationTransparency?enabled=true")!)
            } header: {
                Text("PRIVACY_HEADER", tableName: table)
            }
        }
        .background {
            OBCombinedSplashView(["com.apple.onboarding.appstore", "com.apple.onboarding.applearcade"], showingSheet: $showingSheet)
        }
    }
}

#Preview {
    NavigationStack {
        AppStoreView()
    }
}
