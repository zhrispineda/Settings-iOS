//
//  WallpaperView.swift
//  Preferences
//
//  Settings > Wallpaper
//

import SwiftUI

struct WallpaperView: View {
    var body: some View {
        CustomList(title: "Wallpaper") {
            Section {
                Text("Current".uppercased())
                    .foregroundStyle(.secondary)
                    .font(.subheadline)
                Button {} label: {
                    Text(Image(systemName: "plus")) + Text("Add New Wallpaper")
                }
                    .font(.caption)
                    .controlSize(.small)
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
            }
            .listRowSeparator(.hidden)
            .frame(maxWidth: .infinity)
            
            Section {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Change your Wallpaper from the Lock Screen")
                            .bold()
                            .font(.footnote)
                        Text("From your Lock Screen, touch and hold to add, edit, or switch between different wallpapers and widgets.")
                            .foregroundStyle(.secondary)
                            .font(.footnote)
                        Spacer()
                    }
                    .padding(.leading, -5)
                    .padding(.top, 5)
                    Spacer()
                        .frame(width: 60)
                }
                .frame(minHeight: 100)
            }
            .listRowBackground(Color(UIColor.systemGray4))
        }
    }
}

#Preview {
    NavigationStack {
        WallpaperView()
    }
}
