//
//  CertificateTrustSettingsView.swift
//  Preferences
//
//  Settings > General > About > Certificate Trust Settings
//

import SwiftUI

struct CertificateTrustSettingsView: View {
    var body: some View {
        CustomList(title: "Certificate Trust Settings") {
            Section {
                LabeledContent("Trust Store Version", value: "2024051501")
                LabeledContent("Trust Asset Version", value: "1004")
            } footer: {
                Text("[Learn more about trusted certificates](https://support.apple.com/kb/HT5012)")
            }
        }
    }
}

#Preview {
    NavigationStack {
        CertificateTrustSettingsView()
    }
}
