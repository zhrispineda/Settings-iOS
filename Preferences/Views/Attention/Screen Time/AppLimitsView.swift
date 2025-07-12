//
//  AppLimitsView.swift
//  Preferences
//
//  Settings > Screen Time > App Limits
//

import SwiftUI

struct AppLimitsView: View {
    let path = "/System/Library/PrivateFrameworks/ScreenTimeSettingsUI.framework"
    
    var body: some View {
        CustomList(title: "AppAndWebsiteActivityEDUAppLimitsTitle".localized(path: path)) {
            Section {} footer: {
                Text("AppLimitsFooterText".localized(path: path))
            }
            
            Section {
                Button("AddLimitSpecifierName".localized(path: path)) {}
            }
        }
    }
}

#Preview {
    NavigationStack {
        AppLimitsView()
    }
}
