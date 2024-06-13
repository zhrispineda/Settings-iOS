//
//  IconToggle.swift
//  Preferences
//

import SwiftUI

/// A template for displaying a toggle with a rounded icon.
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
struct IconToggle: View {
    // Variables
    @Binding var enabled: Bool
    var color = Color(.blue)
    var icon = String()
    var title = String()
    
    var body: some View {
        Toggle(isOn: $enabled) {
            HStack(spacing: 15) {
                ZStack {
                    color
                        .frame(width: 30, height: 30)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color["Label"], lineWidth: 0.1))
                    if UIImage(systemName: icon) != nil {
                        Image(systemName: icon)
                            .imageScale(smallerIcons.contains(icon) ? .medium : .large)
                            .foregroundStyle(.white)
                    } else {
                        Image(icon)
                            .resizable()
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .frame(width: 30, height: 30)
                    }
                }
                Text(title)
            }
        }
    }
}

#Preview {
    List {
        IconToggle(enabled: .constant(false), color: .gray, icon: "gear", title: "Background App Refresh")
    }
}
