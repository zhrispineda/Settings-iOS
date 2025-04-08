//
//  AutoFillView.swift
//  Preferences
//
//  Settings > Apps > Safari > AutoFill
//

import SwiftUI

struct AutoFillView: View {
    // Variables
    @State private var useContactInfoEnabled = false
    @State private var creditCardsEnabled = true
    
    var body: some View {
        CustomList(title: "AutoFill") {
            Section {} footer: {
                Text("Automatically fill out web forms using your contact or credit card info.")
            }
            
            Section {
                Toggle("Use Contact Info", isOn: $useContactInfoEnabled)
                // TODO: Contacts sheet popup for button
                Button {} label: {
                    HStack {
                        Text("My Info")
                        Spacer()
                        Text("None")
                            .foregroundStyle(.secondary)
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.secondary)
                    }
                }
                .foregroundStyle(.primary)
            }
            
            Section {
                Toggle("Credit Cards", isOn: $creditCardsEnabled)
                // TODO: Add authentication to view SavedCreditCardsView
                NavigationLink("Saved Credit Cards", destination: CreditCardsView())
            }
        }
    }
}

#Preview {
    NavigationStack {
        AutoFillView()
    }
}
