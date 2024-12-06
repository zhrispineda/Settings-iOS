/*
Abstract:
A List container that already includes commonly used modifiers.
*/

import SwiftUI

/// A `List` container that already includes commonly used properties and adjustments.
/// ```swift
/// var body: some View {
///     CustomList(title: "My Title") {
///         Text("Hello, World!")
///     }
/// }
/// ```
/// - Parameter title: The String to use as the navigation title.
/// - Parameter topPadding: The optional Bool on whether to use default or reduced top padding.
/// - Parameter content: The Content to display in the container.
struct CustomList<Content: View>: View {
    // Variables
    var title = String()
    var topPadding = false
    @ViewBuilder let content: Content
    @State private var isLandscape = UIDevice.current.orientation.isLandscape
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea()
            List {
                content
            }
            .contentMargins(.horizontal, UIDevice.iPhone ? nil : (isLandscape ? 145 : 35), for: .scrollContent)
            .navigationTitle(LocalizedStringKey(title))
            .navigationBarTitleDisplayMode(.inline)
            .padding(.top, topPadding ? 0 : -19)
        }
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
            // Update orientation variable if device is an iPad
            if UIDevice.iPad && UIDevice.current.orientation.rawValue <= 4 {
                isLandscape = UIDevice.current.orientation.isLandscape
            }
        }
    }
}

#Preview {
    ContentView()
}
