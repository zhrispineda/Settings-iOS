//
//  FavoritesView.swift
//  Preferences
//
//  Settings > Apps > Safari > Favorites
//

import SwiftUI

struct FavoritesView: View {
    var body: some View {
        CustomList(title: "Favorites") {
            Section {} footer: {
                Text("Quickly access Favorite bookmarks when you enter an address, search, or create a new tab.")
            }
            
            Section {
                Button {} label: {
                    HStack(spacing: 15) {
                        Image(systemName: "folder")
                            .font(.title2)
                            .fontWeight(.light)
                            .foregroundStyle(.blue)
                        Text("Favorites")
                            .foregroundStyle(.text)
                        Spacer()
                        Image(systemName: "checkmark")
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        FavoritesView()
    }
}
