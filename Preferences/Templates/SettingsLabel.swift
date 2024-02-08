//
//  SettingsLabel.swift
//  Preferences
//
//  Template for displaying a label with a rounded icon and text.
//

import SwiftUI

let smallerIcons = ["squares.leading.rectangle"]

struct SettingsLabel: View {
    let color: Color
    let icon: String
    let id: String
    
    init(color: Color = Color.clear, icon: String, id: String) {
        self.color = color
        self.icon = icon
        self.id = id
    }
    
    var body: some View {
        HStack(spacing: 15) {
            ZStack {
                color
                    .frame(width: 30, height: 30)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.white, lineWidth: 0.1))
                Image(systemName: icon)
                    .imageScale(smallerIcons.contains(icon) ? .medium : .large)
                    .foregroundStyle(.white)
            }
            Text(id)
        }
    }
}

#Preview {
    NavigationStack {
        List {
            SettingsLabel(color: Color.blue, icon: "clock.fill", id: "Clock")
        }
    }
}
