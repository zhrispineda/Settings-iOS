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
    @Environment(\.colorScheme) var colorScheme
    
    var color = Color.black
    var iconColor = Color.white
    var icon = String()
    var id = String()
    var subtitle = String()
    var status = String()
    var badgeCount = Int()
    @ViewBuilder var content: Content
    
    var body: some View {
        NavigationLink(destination: content) {
            HStack(spacing: 15) {
                if icon != "None" {
                    ZStack {
                        // Background of icon
                        if icon == "Placeholder" && colorScheme == .dark {
                            Image(systemName: "app.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30)
                                .foregroundStyle(.black.gradient)
                        } else {
                            Image(systemName: "app.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30)
                                .foregroundStyle(color)
                        }
                        
                        // Check if icon is an SF Symbol or an image asset
                        if UIImage(systemName: icon) != nil {
                            Image(systemName: icon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: smallerIcons.contains(icon) ? (icon == "appletvremote.gen4.fill" ? 8 : 13) : 20)
                                .symbolRenderingMode(hierarchyIcons.contains(icon) ? .hierarchical : .none)
                                .foregroundStyle(iconColor)
                        } else if icon.contains("custom") {
                            Image(icon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: smallerIcons.contains(icon) ? 13 : 20)
                                .foregroundStyle(.gray, .white)
                        } else if internalIcons.contains(icon) {
                            Image(_internalSystemName: icon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: smallerIcons.contains(icon) ? 13 : 20)
                                .symbolRenderingMode(hierarchyIcons.contains(icon) ? .hierarchical : .none)
                                .foregroundStyle(iconColor)
                                .scaleEffect(CGSize(width: 1.0, height: id == "Camera Control" ? -1.0 : 1.0))
                        } else {
                            Image(icon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30)
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                        }
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(colorScheme == .light && color == .white ? Color.black.opacity(0.2) : Color.clear , lineWidth: 0.5)
                    )
                }
                
                // Title and status text
                VStack(alignment: .leading) {
                    Text(.init(id))
                        .lineLimit(1)
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
                            .lineLimit(1)
                            .foregroundStyle(.secondary)
                    }
                }
                
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
    ContentView()
}
