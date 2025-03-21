/*
Abstract:
An HStack container for displaying a label with a rounded icon and text.
*/

import SwiftUI

/// An HStack container for displaying a label with a rounded icon and text.
/// ```swift
/// var body: some View {
///     List {
///         SettingsLabel(color: Color.gray, icon: "gear", id: "Settings")
///     }
/// }
/// ```
/// - Parameter color: The `Color` to use as the icon background.
/// - Parameter icon: The `String` name of the image asset or symbol.
/// - Parameter id: The `String` name of the label to display.
/// - Parameter status: The `String` text of the status to display.
/// - Parameter badgeCount: The `Int` count to display as a badge.
struct SettingsLabel: View {
    var color = Color.gray
    var icon = String()
    var id = String()
    var status = String()
    var badgeCount = Int()
    
    var body: some View {
        HStack(spacing: 15) {
            if badgeCount == 0 {
                IconView(id: id, icon: icon, color: color, iconColor: .white)
            }
            
            Text(id)
            
            if !status.isEmpty {
                Spacer()
                Text(.init(status))
                    .foregroundStyle(.secondary)
            }
            
            if badgeCount > 0 {
                Image(systemName: "\(badgeCount).circle.fill")
                    .foregroundStyle(.white, .red)
                    .imageScale(.large)
                    .offset(x: 10)
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(StateManager())
}
