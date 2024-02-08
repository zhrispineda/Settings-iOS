//
//  AboutView.swift
//  Preferences
//
//  Settings > General > About
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        CustomList(title: "About") {
            HRowLabels(title: "Name", subtitle: UIDevice().localizedModel)
        }
    }
}

#Preview {
    NavigationStack {
        AboutView()
    }
}
