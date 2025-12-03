//
//  ContinuityDebuggingView.swift
//  Preferences
//
//  Settings > Continuity Debugging
//

import SwiftUI

struct ContinuityDebuggingView: View {
    var body: some View {
        ControllerBridgeView(
            "IDSExternalSettings",
            controller: "IDSExternalListController",
            title: "Continuity Debugging"
        )
    }
}

#Preview {
    NavigationStack {
        ContinuityDebuggingView()
    }
}
