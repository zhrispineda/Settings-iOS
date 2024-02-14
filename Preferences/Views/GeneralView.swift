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
                NavigationLink("Game Controllers", destination: GameControllerView())
                NavigationLink("Fonts", destination: FontsView())
                NavigationLink("Language & Region", destination: LanguageRegionView())
                NavigationLink("Dictionary", destination: DictionaryView())
            }
            
            Section {
                NavigationLink("VPN & Device Management", destination: VPNDeviceManagementView())
            }
            
            Section {
                NavigationLink("Transfer or Reset \(UIDevice().localizedModel)", destination: {
                    Color(UIColor.systemGroupedBackground)
                        .ignoresSafeArea()
                        .navigationTitle("Transfer or Reset \(UIDevice().localizedModel)")
                })
            }
        }
    }
}

#Preview {
    NavigationStack {
        GeneralView()
    }
}
