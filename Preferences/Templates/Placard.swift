/*
Abstract:
A VStack container that is displayed at the top of lists to summarize common controls to be expected within.
*/

import SwiftUI

/// A `VStack` container that is displayed at the top of lists to summarize common controls to be expected within.
/// ```swift
/// Placard(title: "General", color: Color.gray, icon: "gear", description: "Change common settings including checking for new updates.", frameY: .constant(0.0), opacity: .constant(0.0))
/// ```
/// - Parameter title: The `String` to display as the navigation title of the `View`.
/// - Parameter color: The `Color` of the icon background.
/// - Parameter iconColor: The `Color` of the icon.
/// - Parameter icon: The `String` name of the icon symbol.
/// - Parameter description: The `String` to display as the description below the title.
struct Placard: View {
    // Variables
    var title = String()
    var color = Color.blue
    var iconColor = Color.white
    var icon = String()
    var description = String()
    var lightOnly = false
    @Binding var frameY: Double
    @Binding var opacity: Double
    
    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                IconView(id: title, icon: icon, color: color, iconColor: iconColor, lightOnly: lightOnly)
                    .scaleEffect(2.1)
                    .frame(width: 64, height: 64)
                
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
                Placard(title: "General", color: Color.gray, icon: "gear", description: "Change common settings including checking for new updates.", frameY: .constant(0.0), opacity: .constant(0.0))
            }
        }
    }
}
