//
//  AppStoreView.swift
//  Preferences
//

import SwiftUI

/// View for Settings > Apps > App Store
struct AppStoreView: View {
    @State private var cellularEnabled = true
    @State private var appDownloadsEnabled = false
    @State private var appUpdatesEnabled = true
    @State private var inAppContentEnabled = true
    @State private var automaticDownloadsEnabled = false
    @State private var inAppRatingsReviewEnabled = true
    @State private var offloadUnusedAppsEnabled = false
    @State private var showingSheet = false
    private let path = "/System/Library/PreferenceBundles/MobileStoreSettings.bundle"
    private let table = "StoreSettings"
    
    var body: some View {
        CustomList(title: "STORE_SETTINGS_TITLE".localized(path: path, table: table), topPadding: true) {
            // Allow App Store to Access
            PermissionsView(
                appName: "STORE_SETTINGS_TITLE".localized(path: path, table: table),
                cellularEnabled: $cellularEnabled
            )
            
            // Automatic Downloads
            Section("AUTO_DOWNLOAD_ON_CELL".localized(path: path, table: table)) {
                Toggle(isOn: $appDownloadsEnabled) {
                    Text("AUTO_DOWNLOAD_APPS".localized(path: path, table: table))
                    Text("AUTO_DOWNLOADS_APPS_EXPLANATION".localized(path: path, table: table))
                        .font(.footnote)
                }
                Toggle(isOn: $appDownloadsEnabled) {
                    Text("AUTO_DOWNLOAD_UPDATES".localized(path: path, table: table))
                    Text("AUTO_DOWNLOAD_UPDATES_EXPLANATION".localized(path: path, table: table))
                        .font(.footnote)
                }
                Toggle(isOn: $appDownloadsEnabled) {
                    Text("AUTO_DOWNLOAD_BACKGROUND_ASSETS".localized(path: path, table: table))
                    Text("AUTO_DOWNLOAD_BACKGROUND_ASSETS_EXPLANATION".localized(path: path, table: table))
                        .font(.footnote)
                }
            }
            
            // Cellular Data
            if UIDevice.CellularTelephonyCapability {
                Section {
                    Toggle("AUTO_DOWNLOAD_ON_CELL".localized(path: path, table: table), isOn: $automaticDownloadsEnabled)
                    SLink(
                        "AUTO_DOWNLOAD_APPS".localized(path: path, table: table),
                        status: "ALWAYS_ALLOW".localized(path: path, table: table)
                    ) {}
                } header: {
                    Text("CELLULAR_DATA_HEADER".localized(path: path, table: table))
                } footer: {
                    Text("ALWAYS_ALLOW_EXPLANATION".localized(path: path, table: table))
                }
                .disabled(!cellularEnabled)
            }
            
            // Video Autoplay
            Section {
                SLink(
                    "AUTO_PLAY_VIDEO_SETTINGS_TITLE".localized(path: path, table: table),
                    status: "AUTO_PLAY_VIDEO_MODE_ON".localized(path: path, table: table)
                ) {}
            } footer: {
                Text("AUTO_PLAY_VIDEO_SETTINGS_DESCRIPTION".localized(path: path, table: table))
            }
            
            // In-App Ratings & Reviews
            Section {
                Toggle("IN_APP_REVIEW_ON_CELL".localized(path: path, table: table), isOn: $inAppRatingsReviewEnabled)
            } footer: {
                Text("IN_APP_REVIEW_ON_CELL_EXPLANATION".localized(path: path, table: table))
            }
            
            // Offload Unused Apps
            Section {
                Toggle("OFFLOAD_UNUSED_APPS_ON_CELL".localized(path: path, table: table), isOn: $offloadUnusedAppsEnabled)
            } footer: {
                Text("OFFLOAD_UNUSED_APPS_ON_CELL_EXPLANATION".localized(path: path, table: table))
            }
            
            // Privacy
            Section {
                Button("PRIVACY_APP_STORE_ARCADE_CELL".localized(path: path, table: table)) {
                    showingSheet.toggle()
                }
                Link("PRIVACY_PERSONALIZED_RECOMMENDATIONS_CELL".localized(path: path, table: table), destination: URL(string: "itms-apps:///personalizationTransparency?enabled=true")!)
            } header: {
                Text("PRIVACY_HEADER".localized(path: path, table: table))
            }
        }
        .background {
            OBCombinedSplashController(
                ["com.apple.onboarding.appstore", "com.apple.onboarding.applearcade"],
                showingSheet: $showingSheet
            )
        }
    }
}

#Preview {
    NavigationStack {
        AppStoreView()
    }
}
