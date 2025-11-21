//
//  NewsView.swift
//  Preferences
//
//  Settings > Apps > News
//

import SwiftUI

struct NewsView: View {
    var body: some View {
        BundleControllerView(
            "NewsSettings",
            controller: "FRNewsSettingsController",
            title: "NEWS_SETTINGS_TITLE".localized(path: "/System/Library/PreferenceBundles/NewsSettings.bundle")
        )
    }
}

#Preview {
    NavigationStack {
        NewsView()
    }
}
