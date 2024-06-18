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
            Section {}
        }
    }
}

#Preview {
    NavigationStack {
        WallpaperView()
    }
}
