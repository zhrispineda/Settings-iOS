//
//  SectionHelp.swift
//  Preferences
//
//  Section to explain views
//

import SwiftUI

struct SectionHelp: View {
    // Variables
    var title = String()
    var color = Color.blue
    var icon = String()
    var description = String()
    
    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                Image(systemName: "app.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 56)
                    .foregroundStyle(color)
                if UIImage(systemName: icon) != nil {
                    Image(systemName: icon)
                        .font(.system(size: icon == "personalhotspot" ? 30 : 36))
                        .foregroundStyle(icon == "touchid" ? .pink : .white)
                } else if icon == "bluetooth" {
                    Image(_internalSystemName: "bluetooth")
                        .font(.system(size: 36))
                }
            }
            Text(title)
                .bold()
                .font(.title2)
            Text(.init(description))
                .font(.subheadline)
                .padding(.bottom, -10)
                .padding(.horizontal, -5)
        }
        .padding()
        .multilineTextAlignment(.center)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    SectionHelp(title: "Title", color: Color.blue, icon: "bluetooth", description: "Your description here.")
}
