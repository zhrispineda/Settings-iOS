//
//  JournalingSuggestionsView.swift
//  Preferences
//
//  Settings > Privacy & Security > Journaling Suggestions
//

import SwiftUI

struct JournalingSuggestionsView: View {
    // Variables
    let table = "MomentsOnboardingAndSettings"
    
    var body: some View {
        CustomList(title: "JOURNALING_SUGGESTIONS".localize(table: "Privacy")) {
            Button("Turn On Journaling Suggestions".localize(table: table)) {}
        }
    }
}

#Preview {
    NavigationStack {
        JournalingSuggestionsView()
    }
}
