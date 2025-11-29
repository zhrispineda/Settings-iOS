import SwiftUI

/// A template for displaying a NavigationLink with a rounded icon and quick information.
///
/// - Parameter title: The label of the link.
/// - Parameter routeKey: Optional key to register this destination in RouteRegistry (defaults to the value of `title`).
/// - Parameter icon: The `String` name of the image asset or symbol.
/// - Parameter subtitle: An optional `String` below the id displaying a short summary.
/// - Parameter status: An optional `String` on the opposing side displaying its current state.
/// - Parameter destination: The destination `Content` for the route (registered and resolved via RouteRegistry).
struct SLink<Content: View>: View {
    var title: String
    var routeKey: String?
    var icon: String
    var subtitle: String
    var status: String
    private let destinationBuilder: () -> Content
    
    init(
        _ title: String,
        routeKey: String? = nil,
        icon: String = "",
        subtitle: String = "",
        status: String = "",
        @ViewBuilder destination: @escaping () -> Content
    ) {
        self.title = title
        self.routeKey = routeKey
        self.icon = icon
        self.subtitle = subtitle
        self.status = status
        self.destinationBuilder = destination
    }
    
    init(
        _ title: String,
        routeKey: String? = nil,
        icon: String = "",
        subtitle: String = "",
        status: String = "",
        destination: Content
    ) {
        self.title = title
        self.routeKey = routeKey
        self.icon = icon
        self.subtitle = subtitle
        self.status = status
        self.destinationBuilder = { destination }
    }
    
    var body: some View {
        let key = routeKey ?? title
        
        NavigationLink(value: key) {
            HStack(spacing: 15) {
                // Icon
                if !icon.isEmpty {
                    IconView(icon)
                }
                
                // Title and subtitle text
                LabeledContent {
                    HStack {
                        if status == "location.fill"{
                            Image(systemName: status)
                        } else {
                            Text(status)
                        }
                    }
                } label: {
                    Text(title)
                    if !subtitle.isEmpty {
                        Text(subtitle)
                    }
                }
            }
            .frame(height: 20)
        }
        .onAppear {
            RouteRegistry.shared.register(key) { destinationBuilder() }
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
            SLink("Second", destination: EmptyView())
            SLink("Third", routeKey: "ThirdRoute") { EmptyView() }
        }
        .navigationDestination(for: String.self) { key in
            RouteRegistry.shared.view(for: key) ?? AnyView(Text("Unknown: \(key)"))
        }
    }
}
