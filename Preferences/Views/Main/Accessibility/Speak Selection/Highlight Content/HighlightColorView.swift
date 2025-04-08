//
//  HighlightColorView.swift
//  Preferences
//
//  Settings > Accessibility > Spoken Content > Highlight Content > Word Color/Sentence Color
//

import SwiftUI

struct HighlightColorView: View {
    // Variables
    var title = String()
    @State private var selected = "DEFAULT"
    let colors = ["DEFAULT", "BlueColor", "DISPLAY_FILTER_HUE_YELLOW", "GreenColor", "PinkColor", "PurpleColor"]
    let table = "Accessibility"
    
    var body: some View {
        CustomList(title: title) {
            Section {
                ForEach(colors, id: \.self) { color in
                    Button {
                        selected = color
                    } label: {
                        HStack {
                            Image(systemName: "circle.fill")
                                .foregroundStyle(.primary)
                                .font(.caption)
                            Text(color.localize(table: table))
                            Spacer()
                            if selected == color {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                    .foregroundStyle(.primary)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        HighlightColorView()
    }
}
