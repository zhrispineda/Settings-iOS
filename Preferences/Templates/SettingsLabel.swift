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
    var color: Color = Color.gray
    var icon: String = String()
    var id: String = String()
    var status: String = String()
    
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
                        .resizable()
                        .scaledToFit()
                        .symbolRenderingMode(hierarchyIcons.contains(icon) ? .hierarchical : .none)
                        .foregroundStyle(.white)
                        .frame(width: smallerIcons.contains(icon) ? 15 : 20)
                } else if internalIcons.contains(icon) {
                    Image(_internalSystemName: icon)
                        .foregroundStyle(.white)
                } else {
                    Image(icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                        .foregroundStyle(.white)
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
    ContentView()
}
