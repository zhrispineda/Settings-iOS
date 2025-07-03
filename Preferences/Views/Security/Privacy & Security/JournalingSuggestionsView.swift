//
//  JournalingSuggestionsView.swift
//  Preferences
//
//  Settings > Privacy & Security > Journaling Suggestions
//

import SwiftUI

struct JournalingSuggestionsView: View {
    let path = "/System/Library/PrivateFrameworks/MomentsOnboardingAndSettings.framework"
    
    var body: some View {
        CustomList(title: "JOURNALING_SUGGESTIONS".localize(table: "Privacy")) {
            Button("Turn On Journaling Suggestions".localized(path: path)) {}
        }
    }
}

#Preview {
    NavigationStack {
        JournalingSuggestionsView()
    }
}
