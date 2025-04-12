//
//  TranslateView.swift
//  Preferences
//
//  Settings > Apps > Translate
//

import SwiftUI

struct TranslateView: View {
    // Variables
    @State private var onDeviceModeEnabled = false
    @State private var showingSheet = false
    let table = "TranslationUI"
    
    var body: some View {
        CustomList(title: "TRANSLATE".localize(table: table), topPadding: true) {
            PermissionsView(appName: "TRANSLATE".localize(table: table), background: true, cellular: true, location: false, notifications: false, cellularEnabled: .constant(true))
            
            Section {
                NavigationLink("ON_DEVICE_LANGUAGES_TITLE".localize(table: table), destination: DownloadedLanguagesView())
            } footer: {
                Text("ON_DEVICE_LANGUAGES_DESCRIPTION", tableName: table)
            }
            
            Section {
                Toggle("ON_DEVICE_PREF_NAME".localize(table: table), isOn: $onDeviceModeEnabled)
            } footer: {
                Text("ON_DEVICE_FOOTER", tableName: table)
            }
            
            Section {} footer: {
                Text("[\("PRIVACY_LINK".localize(table: table))](pref://)")
            }
        }
        .onOpenURL { url in
            if url.scheme == "pref" {
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
