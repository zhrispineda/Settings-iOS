//
//  AppleAdvertisingView.swift
//  Preferences
//
//  Settings > Privacy & Security > Apple Advertising
//

import SwiftUI

struct AppleAdvertisingView: View {
    @State private var showingPrivacySheet = false
    let privacy = "/System/Library/PreferenceBundles/PrivacyAndSecuritySettings.bundle"
    let path = "/System/Library/PrivateFrameworks/Settings/PrivacySettingsUI.framework"
    let table = "AppleAdvertising"
    
    var body: some View {
        CustomList(title: "Apple Advertising".localized(path: privacy), topPadding: true) {
            Section {} header: {
                Text("APPLE_DELIVERED_ADVERTISING".localized(path: path, table: table))
            } footer: {
                Text(.init("AD_PRIVACY_FOOTER".localized(path: path, table: table, "[\("AD_PRIVACY_FOOTER_LINK".localized(path: path, table: table))](pref://privacy)")))
            }
            
            Section {
                Button("VIEW_AD_TARGETING_INFORMATION".localized(path: path, table: table)) {}
            } footer: {
                Text("VIEW_AD_TARGETING_INFORMATION_FOOTER".localized(path: path, table: table))
            }
            
            Section {} footer: {
                Text("PERSONALIZED_ADS_NO_CONSENT".localized(path: path, table: table))
            }
        }
        .onOpenURL { url in
            if url.absoluteString == "pref://privacy" {
                showingPrivacySheet.toggle()
            }
        }
        .sheet(isPresented: $showingPrivacySheet) {
            OnBoardingKitView(bundleID: "com.apple.onboarding.advertising")
        }
    }
}

#Preview {
    NavigationStack {
        AppleAdvertisingView()
    }
}
