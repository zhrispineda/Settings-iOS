/*
Abstract:
A Section container for displaying a Language settings link.
*/

import SwiftUI

/// A `Section` container for displaying a `SLink` for Language settings.
///
/// ```swift
/// LanguageView()
/// ```
struct LanguageView: View {
    // Variables
    let table = "PSSystemPolicy"
    
    var body: some View {
        Section {
            SLink("LANGUAGE".localize(table: table), color: .blue, icon: "globe", status: "English") {}
        } header: {
            Text("PREFERRED_LANGUAGE", tableName: table)
        }
    }
}

#Preview {
    NavigationStack {
        List {
            LanguageView()
        }
    }
}
