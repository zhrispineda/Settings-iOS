//
//  SettingsLink.swift
//  Preferences
//

import SwiftUI

/// A template for displaying a NavigationLink with a rounded icon and quick information.
/// ```swift
/// var body: some View {
///     List {
///         SettingsLink(color: .gray, icon: "gear", id: "Settings", content: {
///             EmptyView()
///         })
///     }
/// }
/// ```
/// - Parameter color: The ``Color`` of the icon's background.
/// - Parameter iconColor: The ``Color`` of the icon.
/// - Parameter icon: The ``String`` name of the image asset or symbol.
/// - Parameter larger: An optional ``Bool`` of whether the icon size should be larger or not.
/// - Parameter id: The ``String`` name of the link to display.
/// - Parameter subtitle: An optional ``String`` below the id displaying a short summary.
/// - Parameter status: An optional ``String`` on the opposing side displaying its current state.
/// - Parameter content: The destination ``Content`` for the NavigationLink.
struct SettingsLink<Content: View>: View {
    let color: Color
    let iconColor: Color
    let icon: String
    let larger: Bool
    let id: String
    let subtitle: String
    let status: String
    let content: Content
    
    init(color: Color = Color.clear, iconColor: Color = Color.white, icon: String, larger: Bool = true, id: String, subtitle: String = String(), status: String = String(), @ViewBuilder content: () -> Content) {
        self.color = color
        self.iconColor = iconColor
        self.icon = icon
        self.larger = larger
        self.id = id
        self.subtitle = subtitle
        self.status = status
        self.content = content()
    }
    
    let noBorders = ["moon.fill"]
    let hierarchyIcons = ["questionmark.app.dashed", "questionmark.square.dashed"]
    
    var body: some View {
        NavigationLink(destination: content) {
            HStack(spacing: 15) {
                ZStack {
                    color
                        .frame(width: 30, height: 30)
                        .clipShape(RoundedRectangle(cornerRadius: 7))
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 0.5))
                    if UIImage(systemName: icon) != nil {
                        switch icon {
                        case "appclip":
                            Image(systemName: icon)
                                .foregroundStyle(.blue)
                                .imageScale(.large)
                        case "eye.trianglebadge.exclamationmark.fill":
                            Image(systemName: icon)
                                .imageScale(.small)
                                .foregroundStyle(iconColor)
                        case "sos":
                            Image(systemName: icon)
                                .imageScale(.small)
                                .foregroundStyle(iconColor)
                        default:
                            Image(systemName: icon)
                                .symbolRenderingMode(hierarchyIcons.contains(icon) ? .hierarchical : .none)
                                .imageScale(larger && !smallerIcons.contains(icon) ? .large : .medium)
                                .fontWeight(icon == "nosign" ? .bold : .regular)
                                .foregroundStyle(iconColor)
                        }
                    } else {
                        switch icon {
                        case "screen-distance.symbol_Normal":
                            Image(icon)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 20)
                        case "logo.bluetooth":
                            Image(icon)
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.white)
                                .frame(height: 24)
                        default:
                        Image(icon)
                            .resizable()
                            .clipShape(RoundedRectangle(cornerRadius: 5.0))
                            .frame(width: 30, height: 30)
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                        }
                    }
                }
                VStack(alignment: .leading) {
                    Text(id)
                        .lineLimit(1)
                    if !subtitle.isEmpty {
                        Text(subtitle)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
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
    NavigationStack {
        List {
            SettingsLink(icon: "applesafari", id: "Safari", content: {
                EmptyView()
            })
            SettingsLink(color: .red, icon: "sos", id: "Emergency SOS", content: {
                EmptyView()
            })
            SettingsLink(color: .blue, icon: "applesiri", id: "Siri", content: {
                EmptyView()
            })
        }
    }
}
