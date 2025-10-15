/*
Abstract:
A template for displaying a NavigationLink with a rounded icon and quick information.
*/

import SwiftUI

/// A template for displaying a NavigationLink with a rounded icon and quick information.
///
/// - Parameter text: The `String` name of the link to display.
/// - Parameter routeKey: Optional key to register this destination in RouteRegistry (defaults to `text`).
/// - Parameter color: The `Color` of the icon's background.
/// - Parameter iconColor: The `Color` of the icon.
/// - Parameter path: The `String` bundle path for image lookup (if needed).
/// - Parameter icon: The `String` name of the image asset or symbol.
/// - Parameter lightOnly: If true, force light appearance for the icon.
/// - Parameter subtitle: An optional `String` below the id displaying a short summary.
/// - Parameter status: An optional `String` on the opposing side displaying its current state.
/// - Parameter badgeCount: An optional `Int` on the opposing side displaying a red badge with a number.
/// - Parameter content: The destination `Content` for the route (registered and resolved via RouteRegistry).
struct SLink<Content: View>: View {
    var text: String
    var routeKey: String?
    var color: Color
    var iconColor: Color
    var path: String
    var icon: String
    var lightOnly: Bool
    var subtitle: String
    var status: String
    var badgeCount: Int
    private let destinationBuilder: () -> Content
    
    init(
        _ text: String,
        routeKey: String? = nil,
        color: Color = Color.clear,
        iconColor: Color = Color.white,
        path: String = "",
        icon: String = "",
        lightOnly: Bool = false,
        subtitle: String = "",
        status: String = "",
        badgeCount: Int = 0,
        @ViewBuilder destination: @escaping () -> Content
    ) {
        self.text = text
        self.routeKey = routeKey
        self.color = color
        self.iconColor = iconColor
        self.path = path
        self.icon = icon
        self.lightOnly = lightOnly
        self.subtitle = subtitle
        self.status = status
        self.badgeCount = badgeCount
        self.destinationBuilder = destination
    }
    
    init(
        _ text: String,
        routeKey: String? = nil,
        color: Color = Color.clear,
        iconColor: Color = Color.white,
        path: String = "",
        icon: String = "",
        lightOnly: Bool = false,
        subtitle: String = "",
        status: String = "",
        badgeCount: Int = 0,
        destination: Content
    ) {
        self.text = text
        self.routeKey = routeKey
        self.color = color
        self.iconColor = iconColor
        self.path = path
        self.icon = icon
        self.lightOnly = lightOnly
        self.subtitle = subtitle
        self.status = status
        self.badgeCount = badgeCount
        self.destinationBuilder = { destination }
    }
    
    var body: some View {
        let key = routeKey ?? text
        
        NavigationLink(value: key) {
            HStack(spacing: 15) {
                // Icon
                if icon != "None" {
                    IconView(id: text, path: path, icon: icon, color: color, iconColor: iconColor, lightOnly: lightOnly)
                }
                
                // Title and subtitle text
                VStack(alignment: .leading, spacing: 0) {
                    Text(.init(text))
                    if !subtitle.isEmpty {
                        Text(subtitle)
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                }
                
                // Status text
                if !status.isEmpty {
                    Spacer()
                    if status == "location.fill" {
                        Image(systemName: "location.fill")
                            .foregroundStyle(.gray)
                    } else {
                        Text(.init(status))
                            .foregroundStyle(.secondary)
                    }
                }
                
                // Badge count
                if badgeCount > 0 {
                    Spacer()
                    Image(systemName: "\(badgeCount).circle.fill")
                        .foregroundStyle(.white, .red)
                        .imageScale(.large)
                }
            }
            .frame(height: 15)
        }
        .onAppear {
            RouteRegistry.shared.register(key) { destinationBuilder() }
        }
    }
}

#Preview("ContentView") {
    ContentView()
        .environment(StateManager())
}

#Preview("SLink Example") {
    NavigationStack {
        List {
            SLink("First") { EmptyView() }
            SLink("Second", destination: EmptyView())
            SLink("Third", routeKey: "ThirdRoute") { EmptyView() }
        }
        .navigationDestination(for: String.self) { key in
            RouteRegistry.shared.view(for: key) ?? AnyView(Text("Unknown: \(key)"))
        }
    }
}
