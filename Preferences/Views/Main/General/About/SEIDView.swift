//
//  SEIDView.swift
//  Preferences
//
//  Settings > General > About > SEID
//

import SwiftUI

struct SEIDView: View {
    var body: some View {
        CustomList(title: "SEID") {
            Text(getRandomSEID(from: "040000000000000000000000000000000000000000000000"))
                .monospaced()
                .foregroundStyle(.tertiary)
                .font(.system(size: 10))
        }
    }

    // Functions
    private func getRandomSEID(from input: String) -> String {
        guard !input.isEmpty else { return "" }
        
        let allCharacters = "0123456789ABCDEF"
        var randomString = String(input.prefix(2))
        
        for _ in 2..<input.count {
            randomString.append(allCharacters.randomElement()!)
        }
        
        return randomString
    }
}

#Preview {
    NavigationStack {
        SEIDView()
    }
}
