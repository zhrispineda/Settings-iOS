//
//  FontsView.swift
//  Preferences
//
//  Settings > General > Fonts
//

import SwiftUI

struct FontsView: View {
    // Variables
    let table = "FontSettings"
    
    var body: some View {
        CustomList(title: "FONT_SETTING_TITLE_PLURAL".localize(table: table)) {
            NavigationLink("SYSTEM_FONTS".localize(table: table), destination: SystemFontsView())
            NavigationLink("MY_FONTS".localize(table: table), destination: MyFontsView())
        }
    }
}

#Preview {
    NavigationStack {
        FontsView()
    }
}
