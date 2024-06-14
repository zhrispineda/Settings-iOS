//
//  ExtensionsView.swift
//  Preferences
//
//  Settings > Safari > Extensions
//

import SwiftUI

struct ExtensionsView: View {
    var body: some View {
        CustomList(title: "Extensions") {
            Section {} header: {
                Text("\n\nNo Extensions Installed")
            } footer: {
                Text("Extensions customize the way Safari works. Extensions can change the appearance or behavior of web content, add buttons to Safari, and more.")
            }
        }
    }
}

#Preview {
    NavigationStack {
        ExtensionsView()
    }
}
