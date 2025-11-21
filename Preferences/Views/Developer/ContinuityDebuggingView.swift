//
//  ContinuityDebuggingView.swift
//  Preferences
//
//  Settings > Continuity Debugging
//

import SwiftUI

struct ContinuityDebuggingView: View {
    var body: some View {
        BundleControllerView(
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
