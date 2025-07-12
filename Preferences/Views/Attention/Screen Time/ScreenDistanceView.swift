//
//  ScreenDistanceView.swift
//  Preferences
//
//  Settings > Screen Time > Screen Distance
//

import SwiftUI

struct ScreenDistanceView: View {
    @State private var screenDistanceEnabled = false
    let path = "/System/Library/PrivateFrameworks/ScreenTimeSettingsUI.framework"
    
    var body: some View {
        CustomList(title: "ScreenDistanceEDUFeatureTitle".localized(path: path)) {
            Section {
                Toggle("ScreenDistanceEDUFeatureTitle".localized(path: path), isOn: $screenDistanceEnabled)
            } footer: {
                Text("ScreenDistanceEnableFeatureGroupSpecifierFooterText".localized(path: path))
            }
        }
    }
}

#Preview {
    NavigationStack {
        ScreenDistanceView()
    }
}
