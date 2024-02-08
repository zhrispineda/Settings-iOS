//
//  GeneralView.swift
//  Preferences
//
//  Settings > General
//

import SwiftUI

struct GeneralView: View {
    var body: some View {
        CustomList(title: "General") {
            NavigationLink("About", destination: AboutView())
        }
    }
}

#Preview {
    NavigationStack {
        GeneralView()
    }
}
