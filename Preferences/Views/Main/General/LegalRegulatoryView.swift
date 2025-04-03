//
//  LegalRegulatoryView.swift
//  Preferences
//
//  Settings > General > Legal & Regulatory
//

import SwiftUI

struct LegalRegulatoryView: View {
    var body: some View {
        CustomViewController(path: "/System/Library/PreferenceBundles/LegalAndRegulatorySettings.bundle/LegalAndRegulatorySettings", controller: "_TtC26LegalAndRegulatorySettings30LegalAndRegulatorySettingsRoot")
            .ignoresSafeArea()
            .navigationTitle("LEGAL_AND_REGULATORY_TITLE".localize(table: "General"))
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        LegalRegulatoryView()
    }
}
