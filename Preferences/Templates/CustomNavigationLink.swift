/*
Abstract:
A NavigationLink container that displays an HStack with title, subtitle, and status Text.
*/

import SwiftUI

/// A `NavigationLink` container that displays an `HStack` with title, subtitle, and status Text.
///
/// ```swift
/// var body: some View {
///     List {
///         CustomNavigationLink("Title") {}
///         CustomNavigationLink("Title", destination: EmptyView())
///         CustomNavigationLink("Title", subtitle: "Subtitle", destination: EmptyView())
///         CustomNavigationLink("Title", status: "Status", destination: EmptyView())
///         CustomNavigationLink("Title", subtitle: "Subtitle", status: "Status", destination: EmptyView())
///     }
/// }
/// ```
/// 
/// - Parameter titleKey: The String to display as the description of the `NavigationLink`.
/// - Parameter subtitle: The String text to display below the title.
/// - Parameter status: The String displaying the state of the view within.
/// - Parameter location: The Bool for whether to display a location symbol.
/// - Parameter destination: The Content destination view.
struct CustomNavigationLink<Content: View>: View {
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
            HStack {
                VStack(alignment: .leading) {
                    Text(titleKey)
                        .lineLimit(2)
                    
                    if !subtitle.isEmpty {
                        Text(subtitle)
                            .foregroundStyle(.secondary)
                            .font(.caption)
                    }
                }
                
                if !status.isEmpty {
                    Spacer()
                    if location {
                        Image(systemName: "location.fill")
                            .foregroundStyle(.purple)
                    }
                    Text(status)
                        .lineLimit(1)
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        List {
            CustomNavigationLink("Title") {}
            CustomNavigationLink("Title", subtitle: "Subtitle", destination: EmptyView())
            CustomNavigationLink("Title", status: "Status", destination: EmptyView())
            CustomNavigationLink("Title", subtitle: "Subtitle", status: "Status", destination: EmptyView())
        }
    }
}
