/*
Abstract:
A Toggle container with a rounded icon next to its label.
*/

import SwiftUI

/// A Toggle container with a rounded icon next to its label.
///
/// ```swift
/// var body: some View {
///     List {
///         IconToggle("Automatic Updates", color: Color.gray, icon: "gear")
///     }
/// }
/// ```
///
/// - Parameter text: The String name of the label to display.
/// - Parameter color: The Color to use as the icon background.
/// - Parameter icon: The String name of the image asset or symbol.
/// - Parameter subtitle: The String text of the subtitle to display.
/// - Parameter iconColor: The Color to use for the icon.
/// - Parameter table: The localization table to use for text.
struct IconToggle: View {
    var text: String
    @Binding var isOn: Bool
    var color: Color
    var icon: String
    var subtitle: String
    var iconColor: Color
    var table: String
    private let lightOnlyIcons: Set<String> = ["airdrop", "shareplay"]
    
    init(_ text: String, isOn: Binding<Bool>, color: Color = Color.clear, icon: String = "", subtitle: String = "", iconColor: Color = Color.white, table: String = "Localizable") {
        self.text = text
        self._isOn = isOn
        self.color = color
        self.icon = icon
        self.subtitle = subtitle
        self.iconColor = iconColor
        self.table = table
    }
    
    var body: some View {
        Toggle(isOn: $isOn) {
            Label {
                Text(LocalizedStringKey(text.localize(table: table)))
                    .padding(.leading, UIDevice.iPhone ? -7 : -1)
                
                if !subtitle.isEmpty {
                    Text(subtitle.localize(table: table))
                        .font(.footnote)
                }
            } icon: {
                IconView(id: text.localize(table: table), icon: icon, color: color, iconColor: icon == "airdrop" ? Color.blue : iconColor, lightOnly: lightOnlyIcons.contains(icon))
                    .padding(.leading, 1)
            }
            .padding(.leading, 5)
        }
    }
}

#Preview {
    ContentView()
        .environment(StateManager())
}
