/*
Abstract:
A template for displaying a NavigationLink with a rounded icon and quick information.
*/

import SwiftUI

/// A template for displaying a NavigationLink with a rounded icon and quick information.
///
/// ```swift
/// var body: some View {
///     List {
///         SLink("Settings", color: .gray, icon: "gear") {
///             Text("My Settings")
///         }
///     }
/// }
/// ```
///
/// - Parameter text: The `String` name of the link to display.
/// - Parameter color: The `Color` of the icon's background.
/// - Parameter iconColor: The `Color` of the icon.
/// - Parameter icon: The `String` name of the image asset or symbol.
/// - Parameter subtitle: An optional `String` below the id displaying a short summary.
/// - Parameter status: An optional `String` on the opposing side displaying its current state.
/// - Parameter badgeCount: An optional `Int` on the opposing side displaying a red badge with a number.
/// - Parameter content: The destination `Content` for the `NavigationLink`.
struct SLink<Content: View>: View {
    var text: String
    var color: Color
    var iconColor: Color
    var path: String
    var icon: String
    var lightOnly: Bool
    var subtitle: String
    var status: String
    var badgeCount: Int
    var destination: Content
    
    init(_ text: String, color: Color = Color.clear, iconColor: Color = Color.white, path: String = "", icon: String = "", lightOnly: Bool = false, subtitle: String = "", status: String = "", badgeCount: Int = 0, @ViewBuilder destination: @escaping () -> Content) {
        self.text = text
        self.color = color
        self.iconColor = iconColor
        self.path = path
        self.icon = icon
        self.lightOnly = lightOnly
        self.subtitle = subtitle
        self.status = status
        self.badgeCount = badgeCount
        self.destination = destination()
    }
    
    init(_ text: String, color: Color = Color.clear, iconColor: Color = Color.white, path: String = "", icon: String = "", lightOnly: Bool = false, subtitle: String = "", status: String = "", badgeCount: Int = 0, destination: Content) {
        self.text = text
        self.color = color
        self.iconColor = iconColor
        self.path = path
        self.icon = icon
        self.lightOnly = lightOnly
        self.subtitle = subtitle
        self.status = status
        self.badgeCount = badgeCount
        self.destination = destination
    }
    
    var body: some View {
        NavigationLink(destination: destination) {
            HStack(spacing: 15) {
                // Icon
                if icon != "None" {
                    IconView(id: text, path: path, icon: icon, color: color, iconColor: iconColor, lightOnly: lightOnly)
                }
                
                // Title and subtitle text
                VStack(alignment: .leading, spacing: 0) {
                    Text(.init(text))
                    if !subtitle.isEmpty {
                        Text(subtitle)
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                }
                
                // Status text
                if !status.isEmpty {
                    Spacer()
                    if status == "location.fill" {
                        Image(systemName: "location.fill")
                            .foregroundStyle(.gray)
                    } else {
                        Text(.init(status))
                            .foregroundStyle(.secondary)
                    }
                }
                
                // Badge count
                if badgeCount > 0 {
                    Spacer()
                    Image(systemName: "\(badgeCount).circle.fill")
                        .foregroundStyle(.white, .red)
                        .imageScale(.large)
                }
            }
            .frame(height: 15)
        }
    }
}

#Preview("ContentView") {
    ContentView()
}

#Preview("SLink Example") {
    NavigationStack {
        List {
            SLink("First") {}
            SLink("Second", destination: {})
            SLink("Third", destination: EmptyView())
        }
    }
}
