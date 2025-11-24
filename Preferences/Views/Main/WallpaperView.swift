//
//  WallpaperView.swift
//  Preferences
//
//  Settings > Wallpaper
//

import SwiftUI

struct WallpaperView: View {
    var body: some View {
        BundleControllerView(
            "WallpaperSettings",
            controller: "WallpaperSettingsRootViewController",
            title: "Wallpaper"
        )
    }
}

#Preview {
    NavigationStack {
        WallpaperView()
    }
}
