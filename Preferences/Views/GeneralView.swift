//
//  GeneralView.swift
//  Preferences
//
//  Settings > General
//

import SwiftUI

struct GeneralView: View {
    var body: some View {
        CustomList(title: "General") {
            Section {
                NavigationLink("About", destination: AboutView())
            }
            
            Section {
                NavigationLink("Keyboard", destination: KeyboardView())
                NavigationLink("Game Controllers", destination: {})
                NavigationLink("Fonts", destination: {})
                NavigationLink("Language & Region", destination: {})
                NavigationLink("Dictionary", destination: {})
            }
            
            Section {
                NavigationLink("VPN & Device Management", destination: {})
            }
            
            Section {
                NavigationLink("Transfer or Reset \(UIDevice().localizedModel)", destination: {})
            }
        }
    }
}

#Preview {
    NavigationStack {
        GeneralView()
    }
}
