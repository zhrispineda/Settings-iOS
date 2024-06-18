//
//  PronunciationsView.swift
//  Preferences
//
//  Settings > Accessibility > Spoken Content > Pronunciations
//

import SwiftUI

struct PronunciationsView: View {
    var body: some View {
        CustomList(title: "Pronounciations") {
            // Empty
        }
        .toolbar {
            NavigationLink(destination: ReplacementView()) {
                Image(systemName: "plus")
            }
        }
    }
}

#Preview {
    NavigationStack {
        PronunciationsView()
    }
}
