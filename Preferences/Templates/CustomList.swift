//
//  CustomList.swift
//  Preferences
//

import SwiftUI

let defaultPaddingViews = ["Accessibility", "AirPlay Suggestions", "Always Allowed", "App Clips", "App Installations & Purchases", "Apple Advertising", "AppleCare & Warranty", "Apps", "Automatic Updates", "Communication Safety", "Content Restrictions", "Cycling", "Developer", "Dictation Shortcut", "Display", "Downloads", "Driving", "Extensions", "Game Center", "Headphone Audio Levels", "Health", "Language & Region", "Location", "Maps", "Microphone", "News", "Notifications", "Page Zoom", "Photos", "Reader", "Request Desktop Website", "Safari", "Siri Voice", "Sources", "Spoken Responses", "Transit", "TV Provider", "Walking", "Web Content", "WebKit Feature Flags"]

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
    var title: String = String()
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
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .padding(.top, defaultPaddingViews.contains(title) ? 0 : -19)
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
