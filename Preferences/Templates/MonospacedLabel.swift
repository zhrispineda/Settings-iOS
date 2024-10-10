//
//  MonospacedLabel.swift
//  Preferences
//

/// An HStack container for displaying a label and information with a monospace-like format.
/// ```swift
/// var body: some View {
///     List {
///         MonospacedLabel(title: "Address", status: "01:AB:23:4C:56:78")
///         MonospacedLabel(title: "Version", status: "1.0")
///
///     }
/// }
/// ```
/// - Parameter label: The ``String`` label text describing the label.
/// - Parameter value: The ``String`` value to display on the opposing side of the label.

import SwiftUI

struct MonospacedLabel: View {
    var label = String()
    var value = String()
    let ignoreChars = ["1", ":", ".", "/"]
    
    init(_ label: String = String(), value: String = String()) {
        self.label = label
        self.value = value
    }
    
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            HStack(spacing: 0) {
                ForEach(value.map { String($0) }, id: \.self) { character in
                    if ignoreChars.contains(character) {
                        Text(character)
                    } else {
                        Text(character)
                            .fontDesign(.monospaced)
                            .kerning(-0.5)
                    }
                }
            }
            .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    NavigationStack {
        CustomList(title: "MonospacedLabel Example") {
            MonospacedLabel("Label", value: "MMX53LL/A")
        }
    }
}
