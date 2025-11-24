//
//  FontsView.swift
//  Preferences
//
//  Settings > General > Fonts
//

import SwiftUI

struct FontsView: View {
    var body: some View {
        BundleControllerView(
            "FontSettings",
            controller: "TopNavigationController",
            title: "Fonts".localized(path: "/System/Library/PreferenceBundles/FontSettings.bundle")
        )
    }
}

#Preview {
    NavigationStack {
        FontsView()
    }
}
