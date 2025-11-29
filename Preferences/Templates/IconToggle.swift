import SwiftUI

/// A Toggle container with an icon and optional subtitle text.
///
/// ```swift
/// var body: some View {
///     List {
///         IconToggle("Software Updates", icon: "com.apple.graphic-icon.software-update")
///     }
/// }
/// ```
///
/// - Parameter title: The label to display.
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
            HStack(spacing: UIDevice.iPhone ? 13.5 : 7.5) {
                IconView(icon)
                    .padding(.leading, -2.5)
                LabeledContent {} label: {
                    Text(title)
                    if !subtitle.isEmpty {
                        Text(subtitle)
                    }
                }
            }
            .frame(height: 20)
        }
    }
}

#Preview {
    ContentView()
        .environment(PrimarySettingsListModel())
}
