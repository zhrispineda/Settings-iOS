//
//  SafetyCheckView.swift
//  Preferences
//
//  Settings > Privacy & Security > Safety Check
//

import SwiftUI

struct SafetyCheckView: View {
    @State private var showingAlert = false
    let path = "/System/Library/PreferenceBundles/DigitalSeparationSettings.bundle"
    
    var body: some View {
        CustomViewController("/System/Library/PreferenceBundles/DigitalSeparationSettings.bundle/DigitalSeparationSettings", controller: "DSSafetyCheckWelcomeController")
            .ignoresSafeArea()
            .navigationTitle("SAFETY_CHECK".localized(path: path))
            .navigationBarTitleDisplayMode(.inline)
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
