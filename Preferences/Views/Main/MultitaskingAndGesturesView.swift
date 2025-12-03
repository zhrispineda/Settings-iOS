//
//  MultitaskingAndGesturesView.swift
//  Preferences
//
//  Settings > Multitasking & Gestures
//

import SwiftUI

struct MultitaskingAndGesturesView: View {
    var body: some View {
        ControllerBridgeView(
                "MultitaskingAndGesturesSettings",
                controller: "MultitaskingAndGesturesSettings",
                title: "Multitasking & Gestures"
            )
    }
}

#Preview {
    NavigationStack {
        MultitaskingAndGesturesView()
    }
}
