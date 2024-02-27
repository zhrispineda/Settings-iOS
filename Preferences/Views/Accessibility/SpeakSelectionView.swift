//
//  SpeakSelectionView.swift
//  Preferences
//
//  Settings > Accessibility > Speak Selection
//

import SwiftUI

struct SpeakSelectionView: View {
    // Variables
    @State private var speakSelectionEnabled = false
    @State private var speakingRate = 0.5
    
    var body: some View {
        CustomList(title: "Speak Selection") {
            Section(content: {
                Toggle("Speak Selection", isOn: $speakSelectionEnabled.animation())
            }, footer: {
                Text("A Speak button will appear when you select text.")
            })
            
            Section {
                NavigationLink("Pronunciations", destination: PronunciationsView())
            }
            
            if speakSelectionEnabled {
                Section(content: {
                    CustomNavigationLink(title: "Highlight Content", status: "Off", destination: HighlightContentView())
                }, footer: {
                    Text("Highlight content as it is spoken.")
                })
                
                Section {
                    NavigationLink("Voices", destination: SpeakSelectionVoicesView())
                }
                
                Section(content: {
                    Group {
                        Slider(value: $speakingRate,
                               in: 0.0...1.0,
                               minimumValueLabel: Image(systemName: "tortoise.fill"),
                               maximumValueLabel: Image(systemName: "hare.fill"),
                               label: { Text("Speaking Rate") }
                        )
                    }
                    .imageScale(.large)
                    .foregroundStyle(.secondary)
                }, header: {
                    Text("Speaking Rate")
                })
            }
        }
    }
}

#Preview {
    NavigationStack {
        SpeakSelectionView()
    }
}
