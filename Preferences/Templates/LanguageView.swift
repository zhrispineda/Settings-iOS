/*
Abstract:
A Section container for displaying a Language settings link.
*/

import SwiftUI

/// A `Section` container for displaying a `SettingsLink` for Language settings.
/// ```swift
/// LanguageView()
/// ```
struct LanguageView: View {
    // Variables
    let table = "PSSystemPolicy"
    
    var body: some View {
        Section {
            SettingsLink(color: .blue, icon: "globe", id: "LANGUAGE".localize(table: table), status: "English") {}
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
