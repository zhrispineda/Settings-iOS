//
//  SystemFontsView.swift
//  Preferences
//
//  Settings > General > Fonts > System Fonts
//

import SwiftUI

struct SystemFontsView: View {
    @State private var searchText = ""
    let path = "/System/Library/PreferenceBundles/FontSettings.bundle"
    
    var body: some View {
        CustomList(title: "System Fonts".localized(path: path), topPadding: true) {
            Section {
                ForEach(UIFont.familyNames, id: \.self) { font in
                    NavigationLink(font) {
                        SystemFontsDetailView(fontName: font)
                    }
                }
            }
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .automatic))
    }
}

#Preview {
    NavigationStack {
        SystemFontsView()
    }
}
