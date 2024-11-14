//
//  Placard.swift
//  Preferences
//
//  Placard notice at the top of views to explain expected functionality of items below
//

import SwiftUI

struct Placard: View {
    // Variables
    var title = String()
    var color = Color.blue
    var iconColor = Color.white
    var icon = String()
    var description = String()
    @Binding var frameY: Double
    @Binding var opacity: Double
    
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
                if title == "Apple Intelligence & Siri" {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25.0)
                            .frame(width: 40, height: 15)
                            .foregroundStyle(.black)
                        Text("BETA")
                            .font(.caption)
                            .foregroundStyle(.white)
                    }
                    .offset(x: 25, y: 26)
                }
            }
            .accessibilityHidden(true)
            
            Text(title)
                .fontWeight(.bold)
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
        .overlay { // For calculating opacity of the principal toolbar item
            GeometryReader { geo in
                Color.clear
                    .onChange(of: geo.frame(in: .scrollView).minY) {
                        frameY = geo.frame(in: .scrollView).minY
                        opacity = frameY / -30
                    }
            }
        }
    }
}

#Preview {
    NavigationStack {
        CustomList(title: "General") {
            Section {
                Placard(title: "General", color: Color.gray, icon: "gear", description: "PLACARD_SUBTITLE", frameY: .constant(0.0), opacity: .constant(0.0))
            }
        }
    }
}
