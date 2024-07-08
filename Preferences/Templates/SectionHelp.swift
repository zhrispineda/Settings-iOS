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
    var iconColor = Color.white
    var icon = String()
    var description = String()
    
    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                Image(systemName: "app.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 64)
                    .foregroundStyle(UIImage(systemName: icon) != nil || icon == "bluetooth" ? color : .black)
                if UIImage(systemName: icon) != nil {
                    Image(systemName: icon)
                        .font(.system(size: icon == "personalhotspot" ? 30 : 42))
                        .foregroundStyle(icon == "touchid" ? .pink : iconColor)
                } else if icon == "bluetooth" {
                    Image(_internalSystemName: icon)
                        .foregroundStyle(.white)
                        .font(.system(size: 36))
                } else {
                    Image(icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 64)
                        .mask {
                            Image(systemName: "app.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 64)
                                .foregroundStyle(.black)
                        }
                }
            }
            .accessibilityHidden(true)
            
            Text(title)
                .bold()
                .font(.title3)
            Text(.init(description))
                .font(.footnote)
                .padding(.bottom, -10)
                .padding(.horizontal, -10)
        }
        .padding()
        .multilineTextAlignment(.center)
        .frame(maxWidth: .infinity)
        .fixedSize(horizontal: false, vertical: true)
    }
}

#Preview {
    NavigationStack {
        List {
            Section {
                SectionHelp(title: "Title", color: Color.blue, icon: "gear", description: "PLACARD_SUBTITLE")
            }
        }
    }
}
