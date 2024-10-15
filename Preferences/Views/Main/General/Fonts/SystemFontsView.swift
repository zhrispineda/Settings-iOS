//
//  SystemFontsView.swift
//  Preferences
//
//  Settings > General > Fonts > System Fonts
//

import SwiftUI

struct SystemFontsView: View {
    // Variables
    @State private var searchText = String()
    let table = "FontSettings"
    
    var body: some View {
        CustomList(title: "SYSTEM_FONTS".localize(table: table), topPadding: true) {
            Section("INSTALLED FONTS".localize(table: table)) {
                ForEach(UIFont.familyNames, id: \.self) { font in
                    NavigationLink(font) {
                        SystemFontsDetailView(fontName: font)
                    }
                }
            }
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        .toolbar {
            EditButton()
                .disabled(true)
        }
    }
}

#Preview {
    NavigationStack {
        SystemFontsView()
    }
}
