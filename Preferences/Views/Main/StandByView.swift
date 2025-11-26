//
//  StandByView.swift
//  Preferences
//
//  Settings > StandBy
//

import SwiftUI

struct StandByView: View {
    var body: some View {
        BundleControllerView(
            "AmbientSettings",
            controller: "AMAmbientSettingsDetailController",
            title: "StandBy"
        )
    }
}

#Preview {
    NavigationStack {
        StandByView()
    }
}
