import SwiftUI

/// Returns an Image by obtaining the icon based on UTI or bundle ID.
///
/// ```swift
/// IconView(icon: "com.app", iconColor: Color.white)
/// ```
///
/// - Parameter path: The `String` path of a bundle that contains an icon.
/// - Parameter icon: The `String` identifier of the image asset as a UTI or bundle ID.
struct IconView: View {
    let path: String
    let icon: String
    
    init(path: String = "", icon: String = "") {
        self.path = path
        self.icon = icon
    }
    
    var body: some View {
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
        } else if icon.hasPrefix("com.apple.graphic") || icon.hasPrefix("com.apple.a") || icon.hasPrefix("com.apple.gamecenter") && !UIDevice.IsSimulated {
            if let graphicIcon = UIImage.icon(forUTI: icon) {
                Image(uiImage: graphicIcon)
            }
        } else if icon.hasPrefix("com.") {
            if let asset = UIImage.icon(forBundleID: icon) {
                Image(uiImage: asset)
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(PrimarySettingsListModel())
}
