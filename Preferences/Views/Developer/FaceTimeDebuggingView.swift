//
//  FaceTimeDebuggingView.swift
//  Preferences
//
//  Settings > FaceTime Debugging
//

import SwiftUI

struct FaceTimeDebuggingView: View {
    var body: some View {
        BundleControllerView(
            "ConferenceExternalSettings",
            controller: "CNFExternalListController",
            title: "FaceTime Debugging"
        )
    }
}

#Preview {
    NavigationStack {
        FaceTimeDebuggingView()
    }
}
