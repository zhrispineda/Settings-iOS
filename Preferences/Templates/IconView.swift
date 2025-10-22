import SwiftUI

/// A ZStack structure for creating an icon view; building the background, icon, and overlay.
///
/// ```swift
/// IconView(icon: "wifi", color: Color.blue, iconColor: Color.white)
/// ```
///
/// - Parameter path: The `String` path of a bundle that contains an icon.
/// - Parameter icon: The `String` name of the image asset or symbol.
/// - Parameter color: The `Color` of the background.
/// - Parameter iconColor: The `Color` of the icon itself.
struct IconView: View {
    var id: String = ""
    var path: String = ""
    var icon: String = ""
    
    var body: some View {
        ZStack {
            // Check if `icon` is an image asset or graphic/icon
            if !path.isEmpty && !icon.contains("com.") {
                if let asset = UIImage.asset(path: path, name: icon) {
                    Image(uiImage: asset)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                }
            } else if UIImage(named: icon) != nil {
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
                if let asset = UIImage.icon(forBundleID: icon) {
                    Image(uiImage: asset)
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(PrimarySettingsListModel())
}
