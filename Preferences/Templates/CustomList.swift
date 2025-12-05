import SwiftUI

/// A `List` container that includes commonly used properties and adjustments.
///
/// ```swift
/// var body: some View {
///     CustomList(title: "My Title") {
///         Text("Hello, World!")
///     }
/// }
/// ```
///
/// - Parameter title: The String to use as the navigation title.
/// - Parameter topPadding: The optional Bool on whether to use default or reduced top padding.
/// - Parameter content: The Content to display in the container.
struct CustomList<Content: View>: View {
    var title = ""
    var topPadding = false
    @ViewBuilder let content: Content
    
    var body: some View {
        List {
            content
        }
        .navigationTitle(LocalizedStringKey(title))
        .navigationBarTitleDisplayMode(.inline)
        .padding(.top, topPadding ? 0 : -17.5)
        .padding(.horizontal, UIDevice.iPad ? -4 : 0)
        .navigationDestination(for: String.self) { key in
            RouteRegistry.shared.view(for: key)
        }
    }
}

#Preview {
    NavigationStack {
        GeneralView()
    }
}
