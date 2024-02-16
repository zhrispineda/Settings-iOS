//
//  IconToggle.swift
//  Preferences
//
//  Toggle with an SF symbol and background icon color.
//

import SwiftUI

struct IconToggle: View {
    // Variables
    @State var enabled = Bool()
    var color = Color(.blue)
    var icon = String()
    var title = String()
    
    var body: some View {
        Toggle(isOn: $enabled, label: {
            HStack(spacing: 15) {
                ZStack {
                    color
                        .frame(width: 30, height: 30)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color(UIColor.label), lineWidth: 0.1))
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
                Text(title)
            }
        })
    }
}

#Preview {
    IconToggle()
}
