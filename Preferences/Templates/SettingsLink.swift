import SwiftUI

/// A NavigationLink container that displays a LabeledContent with title, subtitle, and status.
/// Now value-based: registers its destination with RouteRegistry and pushes a key into the NavigationStack path.
struct SettingsLink<Content: View>: View {
    var titleKey: String
    var routeKey: String?
    var subtitle: String
    var status: String
    var location: Bool
    private let destinationBuilder: () -> Content
    
    init(
        _ titleKey: String,
        routeKey: String? = nil,
        subtitle: String = "",
        status: String = "",
        location: Bool = false,
        @ViewBuilder destination: @escaping () -> Content
    ) {
        self.titleKey = titleKey
        self.routeKey = routeKey
        self.subtitle = subtitle
        self.status = status
        self.location = location
        self.destinationBuilder = destination
    }
    
    init(
        _ titleKey: String,
        routeKey: String? = nil,
        subtitle: String = "",
        status: String = "",
        location: Bool = false,
        destination: Content
    ) {
        self.titleKey = titleKey
        self.routeKey = routeKey
        self.subtitle = subtitle
        self.status = status
        self.location = location
        self.destinationBuilder = { destination }
    }
    
    var body: some View {
        let key = routeKey ?? titleKey
        
        NavigationLink(value: key) {
            LabeledContent {
                if !status.isEmpty {
                    HStack {
                        if location {
                            Image(systemName: "location.fill")
                                .foregroundStyle(.purple)
                        }
                        Text(status)
                            .foregroundStyle(.secondary)
                    }
                }
            } label: {
                Text(titleKey)
                if !subtitle.isEmpty {
                    Text(subtitle)
                }
            }
        }
        .onAppear {
            RouteRegistry.shared.register(key) { destinationBuilder() }
        }
    }
}

#Preview {
    NavigationStack {
        List {
            SettingsLink("Title") { EmptyView() }
            SettingsLink("Title", subtitle: "Subtitle") { EmptyView() }
            SettingsLink("Title", status: "Status") { EmptyView() }
            SettingsLink("Title", subtitle: "Subtitle", status: "Status") { EmptyView() }
        }
        .navigationDestination(for: String.self) { key in
            RouteRegistry.shared.view(for: key) ?? AnyView(Text("Unknown: \(key)"))
        }
    }
}
