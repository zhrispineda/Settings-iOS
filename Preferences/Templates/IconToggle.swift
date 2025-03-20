/*
Abstract:
A Toggle container with a rounded icon next to its label.
*/

import SwiftUI

/// A Toggle container with a rounded icon next to its label.
/// ```swift
/// var body: some View {
///     List {
///         IconToggle(color: Color.gray, icon: "gear", title: "Automatic Updates")
///     }
/// }
/// ```
/// - Parameter color: The Color to use as the icon background.
/// - Parameter icon: The String name of the image asset or symbol.
/// - Parameter title: The String name of the label to display.
/// - Parameter subtitle: The String text of the subtitle to display.
/// - Parameter iconColor: The Color to use for the icon.
/// - Parameter table: The localization table to use for text.
struct IconToggle: View {
    // Variables
    @Binding var enabled: Bool
    var color = Color.blue
    var icon = String()
    var title = String()
    var subtitle = String()
    var iconColor = Color.white
    var table = "Localizable"
    let lightOnlyIcons = ["airdrop", "shareplay"]
    
    var body: some View {
        Toggle(isOn: $enabled) {
            HStack(spacing: 15) {
                IconView(id: title, icon: icon, color: color, iconColor: icon == "airdrop" ? Color.blue : iconColor, lightOnly: lightOnlyIcons.contains(icon))
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(LocalizedStringKey(title.localize(table: table)))
                    
                    if !subtitle.isEmpty {
                        Text(subtitle.localize(table: table))
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        CustomList(title: "Networking") {
            IconToggle(enabled: .constant(true), color: .blue, icon: "questionmark.circle", title: "LIVE_ACTIVITIES", subtitle: "Example", table: "PSSystemPolicy")
        }
    }
}
