//
//  SettingsLink.swift
//  Preferences
//
//  Template for displaying a NavigationLink with a rounded icon and text.
//

import SwiftUI

struct SettingsLink<Content: View>: View {
    let color: Color
    let icon: String
    let id: String
    let content: Content
    
    init(color: Color = Color.clear, icon: String, id: String, @ViewBuilder content: () -> Content) {
        self.color = color
        self.icon = icon
        self.id = id
        self.content = content()
    }
    
    var body: some View {
        NavigationLink(destination: content) {
            HStack(spacing: 15) {
                ZStack {
                    color
                        .frame(width: 30, height: 30)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.white, lineWidth: 0.1))
                    Image(systemName: icon)
                        .imageScale(.large)
                        .foregroundStyle(.white)
                }
                Text(id)
            }
        }
    }
}

#Preview {
    NavigationStack {
        List {
            SettingsLink(color: Color.blue, icon: "clock.fill", id: "Clock", content: {
                EmptyView()
            })
        }
    }
}
