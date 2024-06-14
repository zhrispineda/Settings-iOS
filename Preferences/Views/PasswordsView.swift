//
//  PasswordsView.swift
//  Preferences
//
//  Removed in iOS 18 beta 1
//

import SwiftUI

struct PasswordsView: View {
    // Variables
    @State private var searchText = String()
    
    var body: some View {
        CustomList(title: "Passwords") {
            Section {
                SettingsLink(color: .green, icon: "shield.lefthalf.filled.badge.checkmark", larger: false, id: "Security Recommendations", subtitle: "No issues found", status: "0") {
                    SecurityRecommendationsView()
                }
                SettingsLink(color: .gray, icon: "switch.2", larger: false, id: "Password Options") {
                    PasswordOptionsView()
                }
            }
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("\(Image(systemName: "plus"))") {}
            }
            ToolbarItem(placement: .topBarTrailing) {
                EditButton()
                    .disabled(true)
            }
        }
        
    }
}

#Preview {
    NavigationStack {
        PasswordsView()
    }
}
