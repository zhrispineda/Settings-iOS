//
//  WallpaperView.swift
//  Preferences
//
//  Settings > Wallpaper
//

import SwiftUI

struct WallpaperView: View {
    var body: some View {
        ControllerBridgeView(
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
