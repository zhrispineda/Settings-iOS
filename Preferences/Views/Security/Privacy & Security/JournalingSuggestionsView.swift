//
//  JournalingSuggestionsView.swift
//  Preferences
//
//  Settings > Privacy & Security > Journaling Suggestions
//

import SwiftUI

struct JournalingSuggestionsView: View {
    // Variables
    let table = "Privacy"
    
    var body: some View {
        CustomList(title: "JOURNALING_SUGGESTIONS".localize(table: table)) {
            Button("Turn On Journaling Suggestions") {}
        }
    }
}

#Preview {
    NavigationStack {
        JournalingSuggestionsView()
    }
}
