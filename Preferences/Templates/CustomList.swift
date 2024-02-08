//
//  CustomList.swift
//  Preferences
//
//  Template for a custom List with common properties
//

import SwiftUI

struct CustomList<Content: View>: View {
    // Variables
    var title: String = String()
    @ViewBuilder let content: Content
    
    var body: some View {
        List {
            content
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .padding(.top, -19)
    }
}

#Preview {
    NavigationStack {
        CustomList(title: "Test") {
            Text("Hello, World!")
        }
    }
}
