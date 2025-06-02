/*
 Abstract:
 An HStack container for displaying a label and information with a monospace-like format.
 */

import SwiftUI

/// An `HStack` container for displaying a label and information with a monospace-like format.
///
/// ```swift
/// var body: some View {
///     List {
///         MonospacedLabel(title: "Address", status: "01:AB:23:4C:56:78")
///         MonospacedLabel(title: "Version", status: "1.0")
///     }
/// }
/// ```
///
/// - Parameter label: The `String` label text describing the label.
/// - Parameter value: The `String` value to display on the opposing side of the label.
struct MonospacedLabel: View {
    var label: String
    var value: String
    let ignoreChars = ["1", ":", ".", "/"]
    
    init(_ label: String = "", value: String = "") {
        self.label = label
        self.value = value
    }
    
    var body: some View {
        LabeledContent(label) {
            HStack(spacing: 0) {
                ForEach(Array(value.enumerated()), id: \.offset) { _, character in
                    let char = String(character)
                    if ignoreChars.contains(char) {
                        Text(char)
                    } else {
                        Text(char)
                            .fontDesign(.monospaced)
                            .kerning(-0.5)
                    }
                }
            }
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
