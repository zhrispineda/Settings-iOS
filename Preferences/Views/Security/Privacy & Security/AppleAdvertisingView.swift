//
//  AppleAdvertisingView.swift
//  Preferences
//
//  Settings > Privacy & Security > Apple Advertising
//

import SwiftUI

struct AppleAdvertisingView: View {
    @State private var showingPrivacySheet = false
    private let passPath = "/System/Library/PreferenceBundles/PrivacyAndSecuritySettings.bundle"
    private let psuPath = "/System/Library/PrivateFrameworks/Settings/PrivacySettingsUI.framework"
    private let adTable = "AppleAdvertising"
    
    var body: some View {
        CustomList(title: "Apple Advertising".localized(path: passPath), topPadding: true) {
            Section {} header: {
                Text("APPLE_DELIVERED_ADVERTISING".localized(path: psuPath, table: adTable))
            } footer: {
                PSFooterHyperlinkView(
                    footerText: "AD_PRIVACY_FOOTER".localized(
                        path: psuPath,
                        table: adTable,
                        "AD_PRIVACY_FOOTER_LINK".localized(path: psuPath, table: adTable)
                    ),
                    linkText: "AD_PRIVACY_FOOTER_LINK".localized(path: psuPath, table: adTable),
                    onLinkTap: {
                        showingPrivacySheet = true
                    }
                )
            }
            
            Section {
                Button("VIEW_AD_TARGETING_INFORMATION".localized(path: psuPath, table: adTable)) {}
            } footer: {
                Text("VIEW_AD_TARGETING_INFORMATION_FOOTER".localized(path: psuPath, table: adTable))
            }
            
            Section {} footer: {
                Text("PERSONALIZED_ADS_NO_CONSENT".localized(path: psuPath, table: adTable))
            }
        }
        .sheet(isPresented: $showingPrivacySheet) {
            OBPrivacySplashController(bundleID: "com.apple.onboarding.advertising")
        }
    }
}

#Preview {
    NavigationStack {
        AppleAdvertisingView()
    }
}
