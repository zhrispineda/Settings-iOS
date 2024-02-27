//
//  FavoritePhrasesView.swift
//  Preferences
//
//  Settings > Accessibility > Live Speech > Favorite Phrases
//

import SwiftUI

struct FavoritePhrasesView: View {
    var body: some View {
        CustomList(title: "Favorite Phrases") {
            // Empty
        }
        .toolbar {
            NavigationLink(destination: AddFavoritePhraseView(), label: {
                Image(systemName: "plus")
            })
        }
    }
}

#Preview {
    NavigationStack {
        FavoritePhrasesView()
    }
}
