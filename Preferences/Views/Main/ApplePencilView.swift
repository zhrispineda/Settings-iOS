//
//  ApplePencilView.swift
//  Preferences
//
//  Settings > Apple Pencil
//

import SwiftUI

struct ApplePencilView: View {
    var body: some View {
        ControllerBridgeView(
            "PencilSettings",
            controller: "PencilSettingsController",
            title: "Apple Pencil"
        )
    }
}

#Preview {
    NavigationStack {
        ApplePencilView()
    }
}
