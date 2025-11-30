//
//  SafetyCheckView.swift
//  Preferences
//
//  Settings > Privacy & Security > Safety Check
//

import SwiftUI

struct SafetyCheckView: View {
    let path = "/System/Library/PreferenceBundles/DigitalSeparationSettings.bundle"
    
    var body: some View {
        BundleControllerView(
            "DigitalSeparationSettings",
            controller: "DSSafetyCheckWelcomeController",
            title: "SAFETY_CHECK".localized(path: path)
        )
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("QUICK_EXIT".localized(path: path)) {
                    exit(0)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SafetyCheckView()
    }
}
