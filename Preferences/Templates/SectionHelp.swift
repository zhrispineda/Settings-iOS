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
                    .frame(width: 64)
                    .foregroundStyle(UIImage(systemName: icon) != nil || icon == "bluetooth" ? color : .black)
                if UIImage(systemName: icon) != nil {
                    Image(systemName: icon)
                        .font(.system(size: icon == "personalhotspot" ? 30 : 36))
                        .foregroundStyle(icon == "touchid" ? .pink : .white)
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
            Text(title)
                .bold()
                .font(.title3)
            Text(.init(description))
                .font(.footnote)
                .padding(.bottom, -10)
                .padding(.horizontal, -5)
        }
        .padding()
        .multilineTextAlignment(.center)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    NavigationStack {
        List {
            Section {
                SectionHelp(title: "Title", color: Color.blue, icon: "wifi", description: "Description")
            }
        }
    }
}
