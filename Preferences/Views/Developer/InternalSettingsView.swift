//
//  InternalSettingsView.swift
//  Preferences
//

import SwiftUI

struct InternalSettingsView: View {
    var body: some View {
        CustomList(title: "Internal Settings", topPadding: true) {
            Section("Device Info") {
                NavigationLink("About") {}
                Button("Set Up VPN") {}
            }
        }
    }
}

#Preview {
    NavigationStack {
        InternalSettingsView()
    }
}
