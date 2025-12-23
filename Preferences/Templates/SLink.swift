import SwiftUI

/// A NavigationLink container with icon, title, subtitle, and status options.
///
/// - Parameters:
///   - title: The label of the link.
///   - routeKey: Optional string destination key for RouteRegistry (defaults to the value of `title`).
///   - icon: The icon bundle ID or UTI.
///   - subtitle: Optional text under the title.
///   - status: Optional status text to display on the opposite side of the title.
///   - badgeCount: Optional badge count integer number.
///   - destination: The destination view to push.
struct SLink<Destination: View>: View {
    var title: String
    var routeKey: String?
    var icon: String
    var subtitle: String
    var status: String
    var badgeCount: Int
    private let destinationBuilder: () -> Destination
    
    init(
        _ title: String,
        routeKey: String? = nil,
        icon: String = "",
        subtitle: String = "",
        status: String = "",
        badgeCount: Int = 0,
        @ViewBuilder destination: @escaping () -> Destination
    ) {
        self.title = title
        self.routeKey = routeKey
        self.icon = icon
        self.subtitle = subtitle
        self.status = status
        self.badgeCount = badgeCount
        self.destinationBuilder = destination
    }
    
    init(
        _ title: String,
        routeKey: String? = nil,
        icon: String = "",
        subtitle: String = "",
        status: String = "",
        badgeCount: Int = 0,
        destination: Destination
    ) {
        self.init(
            title,
            routeKey: routeKey,
            icon: icon,
            subtitle: subtitle,
            status: status,
            badgeCount: badgeCount
        ) {
            destination
        }
    }
    
    var body: some View {
        NavigationLink(value: routeKey ?? title) {
            Label {
                LabeledContent {
                    if status == "location.fill" {
                        Image(systemName: status)
                    } else if !status.isEmpty {
                        Text(status)
                            .foregroundStyle(.placeholder)
                    }
                } label: {
                    Text(title)
                    if !subtitle.isEmpty {
                        Text(subtitle)
                    }
                }
            } icon: {
                if !icon.isEmpty {
                    IconView(icon)
                }
            }
            .badge(badgeCount)
            .badgeProminence(.increased)
        }
        .onAppear {
            RouteRegistry.shared.register(routeKey ?? title) { destinationBuilder() }
        }
    }
}

#Preview("ContentView") {
    ContentView()
        .environment(PrimarySettingsListModel())
}

#Preview("SLink Example") {
    NavigationStack {
        List {
            SLink("First") { EmptyView() }
            SLink("Second", status: "Second", destination: EmptyView())
            SLink("Third", icon: "com.apple.Preferences", subtitle: "Third", status: "Third") { EmptyView() }
        }
        .navigationDestination(for: String.self) { key in
            RouteRegistry.shared.view(for: key) ?? AnyView(Text("Unknown: \(key)"))
        }
    }
}
