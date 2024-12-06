/*
Abstract:
A NavigationLink container that displays an HStack with title, subtitle, and status text.
*/

import SwiftUI

/// A `NavigationLink` container that displays an `HStack` with title, subtitle, and status text.
/// ```swift
/// var body: some View {
///     List {
///         CustomNavigationLink(title: "Title", destination: EmptyView())
///         CustomNavigationLink(title: "Title", subtitle: "Subtitle", destination: EmptyView())
///         CustomNavigationLink(title: "Title", status: "Status", destination: EmptyView())
///         CustomNavigationLink(title: "Title", subtitle: "Subtitle", status: "Status", destination: EmptyView())
///     }
/// }
/// ```
/// - Parameter title: The String to display as the description of the `NavigationLink`.
/// - Parameter subtitle: The String text to display below the title.
/// - Parameter status: The String displaying the state of the view within.
/// - Parameter destination: The Content destination view.
struct CustomNavigationLink<Content: View>: View {
    // Variables
    var title = String()
    var subtitle = String()
    var status = String()
    var location = false
    var destination: Content
    
    var body: some View {
        NavigationLink {
            destination
        } label: {
            HStack {
                VStack(alignment: .leading) {
                    Text(title)
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
            CustomNavigationLink(title: "Title", destination: EmptyView())
            CustomNavigationLink(title: "Title", subtitle: "Subtitle", destination: EmptyView())
            CustomNavigationLink(title: "Title", status: "Status", destination: EmptyView())
            CustomNavigationLink(title: "Title", subtitle: "Subtitle", status: "Status", destination: EmptyView())
        }
    }
}
