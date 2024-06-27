//
//  SettingsLabel.swift
//  Preferences
//

import SwiftUI

/// A template for displaying a label with a rounded icon and text.
/// ```swift
/// var body: some View {
///     List {
///         SettingsLabel(color: Color.gray, icon: "gear", id: "Settings")
///     }
/// }
/// ```
/// - Parameter color: The ``Color`` to use as the icon background.
/// - Parameter icon: The ``String`` name of the image asset or symbol.
/// - Parameter id: The ``String`` name of the label to display.
/// - Parameter status: The ``String`` name of the status to display.
struct SettingsLabel: View {
    let color: Color
    let icon: String
    let id: String
    let status: String
    
    let internalIcons = ["apple.photos", "bluetooth"]
    
    init(color: Color = Color.clear, icon: String, id: String, status: String = String()) {
        self.color = color
        self.icon = icon
        self.id = id
        self.status = status
    }
    
    var body: some View {
        HStack(spacing: 15) {
            ZStack {
                Image(systemName: "app.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                    .foregroundStyle(color)
                if UIImage(systemName: icon) != nil {
                    Image(systemName: icon)
                        .symbolRenderingMode(icon == "faceid" ? .hierarchical : nil)
                        .foregroundStyle(.white)
                } else {
                    if internalIcons.contains(icon) {
                        Image(_internalSystemName: icon)
                            .foregroundStyle(.white)
                    } else {
                        Image(icon)
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .foregroundStyle(.white)
                            .frame(width: 30)
                    }
                }
            }
            Text(id)
            if !status.isEmpty {
                Spacer()
                Text(status)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    List {
        SettingsLabel(color: Color.gray, icon: "appleSafari", id: "Safari")
        SettingsLabel(color: Color.gray, icon: "bluetooth", id: "Bluetooth")
        SettingsLabel(color: Color.gray, icon: "battery.100percent", id: "Battery")
    }
}
