//
//  JournalingSuggestionsView.swift
//  Preferences
//
//  Settings > Privacy & Security > Journaling Suggestions
//

import SwiftUI

struct JournalingSuggestionsView: View {
    let path = "/System/Library/PrivateFrameworks/MomentsOnboardingAndSettings.framework"
    let privacy = "/System/Library/PreferenceBundles/PrivacyAndSecuritySettings.bundle"
    
    var body: some View {
        CustomList(title: "Journaling Suggestions".localize(table: privacy)) {
            Button("Turn On Journaling Suggestions".localized(path: path)) {}
        }
    }
}

#Preview {
    NavigationStack {
        JournalingSuggestionsView()
    }
}
