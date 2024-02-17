//
//  CustomNavigationLink.swift
//  Preferences
//
/// Template for a NavigationLink with subtitle and status text.
/// - Parameters:
///   - title: The main text describing the label.
///   - subtitle: The sub-title text below the title describing the title.
///   - status: Description of a state of a destination's controls.
///   - destination: A view for the navigation link to present.

import SwiftUI

struct CustomNavigationLink<Content: View>: View {
    // Variables
    var title = String()
    var subtitle = String()
    var status = String()
    var location = false
    var destination: Content
    
    var body: some View {
        NavigationLink(destination: {
            destination
        }, label: {
            HStack {
                VStack(alignment: .leading) {
                    Text(title)
                        .lineLimit(1)
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
        })
    }
}

#Preview {
    List {
        CustomNavigationLink(title: "Title", subtitle: "Subtitle", status: "Status", destination: EmptyView())
    }
}
