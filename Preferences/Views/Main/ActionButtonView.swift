//
//  ActionButtonView.swift
//  Preferences
//
//  Settings > Action Button
//

import SwiftUI

struct ActionButtonView: View {
    var body: some View {
        BundleControllerView(
            "ActionButtonSettings",
            controller: "ActionButtonSettings"
        )
    }
}

#Preview {
    ActionButtonView()
}
