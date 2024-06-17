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
/// - Parameter larger: An optional ``Bool`` of whether the icon size should be larger or not.
/// - Parameter id: The ``String`` name of the link to display.
/// - Parameter subtitle: An optional ``String`` below the id displaying a short summary.
/// - Parameter status: An optional ``String`` on the opposing side displaying its current state.
/// - Parameter content: The destination ``Content`` for the NavigationLink.
struct SettingsLink<Content: View>: View {
    var color: Color = Color.black
    var iconColor: Color = Color.white
    var icon: String = String()
    var larger: Bool = false
    var id: String = String()
    var subtitle: String = String()
    var status: String = String()
    @ViewBuilder var content: Content
    
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
                        default:
                            Image(systemName: icon)
                                .symbolRenderingMode(hierarchyIcons.contains(icon) ? .hierarchical : .none)
                                .imageScale((larger || largerIcons.contains(icon)) && !smallerIcons.contains(icon) ? .large : (smallerIcons.contains(icon) ? .small : .medium))
                                .fontWeight(icon == "nosign" ? .bold : .regular)
                                .foregroundStyle(iconColor)
                        }
                    } else {
                        switch icon {
                        case "screen-distance.symbol_Normal":
                            Image(icon)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 21)
                        case "carplay":
                            Image(icon)
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.white)
                                .frame(height: 21)
                        case "bluetooth":
                            Image(icon)
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.white)
                                .frame(height: 21)
                        default:
                        Image(icon)
                            .resizable()
                            .clipShape(RoundedRectangle(cornerRadius: 5.0))
                            .frame(width: 30, height: 30)
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                        }
                    }
                }
                VStack(alignment: .leading, spacing: -1) {
                    Text(id)
                        .lineLimit(1)
                    if !subtitle.isEmpty {
                        Text(subtitle)
                            .font(.footnote)
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
            SettingsLink(color: .gray, icon: "camera.fill", id: "Settings", subtitle: "Camera") {}
            SettingsLink(color: .green, icon: "faceid", id: "Emergency SOS") {}
        }
    }
}
