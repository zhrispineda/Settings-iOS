//
//  AppLimitsView.swift
//  Preferences
//
//  Settings > Screen Time > App Limits
//

import SwiftUI

struct AppLimitsView: View {
    // Variables
    let table = "ScreenTimeSettingsUI"
    
    var body: some View {
        CustomList(title: "AppAndWebsiteActivityEDUAppLimitsTitle".localize(table: table)) {
            Section {} footer: {
                Text("AppLimitsFooterText", tableName: table)
            }
            
            Section {
                Button("AddLimitSpecifierName".localize(table: table)) {}
            }
        }
    }
}

#Preview {
    NavigationStack {
        AppLimitsView()
    }
}
