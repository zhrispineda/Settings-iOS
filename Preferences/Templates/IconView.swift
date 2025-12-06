import SwiftUI

/// An `Image` view of an icon based on its UTI or bundle ID.
///
/// ```swift
/// IconView("com.example.app") // Example Bundle ID
/// IconView("com.example.graphic-icon.name") // Example UTI
/// ```
///
/// - Parameter icon: The `String` identifier of the image asset as a UTI or bundle ID.
///
/// - Note: If no bundle ID matches, it will return a template icon.
///
/// - Note: If no UTI matches, it will return a question mark on a doc icon.
///
/// - Warning: This view makes use of private methods. It is not recommended for public use.
struct IconView: View {
    let icon: String
    private var knownUTIPrefix: Bool {
        let lower = icon.lowercased()
        
        return icon.hasPrefix("com.apple.graphic")
            || lower.hasPrefix("com.apple.a")
            || lower.hasPrefix("com.apple.screen-time")
            || (icon.hasPrefix("com.apple.gamecenter") && !UIDevice.IsSimulated)
    }
    
    init(_ icon: String = "") {
        self.icon = icon
    }
    
    var body: some View {
        if knownUTIPrefix {
            if let graphicIcon = UIImage.icon(forUTI: icon) {
                Image(uiImage: graphicIcon)
            }
        } else if let asset = UIImage.icon(forBundleID: icon) {
            Image(uiImage: asset)
        }
    }
}

#Preview {
    ContentView()
        .environment(PrimarySettingsListModel())
}
