//
//  AppLimitsView.swift
//  Preferences
//
//  Settings > Screen Time > App Limits
//

import SwiftUI

struct AppLimitsView: View {
    var body: some View {
        CustomList(title: "App Limits") {
            Section {} footer: {
                Text("Set daily time limits for app categories you want to manage. Limits reset every day at midnight.")
            }
            
            Section {
                Button("Add Limit") {}
            }
        }
    }
}

#Preview {
    NavigationStack {
        AppLimitsView()
    }
}
