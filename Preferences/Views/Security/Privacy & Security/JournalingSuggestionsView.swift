//
//  JournalingSuggestionsView.swift
//  Preferences
//
//  Settings > Privacy & Security > Journaling Suggestions
//

import SwiftUI

struct JournalingSuggestionsView: View {
    private let path = "/System/Library/PrivateFrameworks/MomentsOnboardingAndSettings.framework"
    
    var body: some View {
        CustomList(title: "Journaling Suggestions".localized(path: path)) {
            Button("Turn On Journaling Suggestions".localized(path: path)) {}
        }
    }
}

#Preview {
    NavigationStack {
        JournalingSuggestionsView()
    }
}
