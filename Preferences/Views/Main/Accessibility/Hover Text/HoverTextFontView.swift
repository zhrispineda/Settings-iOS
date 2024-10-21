//
//  HoverTextFontView.swift
//  Preferences
//
//  Settings > Accessibility > Hover Text > Font
//

import SwiftUI

struct HoverTextFontView: View {
    // Variables
    @State private var selected = "Default"
    let table = "Accessibility"
    
    var body: some View {
        CustomList(title: "HOVER_TEXT_TEXT_STYLE".localize(table: table)) {
            Picker(selection: $selected, label: EmptyView()) {
                ForEach(["DEFAULT".localize(table: table)], id: \.self) { option in
                    Text(option)
                }
            }
            .pickerStyle(.inline)
            
            Picker(selection: $selected, label: EmptyView()) {
                ForEach(UIFont.familyNames, id: \.self) { font in
                    Text(font)
                        .font(Font.custom(font, size: 18))
                }
            }
            .pickerStyle(.inline)
        }
    }
}

#Preview {
    NavigationStack {
        HoverTextFontView()
    }
}
