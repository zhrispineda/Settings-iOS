import SwiftUI

/// Returns an Image by obtaining the icon based on UTI or bundle ID.
///
/// ```swift
/// IconView("com.example.app")
/// ```
///
/// - Parameter icon: The `String` identifier of the image asset as a UTI or bundle ID.
///
/// - Note: If no bundle ID matches, it will return a template icon.
///
/// - Note: If no UTI identifier matches, it will return a question mark on a doc icon.
struct IconView: View {
    let icon: String
    
    init(_ icon: String = "") {
        self.icon = icon
    }
    
    var body: some View {
        if icon.hasPrefix("com.apple.graphic")
            || icon.lowercased().hasPrefix("com.apple.a")
            || icon.hasPrefix("com.apple.gamecenter")
            && !UIDevice.IsSimulated {
            if let graphicIcon = UIImage.icon(forUTI: icon) {
                Image(uiImage: graphicIcon)
            }
        } else {
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
