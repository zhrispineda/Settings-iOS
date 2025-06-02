import SwiftUI

/// A NavigationLink container that displays a LabeledContent container with title, subtitle, and status text.
///
/// ```swift
/// var body: some View {
///     List {
///         SettingsLink("Title") {}
///         SettingsLink("Title", destination: EmptyView())
///         SettingsLink("Title", subtitle: "Subtitle", destination: EmptyView())
///         SettingsLink("Title", status: "Status", destination: EmptyView())
///         SettingsLink("Title", subtitle: "Subtitle", status: "Status", destination: EmptyView())
///     }
/// }
/// ```
/// 
/// - Parameter titleKey: The String to display as the description of the `NavigationLink`.
/// - Parameter subtitle: The String text to display below the title.
/// - Parameter status: The String displaying the state of the view within.
/// - Parameter location: The Bool for whether to display a location symbol.
/// - Parameter destination: The Content destination view.
struct SettingsLink<Content: View>: View {
    var titleKey: String
    var subtitle: String
    var status: String
    var location: Bool
    var destination: Content
    
    init(_ titleKey: String, subtitle: String = "", status: String = "", location: Bool = false, @ViewBuilder destination: @escaping () -> Content) {
        self.titleKey = titleKey
        self.subtitle = subtitle
        self.status = status
        self.location = location
        self.destination = destination()
    }
    
    init(_ titleKey: String, subtitle: String = "", status: String = "", location: Bool = false, destination: Content) {
        self.titleKey = titleKey
        self.subtitle = subtitle
        self.status = status
        self.location = location
        self.destination = destination
    }
    
    var body: some View {
        NavigationLink {
            destination
        } label: {
            LabeledContent {
                if !status.isEmpty {
                    HStack {
                        if location {
                            Image(systemName: "location.fill")
                                .foregroundStyle(.purple)
                        }
                        Text(status)
                    }
                }
            } label: {
                Text(titleKey)
                if !subtitle.isEmpty {
                    Text(subtitle)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        List {
            SettingsLink("Title") {}
            SettingsLink("Title", subtitle: "Subtitle", destination: EmptyView())
            SettingsLink("Title", status: "Status", destination: EmptyView())
            SettingsLink("Title", subtitle: "Subtitle", status: "Status", destination: EmptyView())
        }
    }
}
