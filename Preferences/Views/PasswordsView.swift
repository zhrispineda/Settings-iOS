//
//  PasswordsView.swift
//  Preferences
//
//  Settings > Passwords
//

import SwiftUI

struct PasswordsView: View {
    // Variables
    @State private var searchText = String()
    
    var body: some View {
        CustomList(title: "Passwords") {
            Section {
                SettingsLink(color: .green, icon: "shield.lefthalf.filled.badge.checkmark", larger: false, id: "Security Recommendations", subtitle: "No issues found", status: "0", content: {})
                SettingsLink(color: .gray, icon: "switch.2", larger: false, id: "Password Options", content: {})
            }
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        .toolbar {
            ToolbarItem(placement: .topBarTrailing, content: {
                Button("\(Image(systemName: "plus"))", action: {})
            })
            ToolbarItem(placement: .topBarTrailing, content: {
                EditButton()
                    .disabled(true)
            })
        }
        
    }
}

#Preview {
    PasswordsView()
}
