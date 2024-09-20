//
//  FavoritePhrasesView.swift
//  Preferences
//
//  Settings > Accessibility > Live Speech > Phrases
//

import SwiftUI

struct PhrasesView: View {
    var body: some View {
        CustomList(title: "Phrases") {
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
            if !UIDevice.isSimulator {
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
