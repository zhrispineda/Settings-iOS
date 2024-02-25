//
//  WebsiteDataView.swift
//  Preferences
//
//  Settings > Safari > Advanced > Website Data
//

import SwiftUI

struct WebsiteDataView: View {
    // Variables
    @State private var searchText = String()
    
    var body: some View {
        CustomList(title: "Website Data") {
            Section(content: {}, header: {
                HStack {
                    Text("Website Data")
                    Spacer()
                    Text("0 bytes")
                        .textCase(.none)
                }
                .padding(.top, 10)
            })
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        .toolbar {
            EditButton()
        }
    }
}

#Preview {
    NavigationStack {
        WebsiteDataView()
    }
}
