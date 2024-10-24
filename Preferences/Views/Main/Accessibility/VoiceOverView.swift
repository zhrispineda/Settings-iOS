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
    let table = "LocalizedStrings"
    let voiceTable = "VoiceOverSettings"
    let servicesTable = "VoiceOverServices"
    
    init() {
        try? Tips.configure()
    }
    
    var body: some View {
        CustomList(title: "VOICEOVER_TITLE".localize(table: voiceTable)) {
            Section {
                Toggle("VOICEOVER_TITLE".localize(table: voiceTable), isOn: $voiceOverEnabled)
            } footer: {
                Text("""
                            **\("VOICEOVER_INTRO".localize(table: voiceTable))**
                            \("SELECT_ITEM_INSTRUCTION".localize(table: voiceTable))
                            \("PRESS_ITEM_INSTRUCTION".localize(table: voiceTable))
                            
                            [\("ADDITIONAL_VOICEOVER_COMMANDS".localize(table: voiceTable))](#)
                            
                            [\("VoiceOverTouchWhatsNewLabel".localize(table: voiceTable))](#)
                            """)
            }
            
            Section {
                Button("VOICEOVER_TUTORIAL_BUTTON_TITLE".localize(table: voiceTable)) {}
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
                           label: { Text("SPEAKING_RATE".localize(table: voiceTable)) }
                    )
                }
                .foregroundStyle(.secondary)
            } header: {
                Text("SPEAKING_RATE".localize(table: voiceTable))
            } footer: {
                Text("RATE_FOOTER_TEXT".localize(table: voiceTable))
            }
            
            Section {
                NavigationLink("SPEECH_OPTIONS".localize(table: voiceTable), destination: EmptyView())
                NavigationLink("BRAILLE_TITLE".localize(table: voiceTable), destination: EmptyView())
                NavigationLink("NEURAL_VOICEOVER".localize(table: voiceTable), destination: EmptyView())
                NavigationLink("VERBOSITY".localize(table: voiceTable), destination: EmptyView())
                NavigationLink("AUDIO_TITLE".localize(table: voiceTable), destination: EmptyView())
            }
            
            Section {
                NavigationLink("CUSTOMIZE_COMMANDS".localize(table: voiceTable), destination: EmptyView())
                NavigationLink("ROTOR_GROUP_HEADING".localize(table: voiceTable), destination: EmptyView())
                NavigationLink("ACTIVITIES".localize(table: voiceTable), destination: EmptyView())
                NavigationLink("TYPING_OPTIONS".localize(table: voiceTable), destination: EmptyView())
                NavigationLink("QUICK_SETTINGS_TITLE".localize(table: voiceTable), destination: EmptyView())
            } footer: {
                Text("QUICK_SETTINGS_USAGE_HINT".localize(table: voiceTable, "VOSGesture.TwoFingerQuadrupleTap".localize(table: servicesTable)))
            }
            
            Section {
                CustomNavigationLink(title: "NavigationStyle".localize(table: voiceTable), status: "NAVIGATION_STYLE_FLAT".localize(table: voiceTable), destination: EmptyView())
                CustomNavigationLink(title: "NAVIGATE_IMAGES_TITLE".localize(table: voiceTable), status: "NAV_IMG_ALWAYS".localize(table: voiceTable), destination: EmptyView())
                Toggle("CURSOR_STYLE".localize(table: voiceTable), isOn: $largeCursor)
                Toggle("CAPTION_PANEL".localize(table: voiceTable), isOn: $captionPanel)
            }
            
            Section {
                CustomNavigationLink(title: "DELAY_TO_SPEAK".localize(table: voiceTable), status: "0s", destination: EmptyView())
                CustomNavigationLink(title: "DOUBLE_TAP_INTERVAL_TITLE".localize(table: voiceTable), status: "0.35s", destination: EmptyView())
            }
        }
    }
}

struct PadLiveRecognitionTip: Tip {
    var title: Text {
        Text("VO_REAL_WORLD_DETECTION", tableName: "VoiceOverSettings")
    }
    
    var message: Text? {
        Text("NEURAL_INTRO_IPAD", tableName: "VoiceOverSettings")
    }
    
    var image: Image? {
        Image("appleMagnifier")
    }
}

struct PhoneLiveRecognitionTip: Tip {
    var title: Text {
        Text("VO_REAL_WORLD_DETECTION", tableName: "VoiceOverSettings")
    }
    
    var message: Text? {
        Text("VO_LIVE_RECOGNITION_CUSTOMIZATION_IPHONE", tableName: "VoiceOverSettings")
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
