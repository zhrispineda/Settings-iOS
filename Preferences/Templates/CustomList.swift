/*
Abstract:
A List container that already includes commonly used modifiers.
*/

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
    // Variables
    @State private var isLandscape = false
    var title = ""
    var topPadding = false
    @ViewBuilder let content: Content
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color(UIColor.systemGroupedBackground)
                    .ignoresSafeArea()
                List {
                    content
                }
                .contentMargins(.horizontal, UIDevice.iPhone || geo.size.width < 600 ? nil : (isLandscape ? 175 : 50), for: .scrollContent)
                .navigationTitle(LocalizedStringKey(title))
                .navigationBarTitleDisplayMode(.inline)
                .padding(.top, topPadding ? 0 : -19)
            }
            .onAppear {
                isLandscape = geo.size.width > 800
            }
            .onChange(of: geo.size.width) {
                isLandscape = geo.size.width > 800
            }
        }
    }
}

#Preview {
    ContentView(stateManager: StateManager())
}
