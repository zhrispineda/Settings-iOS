//
//  HText.swift
//  Preferences
//

import SwiftUI

/// A template for an HStack with title and status text on opposing sides of a row.
/// ```swift
/// var body: some View {
///     List {
///         HText(title: "Name", status: "John Appleseed")
///     }
/// }
/// ```
/// - Parameter title: The ``String`` main text describing the label.
/// - Parameter status: The ``String`` description of a state of a destination's controls.
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
