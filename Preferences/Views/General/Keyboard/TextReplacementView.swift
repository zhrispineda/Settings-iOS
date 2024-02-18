//
//  TextReplacementView.swift
//  Preferences
//
//  Settings > General > Keyboard > Text Replacement
//

import SwiftUI

struct TextReplacementView: View {
    // Variables
    @State private var searchText = String()
    @State var sel: Int = 0
    let characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ#".map(String.init)
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                ForEach(0 ..< characters.count, id: \.self) { character in
                    Text(self.characters[character])
                        .foregroundStyle(.blue)
                        .font(.system(size: 12))
                }
            }
        }
        .navigationTitle("Text Replacement")
        .searchable(text: $searchText)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing, content: {
                NavigationLink(destination: AddTextReplacementView(), label: {
                    Image(systemName: "plus")
                })
            })
            ToolbarItem(placement: .bottomBar, content: {
                HStack {
                    EditButton()
                    Spacer()
                }
            })
        }
    }
}

#Preview {
    TextReplacementView()
}
