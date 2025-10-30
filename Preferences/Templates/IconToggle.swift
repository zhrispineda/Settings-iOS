import SwiftUI

/// A Toggle container with a rounded icon next to its label.
///
/// ```swift
/// var body: some View {
///     List {
///         IconToggle("Software Updates", icon: "com.apple.graphic-icon.software-update")
///     }
/// }
/// ```
///
/// - Parameter text: The String name of the label to display.
/// - Parameter icon: The String name of the image asset or symbol.
/// - Parameter subtitle: The String text of the subtitle to display.
/// - Parameter table: The localization table to use for text.
struct IconToggle: View {
    var text: String
    @Binding var isOn: Bool
    var icon: String
    var subtitle: String
    var table: String
    
    init(_ text: String, isOn: Binding<Bool>, icon: String = "", subtitle: String = "", table: String = "Localizable") {
        self.text = text
        self._isOn = isOn
        self.icon = icon
        self.subtitle = subtitle
        self.table = table
    }
    
    var body: some View {
        Toggle(isOn: $isOn) {
            Label {
                Text(LocalizedStringKey(text.localize(table: table)))
                    .padding(.leading, UIDevice.iPhone ? -7 : -6)
                
                if !subtitle.isEmpty {
                    Text(subtitle.localize(table: table))
                        .font(.footnote)
                }
            } icon: {
                IconView(icon)
                    .padding(.leading, -6)
            }
            .padding(.leading, 5)
        }
    }
}

#Preview {
    ContentView()
        .environment(PrimarySettingsListModel())
}
