//
//  IconToggle.swift
//  Preferences
//

import SwiftUI

/// A template for displaying a toggle and a rounded icon next to a label.
/// ```swift
/// var body: some View {
///     List {
///         IconToggle(color: Color.gray, icon: "gear", title: "Automatic Updates")
///     }
/// }
/// ```
/// - Parameter color: The ``Color`` to use as the icon background.
/// - Parameter icon: The ``String`` name of the image asset or symbol.
/// - Parameter title: The ``String`` name of the label to display.
/// - Parameter subtitle: The ``String`` text of the subtitle to display.
struct IconToggle: View {
    // Variables
    @Binding var enabled: Bool
    var color = Color(.blue)
    var icon = String()
    var title = String()
    var subtitle = String()
    
    var body: some View {
        Toggle(isOn: $enabled) {
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
                            .frame(width: 20)
                            .foregroundStyle(.white)
                            .symbolRenderingMode(hierarchyIcons.contains(icon) ? .hierarchical : .none)
                    } else if internalIcons.contains(icon) {
                        Image(_internalSystemName: icon)
                            .foregroundStyle(icon == "airdrop" ? .blue : .white)
                    } else {
                        Image(icon)
                            .resizable()
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                            .frame(width: 30, height: 30)
                    }
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(LocalizedStringKey(title))
                    if !subtitle.isEmpty {
                        Text(subtitle)
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
