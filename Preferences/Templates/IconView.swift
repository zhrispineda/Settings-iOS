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
/// - Parameter lightOnly: The `Bool` for whether the icon should always be a light mode icon.
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
            if !lightOnly && colorScheme == .dark && !icon.contains("com.") {
                Image(systemName: "app.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.gray.opacity(0.20), .black.opacity(0.25)]), startPoint: .top, endPoint: .bottom))
            } else if lightOnly || colorScheme == .light && !icon.contains("com.") {
                Image(systemName: "app.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                    .foregroundStyle(color.gradient)
            }
            
            // Check if `icon` is an image asset, graphic/icon, or fallback to symbol
            if UIImage(named: icon) != nil {
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            } else if icon.contains("com.apple.graphic") || icon.lowercased().contains("com.apple.a") || (icon.contains("com.apple.gamecenter") && !UIDevice.IsSimulated) {
                if let graphicIcon = UIImage.icon(forUTI: icon) {
                    Image(uiImage: graphicIcon)
                }
            } else if icon.contains("com.") {
                if let safariIcon = UIImage.icon(forBundleID: icon) {
                    Image(uiImage: safariIcon)
                }
            } else {
                Image(_internalSystemName: icon)
                    .font(.headline)
                    .foregroundStyle(colorScheme == .dark && !lightOnly && color != .black ? color : iconColor)
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
