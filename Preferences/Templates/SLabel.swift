/*
Abstract:
An HStack container for displaying a label with a rounded icon and text.
*/

import SwiftUI

/// An HStack container for displaying a label with a rounded icon and text.
/// 
/// ```swift
/// var body: some View {
///     List {
///         SLabel("Settings", color: Color.gray, icon: "gear")
///     }
/// }
/// ```
///
/// - Parameter text: The `String` name of the label to display.
/// - Parameter color: The `Color` to use as the icon background.
/// - Parameter icon: The `String` name of the image asset or symbol.
/// - Parameter status: The `String` text of the status to display.
/// - Parameter badgeCount: The `Int` count to display as a badge.
struct SLabel: View {
    var text: String
    var color = Color.gray
    var icon = ""
    var status = ""
    var badgeCount = 0
    
    init(_ text: String = "", color: Color = Color.gray, icon: String = "", status: String = "", badgeCount: Int = 0) {
        self.text = text
        self.color = color
        self.icon = icon
        self.status = status
        self.badgeCount = badgeCount
    }
    
    var body: some View {
        HStack(spacing: 15) {
            if badgeCount == 0 {
                IconView(id: text, icon: icon, color: color, iconColor: .white)
            }
            
            Text(text)
            Spacer()
            
            if !status.isEmpty {
                Text(.init(status))
                    .foregroundStyle(.secondary)
            }
            
            if badgeCount > 0 {
                Image(systemName: "\(badgeCount).circle.fill")
                    .foregroundStyle(.white, .red)
                    .imageScale(.large)
            }
        }
    }
}

#Preview {
    ContentView(stateManager: StateManager())
}
