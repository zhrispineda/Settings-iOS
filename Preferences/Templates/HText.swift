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
    
    init(_ title: String = String(), status: String = String()) {
        self.title = title
        self.status = status
    }
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(status)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    HText()
}
