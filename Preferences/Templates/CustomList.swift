//
//  CustomList.swift
//  Preferences
//

import SwiftUI

/// A List that is customized to include commonly used properties and adjustments.
/// ```swift
/// var body: some View {
///     CustomList(title: "My Title") {
///         Text("Hello, World!")
///     }
/// }
/// ```
/// - Parameter title: The ``String`` of the inline navigation title
/// - Parameter content: The ``Content`` to display within
struct CustomList<Content: View>: View {
    // Variables
    var title = String()
    var topPadding = false
    @ViewBuilder let content: Content
    @State private var isOnLandscapeOrientation = UIDevice.current.orientation.isLandscape
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea()
            List {
                content
            }
            .contentMargins(.horizontal, Device().isPhone ? nil : (isOnLandscapeOrientation ? 145 : 35), for: .scrollContent)
            .navigationTitle(LocalizedStringKey(title))
            .navigationBarTitleDisplayMode(.inline)
            .padding(.top, topPadding ? 0 : -19)
        }
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
            if !Device().isPhone && UIDevice.current.orientation.rawValue <= 4 {
                isOnLandscapeOrientation = UIDevice.current.orientation.isLandscape
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(Device())
}
