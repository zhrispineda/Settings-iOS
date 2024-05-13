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
            Section(content: {
                LabeledContent("Trust Store Version", value: "2024040500")
                LabeledContent("Trust Asset Version", value: "1003")
            }, footer: {
                Text("[Learn more about trusted certificates](https://support.apple.com/kb/HT5012)")
            })
        }
    }
}

#Preview {
    NavigationStack {
        CertificateTrustSettingsView()
    }
}
