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
                if !Configuration().isSimulator {
                    NavigationLink("Software Update", destination: {})
                }
            }
            
            if !Configuration().isSimulator {
                Section {
                    NavigationLink("AppleCare & Warranty", destination: EmptyView())
                }
            }
            
            if !Configuration().isSimulator {
                Section {
                    NavigationLink("AirDrop", destination: EmptyView())
                    NavigationLink("AirPlay & Handoff", destination: EmptyView())
                    NavigationLink("Picture in Picture", destination: EmptyView())
                }
            }
            
            if !Configuration().isSimulator {
                Section {
                    NavigationLink("CarPlay", destination: EmptyView())
                    NavigationLink("Matter Accessories", destination: EmptyView())
                }
            }
            
            if !Configuration().isSimulator {
                Section {
                    NavigationLink("\(UIDevice().localizedModel) Storage", destination: EmptyView())
                    NavigationLink("Background App Refresh", destination: EmptyView())
                }
            }
            
            Section {
                if !Configuration().isSimulator {
                    NavigationLink("Date & Time", destination: EmptyView())
                }
                NavigationLink("Keyboard", destination: KeyboardView())
                NavigationLink("Game Controllers", destination: GameControllerView())
                NavigationLink("Fonts", destination: FontsView())
                NavigationLink("Language & Region", destination: LanguageRegionView())
                NavigationLink("Dictionary", destination: DictionaryView())
            }
            
            Section {
                NavigationLink("VPN & Device Management", destination: VPNDeviceManagementView())
            }
            
            if !Configuration().isSimulator {
                Section {
                    NavigationLink("Legal & Regulatory", destination: EmptyView())
                }
            }
            
            Section {
                NavigationLink("Transfer or Reset \(UIDevice().localizedModel)", destination: {
                    Color(UIColor.systemGroupedBackground)
                        .ignoresSafeArea()
                        .navigationTitle("Transfer or Reset \(UIDevice().localizedModel)")
                })
                if !Configuration().isSimulator {
                    Button("Shut Down", action: {})
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        GeneralView()
    }
}
