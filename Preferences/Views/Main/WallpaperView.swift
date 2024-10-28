//
//  WallpaperView.swift
//  Preferences
//
//  Settings > Wallpaper
//

import SwiftUI

struct WallpaperView: View {
    // Variables
    let table = "WallpaperSettings"
    
    var body: some View {
        CustomList(title: "WALLPAPER".localize(table: table)) {
            Section {
                Text("CURRENT_TITLE", tableName: table)
                    .textCase(.uppercase)
                    .foregroundStyle(.secondary)
                    .font(.subheadline)
                Button {} label: {
                    Text(Image(systemName: "plus")) + Text("ADD_NEW_WALLPAPER", tableName: table)
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
                        Text("ANIMATED_TIP_TITLE", tableName: table)
                            .bold()
                            .font(.footnote)
                        Text("ANIMATED_TIP_CAPTION", tableName: table)
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
