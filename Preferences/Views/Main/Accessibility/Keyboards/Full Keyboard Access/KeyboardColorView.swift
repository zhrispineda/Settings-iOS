//
//  KeyboardColorView.swift
//  Preferences
//
//  Settings > Accessibility > Keyboards > Full Keyboard Access > Color
//

import SwiftUI

struct KeyboardColorView: View {
    // Variables
    @State private var selected = "DEFAULT"
    let colors = ["DEFAULT", "Gray","White", "BlueColor", "RedColor", "GreenColor", "DISPLAY_FILTER_HUE_YELLOW", "OrangeColor"]
    let table = "Accessibility"
    
    var body: some View {
        CustomList(title: "Color") {
            Section {
                ForEach(colors, id: \.self) { color in
                    Button {
                        selected = color
                    } label: {
                        HStack {
                            if color == "White" {
                                Circle()
                                    .fill(.white)
                                    .stroke(Color["Label"])
                                    .scaledToFit()
                                    .frame(height: 12)
                            } else {
                                Image(systemName: "circle.fill")
                                    .foregroundStyle(Color[color.localize(table: table)])
                                    .font(.caption)
                            }
                            Text(color.localize(table: table))
                                .foregroundStyle(Color["Label"])
                            Spacer()
                            if selected == color {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        KeyboardColorView()
    }
}
