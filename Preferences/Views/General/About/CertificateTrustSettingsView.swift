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
                HText("Trust Store Version", status: "2023071300")
                HText("Trust Asset Version", status: "1002")
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
