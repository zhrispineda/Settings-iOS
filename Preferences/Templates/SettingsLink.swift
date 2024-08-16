//
//  SettingsLink.swift
//  Preferences
//

import SwiftUI

/// A template for displaying a NavigationLink with a rounded icon and quick information.
/// ```swift
/// var body: some View {
///     List {
///         SettingsLink(color: .gray, icon: "gear", id: "Settings") {
///             Text("My Settings")
///         }
///     }
/// }
/// ```
/// - Parameter color: The ``Color`` of the icon's background.
/// - Parameter iconColor: The ``Color`` of the icon.
/// - Parameter icon: The ``String`` name of the image asset or symbol.
/// - Parameter id: The ``String`` name of the link to display.
/// - Parameter subtitle: An optional ``String`` below the id displaying a short summary.
/// - Parameter status: An optional ``String`` on the opposing side displaying its current state.
/// - Parameter content: The destination ``Content`` for the NavigationLink.
struct SettingsLink<Content: View>: View {
    // Variables
    @Environment(\.colorScheme) var colorScheme
    
    var color: Color = Color.black
    var iconColor: Color = Color.white
    var icon: String = String()
    var id: String = String()
    var subtitle: String = String()
    var status: String = String()
    @ViewBuilder var content: Content
    
    var body: some View {
        NavigationLink(destination: content) {
            HStack(spacing: 15) {
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
                    } else {
                        Image(icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                    }
                }
                
                // Title and status text
                VStack(alignment: .leading, spacing: -1) {
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
                        Text(status)
                            .lineLimit(1)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
