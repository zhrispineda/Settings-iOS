/*
Abstract:
A View container for displaying options regarding Search with apps.
*/

import SwiftUI

/// A `View` container for displaying options regarding Search with apps.
/// ```swift
/// SearchDetailView(appName: "News")
/// ```
/// - Parameter appName: The `String` to display as navigation title and for use in the Section footer.
/// - Parameter appTitle: The `Bool` for whether to show the app name as the navigation title.
struct SearchDetailView: View {
    // Variables
    @State private var showAppInSearchEnabled = true
    @State private var showContentInSearchEnabled = true
    var appName: String = String()
    var appTitle = true
    let table = "AssistantSettings"
    
    var body: some View {
        CustomList(title: appTitle ? appName : "Search", topPadding: true) {
            Section {
                Toggle("SIRIANDSEARCH_PERAPP_WHILESEARCHING_SHOWAPP_TOGGLE".localize(table: table), isOn: $showAppInSearchEnabled)
                if showAppInSearchEnabled {
                    Toggle("SIRIANDSEARCH_PERAPP_WHILESEARCHING_SHOWCONTENT_TOGGLE".localize(table: table), isOn: $showContentInSearchEnabled)
                }
            } header: {
                Text("SIRIANDSEARCH_PERAPP_WHILESEARCHING_HEADER", tableName: table)
            } footer: {
                Text("SIRIANDSEARCH_PERAPP_WHILESEARCHING_FOOTER".localize(table: table, appName))
            }
        }
    }
}

#Preview {
    NavigationStack {
        SearchDetailView(appName: "Example")
    }
}
