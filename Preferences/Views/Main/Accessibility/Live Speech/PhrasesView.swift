//
//  FavoritePhrasesView.swift
//  Preferences
//
//  Settings > Accessibility > Live Speech > Phrases
//

import SwiftUI

struct PhrasesView: View {
    // Variables
    let table = "Accessibility"
    
    var body: some View {
        CustomList(title: "LIVE_SPEECH_PHRASES".localize(table: table)) {
            NavigationLink {} label: {
                Label("Recent", systemImage: "clock")
                    .foregroundStyle(.primary)
            }
            NavigationLink {} label: {
                Label("Saved", systemImage: "bookmark")
                    .foregroundStyle(.primary)
            }
        }
        .toolbar {
            if !UIDevice.IsSimulator {
                NavigationLink(destination: AddFavoritePhraseView()) {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        PhrasesView()
    }
}
