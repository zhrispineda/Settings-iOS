//
//  IconToggle.swift
//  Preferences
//

import SwiftUI

/// A template for displaying a toggle with a rounded icon.
/// ```swift
/// var body: some View {
///     List {
///         IconToggle(color: Color.gray, icon: "gear", title: "Automatic Updates")
///     }
/// }
/// ```
/// - Parameter color: The ``Color`` to use as the icon background.
/// - Parameter icon: The ``String`` name of the image asset or symbol.
/// - Parameter title: The ``String`` name of the label to display.
/// - Parameter subtitle: The ``String`` text of the subtitle to display.
struct IconToggle: View {
    // Variables
    @Binding var enabled: Bool
    var color = Color(.blue)
    var icon = String()
    var title = String()
    var subtitle = String()
    
    var body: some View {
        Toggle(isOn: $enabled) {
            HStack(spacing: 10) {
                ZStack {
                    Image(systemName: "app.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                        .foregroundStyle(color)
                    if UIImage(systemName: icon) != nil {
                        Image(systemName: icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18)
                            .foregroundStyle(.white)
                            .symbolRenderingMode(icon == "faceid" ? .hierarchical : nil)
                    } else {
                        if icon == "airdrop" {
                            Image(_internalSystemName: icon)
                                .foregroundStyle(.blue)
                        } else if icon == "network.connected.to.line.below" {
                            Image(_internalSystemName: icon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 18)
                                .foregroundStyle(.white)
                        } else {
                            Image(icon)
                                .resizable()
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                                .frame(width: 30, height: 30)
                        }
                    }
                }
                VStack(alignment: .leading, spacing: -3) {
                    Text(title)
                    if !subtitle.isEmpty {
                        Text(subtitle)
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
    }
}

#Preview {
    List {
        IconToggle(enabled: .constant(false), color: .gray, icon: "airplane", title: "Passwords", subtitle: "Passkeys, passwords, and codes")
        IconToggle(enabled: .constant(false), color: .blue, icon: "network.connected.to.line.below", title: "VPN")
        IconToggle(enabled: .constant(false), color: .blue, icon: "key.fill", title: "VPN")
    }
}
