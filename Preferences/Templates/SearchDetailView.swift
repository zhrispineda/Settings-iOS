//
//  SearchDetailView.swift
//  Preferences
//
//  Settings > Search > [App]
//

import SwiftUI

/// A ``View`` template for displaying options regarding Siri Suggestions and apps.
/// ```swift
/// SearchDetailView(appName: "News")
/// ```
/// - Parameter appName: The ``String`` to display as the app name for the ``View``.
struct SearchDetailView: View {
    // Variables
    @State private var showAppInSearchEnabled = true
    @State private var showContentInSearchEnabled = true
    var appName: String = String()
    
    var body: some View {
        CustomList(title: appName) {
            Section {
                Toggle("Show App in Search", isOn: $showAppInSearchEnabled)
                if showAppInSearchEnabled {
                    Toggle("Show Content in Search", isOn: $showContentInSearchEnabled)
                }
            } header: {
                Text("\n\nWhile Searching")
            } footer: {
                Text("Allow “\(appName)“ the app and its content to appear in Search.")
            }
        }
    }
}

#Preview {
    NavigationStack {
        SearchDetailView()
    }
}
