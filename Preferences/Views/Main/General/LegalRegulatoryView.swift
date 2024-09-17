//
//  LegalRegulatoryView.swift
//  Preferences
//
//  Settings > General > Legal & Regulatory
//

import SwiftUI

struct LegalRegulatoryView: View {
    var body: some View {
        CustomList(title: "Legal & Regulatory", topPadding: true) {
            Section(UIDevice().model) {
                NavigationLink("Legal Notices") {}
                NavigationLink("License") {}
                NavigationLink("Warranty") {}
                NavigationLink("RF Exposure") {}
            }
            
            Section("Regulatory Certification") {
                Text(String())
            }
        }
    }
}

#Preview {
    NavigationStack {
        LegalRegulatoryView()
    }
}
