//
//  CommunicationSafetyView.swift
//  Preferences
//
//  Settings > Screen Time > Communication Safety
//

import SwiftUI

struct CommunicationSafetyView: View {
    @State private var communicationSafetyEnabled = false
    @State private var improveCommunicationSafety = false
    @State private var showingPrivacySheet = false
    let path = "/System/Library/PrivateFrameworks/ScreenTimeSettingsUI.framework"
    let privacy = "/System/Library/OnBoardingBundles/com.apple.onboarding.improveCommSafety.bundle"
    let table = "ScreenTimeSettingsUI"
    let onTable = "ImproveSensitiveContentWarning"
    
    var body: some View {
        CustomList(title: "CommunicationSafetyTitle".localized(path: path), topPadding: true) {
            Section {
                Toggle("CommunicationSafetyEnableFeatureSpecifierTitle".localized(path: path), isOn: $communicationSafetyEnabled)
            } header: {
                Text("CommunicationSafetyEnableFeatureGroupSpecifierTitle".localized(path: path))
            } footer: {
                Text(.init("CommunicationSafetyEnableFeatureGroupSpecifierFooter".localized(path: path, "[\("CommunicationSafetyLearnMoreFooterLink".localized(path: path))](https://support.apple.com/105069)")))
            }
            
            Section {
                Button("CommunicationSafetyViewResourcesSpecifierTitle".localized(path: path)) {}
            } footer: {
                Text("CommunicationSafetyViewResourcesGroupSpecifierFooter".localized(path: path))
            }
            
            Section {
                Toggle("CommunicationSafetyEnableAnalyticsSpecifierTitle".localized(path: path), isOn: $improveCommunicationSafety)
                    .disabled(!communicationSafetyEnabled)
            } header: {
                Text("CommunicationSafetyAnalyticsGroupSpecifierTitle".localized(path: path))
            } footer: {
                Text(.init("CommunicationSafetyAnalyticsGroupSpecifierFooter".localized(path: path, "[\("BUTTON_TITLE".localized(path: privacy, table: "ImproveCommunicationSafety"))](pref://privacy)")))
            }
        }
        .onOpenURL { url in
            if url.absoluteString == "pref://privacy" {
                showingPrivacySheet.toggle()
            }
        }
        .sheet(isPresented: $showingPrivacySheet) {
            OnBoardingKitView(bundleID: "com.apple.onboarding.improveCommSafety")
        }
    }
}

#Preview {
    NavigationStack {
        CommunicationSafetyView()
    }
}
