//
//  CreditCardsView.swift
//  Preferences
//
//  Settings > Safari > AutoFill > Credit Cards
//

import SwiftUI

struct CreditCardsView: View {
    var body: some View {
        CustomList(title: "Credit Cards") {
            // TODO: Toggle sheet
            Button("Add Credit Card") {}
        }
        .toolbar {
            EditButton()
                .disabled(true)
        }
    }
}

#Preview {
    NavigationStack {
        CreditCardsView()
    }
}
