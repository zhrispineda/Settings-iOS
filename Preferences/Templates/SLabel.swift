import SwiftUI

/// A Label plus LabeledContent container for displaying a title, icon, status, and badge count.
///
/// ```swift
/// var body: some View {
///     List {
///         SLabel("Settings", icon: "com.apple.graphic-icon.gear")
///     }
/// }
/// ```
///
/// - Parameter title: The `String` name of the label to display.
/// - Parameter icon: The `String` name of the image asset or symbol.
/// - Parameter status: The `String` text of the status to display.
/// - Parameter badgeCount: The `Int` count to display as a badge.
struct SLabel: View {
    var title: String
    var icon: String
    var status: String
    var badgeCount: Int
    var selected: Bool
    
    init(
        _ title: String,
        icon: String = "",
        status: String = "",
        badgeCount: Int = 0,
        selected: Bool = false
    ) {
        self.title = title
        self.icon = icon
        self.status = status
        self.badgeCount = badgeCount
        self.selected = selected
    }
    
    var body: some View {
        Label {
            LabeledContent {
                if !status.isEmpty {
                    Text(.init(status))
                        .foregroundStyle(.placeholder)
                        .fontWeight(selected ? .semibold : .none)
                }
            } label: {
                if title == "FOLLOWUP_TITLE" {
                    Text(title.localized(
                        path: "/System/Library/PrivateFrameworks/SetupAssistant.framework",
                        table: "FollowUp")
                    )
                } else {
                    Text(.init(title))
                }
            }
        } icon: {
            if title != "FOLLOWUP_TITLE" {
                IconView(icon)
            }
        }
        .badge(badgeCount)
        .badgeProminence(.increased)
    }
}

#Preview("SLabel Example") {
    NavigationStack {
        List {
            SLabel("Safari", icon: "com.apple.mobilesafari", status: "Installed")
            SLabel("General", icon: "com.apple.Preferences", badgeCount: 1)
        }
    }
}

#Preview {
    ContentView()
        .environment(PrimarySettingsListModel())
}
