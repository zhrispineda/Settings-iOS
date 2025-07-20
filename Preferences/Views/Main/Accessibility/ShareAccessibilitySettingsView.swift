//
//  ShareAccessibilitySettingsView.swift
//  Preferences
//
//  Settings > Accessibility > Share Accessibility Settings
//

import SwiftUI

struct ShareAccessibilitySettingsView: View {
    let path = "/System/Library/PrivateFrameworks/AccessibilitySettingsUI.framework"
    let table = "AccessibilitySettingsUI"
    
    var body: some View {
        CustomList(title: "GUEST_PASS_TITLE".localized(path: path, table: table)) {
            Section {
                Toggle("GUEST_PASS_SYNC_TO_ICLOUD".localized(path: path, table: table), isOn: .constant(false))
                    .disabled(true)
            } footer: {
                Text("GUEST_PASS_SYNC_TO_ICLOUD_FOOTER".localized(path: path, table: table))
            }
            
            Section {
                Button("GUEST_PASS_TITLE".localized(path: path, table: table)) {}
            } footer: {
                Text("[\("GUEST_PASS_LEARN_MORE".localized(path: path, table: table))](#)")
                    .font(.subheadline)
            }
        }
    }
}

#Preview {
    NavigationStack {
        ShareAccessibilitySettingsView()
    }
}
