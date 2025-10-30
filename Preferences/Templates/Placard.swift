import SwiftUI

/// A `VStack` container that is displayed at the top of lists to summarize common controls to be expected below.
///
/// ```swift
/// Placard(title: "General", icon: "com.apple.graphic-icon.gear", description: "Manage common options such as checking for new updates.", frameY: $frameY, opacity: $opacity)
/// ```
///
/// - Parameter title: The `String` to display as the navigation title of the `View`.
/// - Parameter icon: The `String` name of the icon symbol.
/// - Parameter description: The `String` to display as the description below the title.
/// - Parameter frameY: The `Binding` `Double` value to use for calculating the current Y position in the scroll view.
/// - Parameter opacity: The `Binding` `Double` value to use for calculating the opacity of the navigation title.
struct Placard: View {
    var title: String
    var icon = ""
    var description = ""
    var beta = false
    @Binding var frameY: Double
    @Binding var opacity: Double
    
    var body: some View {
        VStack(spacing: 15) {
            ZStack {
                IconView(icon)
                    .scaleEffect(2)
                    .padding(.top, 25)
                
                if beta {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25.0)
                            .frame(width: 40, height: 15)
                            .foregroundStyle(.black)
                        Text("BETA")
                            .font(.caption)
                            .foregroundStyle(.white)
                    }
                    .offset(x: 20, y: 38)
                }
            }
            .accessibilityHidden(true)
            
            Text(title)
                .fontWeight(.bold)
                .font(.title2)
                .padding(.top, 13)
                .padding(.bottom, -4)
            Text(.init(description))
                .font(.footnote)
                .padding(.bottom, 10)
        }
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
                Placard(title: "General", icon: "com.apple.graphic-icon.gear", description: "Manage your overall setup and preferences for iPad, such as software updates, AirDrop, and more.", frameY: .constant(0.0), opacity: .constant(0.0))
            }
        }
    }
}
