/*
Abstract:
A ZStack structure for creating an icon view; building the background, icon, and overlay.
*/

import SwiftUI

/// A ZStack structure for creating an icon view; building the background, icon, and overlay.
///
/// ```swift
/// IconView(icon: "wifi", color: Color.blue, iconColor: Color.white)
/// ```
///
/// - Parameter icon: The `String` name of the image asset or symbol.
/// - Parameter color: The `Color` of the background.
/// - Parameter iconColor: The `Color` of the icon itself.
/// - Parameter lightonly: The `Bool` for whether the icon should always be a light mode icon.
struct IconView: View {
    @Environment(\.colorScheme) private var colorScheme
    let id: String
    let icon: String
    let color: Color
    let iconColor: Color
    var lightOnly: Bool = false
    
    var body: some View {
        ZStack {
            // Icon Background
            if colorScheme == .dark && !icon.contains("com.") {
                Image(systemName: "app.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.gray.opacity(0.20), .black.opacity(0.25)]), startPoint: .top, endPoint: .bottom))
            } else if colorScheme == .light && !icon.contains("com.") {
                Image(systemName: "app.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                    .foregroundStyle(color.gradient)
            }
            
            // Check if icon is an SF Symbol or an image asset
            if UIImage(systemName: icon) != nil || internalIcons.contains(icon) {
                Image(_internalSystemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: smallerIcons.contains(icon) ? (icon == "appletvremote.gen4.fill" ? 8 : 13) : 20)
                    .symbolRenderingMode(hierarchyIcons.contains(icon) ? .hierarchical : multicolorIcons.contains(icon) ? .multicolor : .none)
                    .foregroundStyle(colorScheme == .dark && !UIDevice.IsSimulator && !lightOnly ? color == .black ? .white : color : iconColor)
                    .scaleEffect(CGSize(width: 1.0, height: id == "CAMERA_BUTTON_TITLE".localize(table: "Accessibility-D93") ? -1.0 : 1.0))
            } else if icon.contains("com.apple.graphic") || icon.contains("com.apple.application-") || (icon.contains("com.apple.gamecenter") && !UIDevice.IsSimulated) {
                if let graphicIcon = UIImage.icon(forUTI: icon) {
                    Image(uiImage: graphicIcon)
                }
            } else if icon.contains("com.") {
                if let safariIcon = UIImage.icon(forBundleID: icon) {
                    Image(uiImage: safariIcon)
                }
            } else {
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            }
        }
        .overlay {
            // Add outline around icon background
            if (color == .white || color == .black || colorScheme == .dark) && !icon.contains("com.") {
                RoundedRectangle(cornerRadius: 7)
                    .stroke(colorScheme == .light && color == .white ? Color.black.opacity(0.5) : colorScheme == .dark ? Color.white.opacity(0.5) : Color.black.opacity(0.5), lineWidth: 0.25)
            }
        }
    }
}

#Preview {
    ContentView(stateManager: StateManager())
}
