//
//  SettingsLabel.swift
//  Preferences
//
//  Template for displaying a label with a rounded icon and text.
//

import SwiftUI

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
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 0.5))
                if UIImage(systemName: icon) != nil {
                    Image(systemName: icon)
                        .imageScale(smallerIcons.contains(icon) ? .medium : .large)
                        .foregroundStyle(.white)
                } else {
                    Image(icon)
                        .resizable()
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .frame(width: 30, height: 30)
                }
            }
            Text(id)
        }
    }
}

#Preview {
    NavigationStack {
        List {
            SettingsLabel(color: Color.gray, icon: "applesafari", id: "Safari")
            SettingsLabel(color: Color.gray, icon: "gear", id: "Safari")
        }
    }
}
