//
//  iMessageDebuggingView.swift
//  Preferences
//
//  Settings > iMessage Debugging
//

import SwiftUI

struct iMessageDebuggingView: View {
    var body: some View {
        BundleControllerView(
            "MadridExternalSettings",
            controller: "MadridExternalListController",
            title: "iMessage Debugging"
        )
    }
}

#Preview {
    NavigationStack {
        iMessageDebuggingView()
    }
}
