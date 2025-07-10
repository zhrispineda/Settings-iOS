//
//  TranslateView.swift
//  Preferences
//
//  Settings > Apps > Translate
//

import SwiftUI

struct TranslateView: View {
    @State private var onDeviceModeEnabled = false
    @State private var showingSheet = false
    let path = "/System/Library/PrivateFrameworks/TranslationUI.framework"
    
    var body: some View {
        CustomList(title: "TRANSLATE".localized(path: path), topPadding: true) {
            PermissionsView(appName: "TRANSLATE".localized(path: path), background: true, cellular: true, location: false, notifications: false, cellularEnabled: .constant(true))
            
            Section {
                NavigationLink("ON_DEVICE_LANGUAGES_TITLE".localized(path: path), destination: DownloadedLanguagesView())
            } footer: {
                Text("ON_DEVICE_LANGUAGES_DESCRIPTION".localized(path: path))
            }
            
            Section {
                Toggle("ON_DEVICE_PREF_NAME".localized(path: path), isOn: $onDeviceModeEnabled)
            } footer: {
                Text("ON_DEVICE_FOOTER".localized(path: path))
            }
            
            Section {} footer: {
                Text("[\("PRIVACY_LINK".localized(path: path))](pref://translate)")
            }
        }
        .onOpenURL { url in
            if url.absoluteString == "pref://translate" {
                showingSheet = true
            }
        }
        .sheet(isPresented: $showingSheet) {
            OnBoardingKitView(bundleID: "com.apple.onboarding.translate")
                .ignoresSafeArea()
        }
    }
}

#Preview {
    NavigationStack {
        TranslateView()
    }
}
