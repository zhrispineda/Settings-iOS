/*
Abstract:
A re-initalized Text that allows for using a localization table's keys in combination with markdown-formatted links within the same key.
*/

import SwiftUI

/// A re-initalized Text that allows for using a localization table's keys in combination with markdown-formatted links within the same key.
///
/// ```swift
/// LocalizedLink("FOOTER_EXPLANATION", table: "AppTable", link: "MORE_INFO_LINK", url: "https://example.com/info")
/// ```
///
/// - Parameter text: The `String` value to use as the key.
/// - Parameter table: The `String` value to use as the table.
/// - Parameter link: The `String` key to display as a link.
/// - Parameter url: The `String` key to use as the destination URL.
struct LocalizedLink: View {
    let text: String
    let table: String
    let link: String
    let url: String
    
    init(_ text: String, table: String, link: String, url: String = "") {
        self.text = text
        self.table = table
        self.link = link
        self.url = url
    }
    
    var body: some View {
        Text(.init(text.localize(table: table, "[\(link.localize(table: table))](\(url))")))
    }
}

#Preview {
    List {
        Section {
            Text("Example")
        } footer: {
            LocalizedLink("APP_ANALYTICS_EXPLANATION", table: "ProblemReporting", link: "ABOUT_APP_ANALYTICS_LINK")
        }
    }
}
