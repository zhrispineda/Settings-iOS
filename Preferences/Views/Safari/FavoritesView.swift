//
//  FavoritesView.swift
//  Preferences
//
//  Settings > Safari > Favorites
//

import SwiftUI

struct FavoritesView: View {
    var body: some View {
        CustomList(title: "Favorites") {
            Section(content: {}, footer: {
                Text("Quickly access Favorite bookmarks when you enter an address, search, or create a new tab.")
            })
            
            Section {
                Button(action: {}, label: {
                    HStack(spacing: 15) {
                        Image(systemName: "folder")
                            .font(.title2)
                            .fontWeight(.light)
                            .foregroundStyle(.blue)
                        Text("Favorites")
                            .tint(Color["Label"])
                        Spacer()
                        Image(systemName: "checkmark")
                    }
                })
            }
        }
    }
}

#Preview {
    NavigationStack {
        FavoritesView()
    }
}
