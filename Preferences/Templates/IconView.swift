/*
Abstract:
A ZStack structure for creating an icon view; building the background, icon, and overlay.
*/

import SwiftUI

/// A ZStack structure for creating an icon view; building the background, icon, and overlay.
/// ```swift
/// IconView(icon: "wifi", color: Color.blue, iconColor: Color.white)
/// ```
/// - Parameter icon: The `String` name of the image asset or symbol.
/// - Parameter color: The `Color` of the background.
/// - Parameter iconColor: The `Color` of the icon itself.
struct IconView: View {
    @Environment(\.colorScheme) private var colorScheme
    let id: String
    let icon: String
    let color: Color
    let iconColor: Color
    
    var body: some View {
        ZStack {
            // Icon Background
            if icon == "Placeholder" || colorScheme == .dark && !UIDevice.IsSimulator {
                Image(systemName: "app.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.gray.opacity(0.20), .black.opacity(0.25)]), startPoint: .top, endPoint: .bottom))
            } else {
                Image(systemName: "app.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                    .foregroundStyle(color)
            }
            
            // Check if icon is an SF Symbol or an image asset
            if UIImage(systemName: icon) != nil || internalIcons.contains(icon) {
                Image(_internalSystemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: smallerIcons.contains(icon) ? (icon == "appletvremote.gen4.fill" ? 8 : 13) : 20)
                    .symbolRenderingMode(hierarchyIcons.contains(icon) ? .hierarchical : multicolorIcons.contains(icon) ? .multicolor : .none)
                    .foregroundStyle(colorScheme == .dark ? color == .black ? .white : color : iconColor)
                    .scaleEffect(CGSize(width: 1.0, height: id == "CAMERA_BUTTON_TITLE".localize(table: "Accessibility-D93") ? -1.0 : 1.0))
            } else if icon.contains("custom") {
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: smallerIcons.contains(icon) ? 13 : 20)
                    .foregroundStyle(.gray, .white)
            } else {
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            }
        }
        .overlay(
            // Add outline around icon background
            RoundedRectangle(cornerRadius: 7)
                .stroke(colorScheme == .light && color == .white ? Color.black.opacity(0.2) : colorScheme == .dark ? Color.white.opacity(0.2) : Color.clear, lineWidth: 0.5)
        )
    }
}

#Preview {
    ContentView()
        .environmentObject(StateManager())
}