//
//  FontsView.swift
//  Preferences
//
//  Settings > General > Fonts
//

import SwiftUI

struct FontsView: View {
    var body: some View {
        CustomList(title: "Fonts") {
            NavigationLink("System Fonts", destination: SystemFontsView())
            NavigationLink("My Fonts", destination: MyFontsView())
        }
    }
}

#Preview {
    NavigationStack {
        FontsView()
    }
}
