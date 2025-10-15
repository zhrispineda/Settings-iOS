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
    var color: Color
    var path: String
    var icon: String
    var status: String
    var badgeCount: Int
    var selected: Bool
    
    init(_ text: String, color: Color = Color.accent, path: String = "", icon: String = "", status: String = "", badgeCount: Int = 0, selected: Bool = false) {
        self.text = text
        self.color = color
        self.path = path
        self.icon = icon
        self.status = status
        self.badgeCount = badgeCount
        self.selected = selected
    }
    
    var body: some View {
        HStack(spacing: 15) {
            if badgeCount == 0 {
                IconView(id: text, path: path, icon: icon, color: color, iconColor: .white)
            }
            
            Text(text)
                .padding(.leading, icon.isEmpty ? 0 : -6)
            Spacer()
            
            if !status.isEmpty {
                Text(.init(status))
                    .foregroundStyle(.gray)
                    .fontWeight(selected ? .semibold : .none)
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
    ContentView()
}

#Preview("SLabel Example") {
    NavigationStack {
        List {
            SLabel("Example")
            SLabel("Status", color: .green, icon: "checkmark", status: "Accepted")
        }
    }
}
