//
//  SearchView.swift
//  Preferences
//
//  Settings > Search
//

import SwiftUI

struct SearchView: View {
    private let path = "/System/Library/PrivateFrameworks/SpotlightSettingsSupport.framework"
    
    var body: some View {
        BundleControllerView(
            "\(path)/SpotlightSettingsSupport",
            controller: "SpotlightSettingsController",
            title: "SEARCH".localized(path: path, table: "SpotlightSettings")
        )
    }
}

#Preview {
    NavigationStack {
        SearchView()
    }
}
