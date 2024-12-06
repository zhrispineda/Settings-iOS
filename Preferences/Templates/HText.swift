/*
Abstract:
An HStack container with title and status text on opposite sides for displaying information.
*/

import SwiftUI

/// An HStack container with title and status text on opposite sides for displaying information.
/// ```swift
/// var body: some View {
///     List {
///         HText(title: "Name", status: "John Appleseed")
///     }
/// }
/// ```
/// - Parameter title: The String text identifying the label.
/// - Parameter status: The String description of the title's state or information.
/// - Parameter monospaced: The Bool for whether the `status` text is monospaced.
struct HText: View {
    var title = String()
    var status = String()
    var monospaced = false
    
    init(_ title: String = String(), status: String = String(), monospaced: Bool = false) {
        self.title = title
        self.status = status
        self.monospaced = monospaced
    }
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(status)
                .foregroundStyle(.secondary)
                .fontDesign(monospaced ? .monospaced : .default)
        }
    }
}

#Preview {
    List {
        HText("ABC", status: "123")
    }
}
