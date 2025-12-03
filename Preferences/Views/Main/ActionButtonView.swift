//
//  ActionButtonView.swift
//  Preferences
//
//  Settings > Action Button
//

import SwiftUI

struct ActionButtonView: View {
    var body: some View {
        ControllerBridgeView(
            "ActionButtonSettings",
            controller: "ActionButtonSettings"
        )
    }
}

#Preview {
    ActionButtonView()
}
