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
    
    var body: some View {
        CustomList(title: "Font") {
            Picker(selection: $selected, label: EmptyView()) {
                ForEach(["Default"], id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.inline)
            
            Picker(selection: $selected, label: EmptyView()) {
                ForEach(UIFont.familyNames, id: \.self) {
                    Text($0)
                        .font(Font.custom($0, size: 18))
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
