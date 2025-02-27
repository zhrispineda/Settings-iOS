//
//  CertificateTrustSettingsView.swift
//  Preferences
//
//  Settings > General > About > Certificate Trust Settings
//

import SwiftUI

struct CertificateTrustSettingsView: View {
    // Variables
    let table = "General"
    let uiTable = "GeneralSettingsUI"
    
    var body: some View {
        CustomList(title: "CERT_TRUST_SETTINGS".localize(table: uiTable)) {
            Section {
                LabeledContent("TRUST_STORE_VERSION".localize(table: uiTable), value: "2024051501")
                LabeledContent("TRUST_ASSET_VERSION".localize(table: table), value: "1005")
            } footer: {
                Text("[\("TRUST_STORE_ABOUT".localize(table: table))](\("TRUST_STORE_URL".localize(table: table)))")
            }
        }
    }
}

#Preview {
    NavigationStack {
        CertificateTrustSettingsView()
    }
}
