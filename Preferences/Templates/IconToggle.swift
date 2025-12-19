import SwiftUI

/// A Toggle and Label container with an icon, title, and optional subtitle text.
///
/// ```swift
/// var body: some View {
///     List {
///         IconToggle(
///             "Software Updates",
///             isOn: $enabled,
///             icon: "com.apple.graphic-icon.software-update",
///             subtitle: "Keeps your device up to date and secure."
///         )
///     }
/// }
/// ```
///
/// - Parameter title: The label to display.
/// - Parameter isOn: Binding for the toggle.
/// - Parameter icon: The identifier of the icon to display.
/// - Parameter subtitle: The text to display under the title.
struct IconToggle: View {
    var title: String
    @Binding var isOn: Bool
    var icon: String
    var subtitle: String
    
    init(
        _ title: String,
        isOn: Binding<Bool>,
        icon: String,
        subtitle: String = ""
    ) {
        self.title = title
        self._isOn = isOn
        self.icon = icon
        self.subtitle = subtitle
    }
    
    var body: some View {
        Toggle(isOn: $isOn) {
            Label {
                Text(.init(title))
                if !subtitle.isEmpty {
                    Text(.init(subtitle))
                }
            } icon: {
                if !icon.isEmpty {
                    IconView(icon)
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(PrimarySettingsListModel())
}
