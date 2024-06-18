//
//  KeyboardColorView.swift
//  Preferences
//
//  Settings > Accessibility > Keyboards > Full Keyboard Access > Color
//

import SwiftUI

struct KeyboardColorView: View {
    // Variables
    @State private var selected = "Default"
    let colors = ["Default", "Gray","White", "Blue", "Red", "Green", "Yellow", "Orange"]
    
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
                                    .foregroundStyle(Color[color])
                                    .font(.caption)
                            }
                            Text(color)
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
