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
    @State private var selected = "Default"
    let colors = ["Default", "Blue", "Yellow", "Green", "Pink", "Purple"]
    
    var body: some View {
        CustomList(title: title) {
            Section {
                ForEach(colors, id: \.self) { color in
                    Button {
                        selected = color
                    } label: {
                        HStack {
                            Image(systemName: "circle.fill")
                                .foregroundStyle(Color[color])
                                .font(.caption)
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
        HighlightColorView()
    }
}
