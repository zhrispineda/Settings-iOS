//
//  VoiceOverView.swift
//  Preferences
//
//  Settings > Accessibility > VoiceOver
//

import SwiftUI
import TipKit

struct VoiceOverView: View {
    // Variables
    @State private var speakingRate = 0.5
    @State private var voiceOverEnabled = false
    @State private var largeCursor = false
    @State private var captionPanel = false
    
    init() {
        try? Tips.configure()
    }
    
    var body: some View {
        CustomList(title: "VoiceOver") {
            Section {
                Toggle("VoiceOver", isOn: $voiceOverEnabled)
            } footer: {
                VStack(alignment: .leading) {
                    Text("**VoiceOver speaks items on screen:**")
                    Text("\u{2022} Tap once to select an item.")
                    Text("\u{2022} Double-tap to activate the selected item.")
                    Text("\n[Learn more...](#)\n\n[What‘s new in VoiceOver...](#)")
                }
            }
            
            Section {
                Button("VoiceOver Tutorial") {}
            }
            
            TipView(UIDevice.iPhone ? PhoneLiveRecognitionTip() : PadLiveRecognitionTip())
                .tipBackground(Color.background)
                .task {
                    do {
                        try Tips.configure([
                            .displayFrequency(.immediate),
                            .datastoreLocation(.applicationDefault)
                        ])
                    }
                    catch {
                        print("Error initializing TipKit \(error.localizedDescription)")
                    }
                }
            
            Section {
                Group {
                    Slider(value: $speakingRate,
                           in: 0.0...1.0,
                           minimumValueLabel: Image(systemName: "tortoise.fill"),
                           maximumValueLabel: Image(systemName: "hare.fill"),
                           label: { Text("Speaking Rate") }
                    )
                }
                .foregroundStyle(.secondary)
            } header: {
                Text("Speaking Rate")
            } footer: {
                Text("Adjusts the speaking rate of the primary voice.")
            }
            
            Section {
                NavigationLink("Speech", destination: EmptyView())
                NavigationLink("Braille", destination: EmptyView())
                NavigationLink("VoiceOver Recognition", destination: EmptyView())
                NavigationLink("Verbosity", destination: EmptyView())
                NavigationLink("Audio", destination: EmptyView())
            }
            
            Section {
                NavigationLink("Commands", destination: EmptyView())
                NavigationLink("Rotor", destination: EmptyView())
                NavigationLink("Activities", destination: EmptyView())
                NavigationLink("Typing", destination: EmptyView())
                NavigationLink("Quick Settings", destination: EmptyView())
            } footer: {
                Text("Quick settings allows you to access VoiceOver settings at any time. Access quick settings with Two finger quadruple tap.")
            }
            
            Section {
                CustomNavigationLink(title: "Navigation Style", status: "Flat", destination: EmptyView())
                CustomNavigationLink(title: "Navigation Images", status: "Always", destination: EmptyView())
                Toggle("Large Cursor", isOn: $largeCursor)
                Toggle("Caption Panel", isOn: $captionPanel)
            }
            
            Section {
                CustomNavigationLink(title: "Delay before Selection", status: "0s", destination: EmptyView())
                CustomNavigationLink(title: "Double-tap Timeout", status: "0.35s", destination: EmptyView())
            }
        }
    }
}

struct PadLiveRecognitionTip: Tip {
    var title: Text {
        Text("Live Recognition")
    }
    
    var message: Text? {
        Text("Using on-device intelligence, your iPad can detect people, doors, scenes, text, and furniture around you. Four finger triple-tap to start Live Recognition or use the Live Recognition Rotor.")
    }
    
    var image: Image? {
        Image("appleMagnifier")
    }
}

struct PhoneLiveRecognitionTip: Tip {
    var title: Text {
        Text("Live Recognition")
    }
    
    var message: Text? {
        Text("Using on-device intelligence, your iPhone can detect people, doors, scenes, text, and furniture around you. Four finger triple-tap to start Live Recognition or use the Live Recognition Rotor.")
    }
    
    var image: Image? {
        Image("appleMagnifier")
    }
}

#Preview {
    NavigationStack {
        VoiceOverView()
    }
}
