/*
Abstract:
A NavigationLink template for displaying a NavigationLink with a rounded icon and quick information.
*/

import SwiftUI

/// A NavigationLink template for displaying a NavigationLink with a rounded icon and quick information.
/// ```swift
/// var body: some View {
///     List {
///         SettingsLink(color: .gray, icon: "gear", id: "Settings") {
///             Text("My Settings")
///         }
///     }
/// }
/// ```
/// - Parameter color: The `Color` of the icon's background.
/// - Parameter iconColor: The `Color` of the icon.
/// - Parameter icon: The `String` name of the image asset or symbol.
/// - Parameter id: The `String` name of the link to display.
/// - Parameter subtitle: An optional `String` below the id displaying a short summary.
/// - Parameter status: An optional `String` on the opposing side displaying its current state.
/// - Parameter badgeCount: An optional `Int` on the opposing side displaying a red badge with a number.
/// - Parameter content: The destination `Content` for the `NavigationLink`.
struct SettingsLink<Content: View>: View {
    // Variables
    var color = Color.black
    var iconColor = Color.white
    var icon = String()
    var lightOnly = false
    var id = String()
    var subtitle = String()
    var status = String()
    var badgeCount = Int()
    @ViewBuilder var content: Content
    
    var body: some View {
        NavigationLink(destination: content) {
            HStack(spacing: 15) {
                // Icon
                if icon != "None" {
                    IconView(id: id, icon: icon, color: color, iconColor: iconColor, lightOnly: lightOnly)
                }
                
                // Title and subtitle text
                VStack(alignment: .leading, spacing: 0) {
                    Text(.init(id))
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
        }
    }
}

#Preview {
    ContentView(stateManager: StateManager())
}
