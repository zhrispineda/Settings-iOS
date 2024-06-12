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
                color
                    .frame(width: 56, height: 56)
                    .clipShape(RoundedRectangle(cornerRadius: 13.0))
                Image(systemName: icon)
                    .font(.system(size: 36))
                    .foregroundStyle(.white)
            }
            Text(title)
                .bold()
                .font(.title2)
            Text(description)
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
    SectionHelp(title: "General", color: Color.gray, icon: "gear", description: "Manage your overall setup and preferences for \(DeviceInfo().model), such as software updates, device language\(DeviceInfo().isPhone ? ", CarPlay" : ""), AirDrop, and more.")
}
