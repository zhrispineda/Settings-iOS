//
//  DeveloperView.swift
//  Preferences
//
//  Settings > Developer
//

import SwiftUI

struct DeveloperView: View {
    var body: some View {
        ControllerBridgeView(
            "DeveloperSettings",
            controller: "DTSettings",
            title: "Developer"
        )
    }
}

#Preview {
    NavigationStack {
        DeveloperView()
    }
}
