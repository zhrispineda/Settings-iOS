//
//  AccessibilityView.swift
//  Preferences
//
//  Settings > Accessibility
//

import SwiftUI

struct AccessibilityView: View {
    var body: some View {
        CustomList(title: "Accessibility") {
            Section {
                SectionHelp(title: "Accessibility", color: .blue, icon: "accessibility", description: "Personalize \(Device().model) in ways that work best for you with accessibility features for vision, mobility, hearing, speech, and cognition. [Learn more...](https://support.apple.com/guide/iphone/get-started-with-accessibility-features-iph3e2e4367/ios)")
            }
            
            Section {
                if !UIDevice.isSimulator {
                    SettingsLink(color: .black, icon: "voiceover", id: "VoiceOver", status: "Off") {}
                    SettingsLink(color: .black, icon: "arrowtriangles.up.right.down.left.magnifyingglass", id: "Zoom", status: "Off") {}
                }
                if Device().isTablet {
                    SettingsLink(color: .blue, icon: "character.magnify", id: "Hover Text", status: "Off") {
                        HoverTextView()
                    }
                }
                SettingsLink(color: .blue, icon: "textformat.size", id: "Display & Text Size") {
                    DisplayTextSizeView()
                }
                SettingsLink(color: .green, icon: "circle.dotted.and.circle", id: "Motion") {
                    MotionView()
                }
                SettingsLink(color: .black, icon: "rectangle.3.group.bubble.fill", id: "Spoken Content") {
                    SpeakSelectionView()
                }
                if !UIDevice.isSimulator {
                    SettingsLink(color: .blue, icon: "quote.bubble.fill", id: "Audio Descriptions") {
                        SpeakSelectionView()
                    }
                }
            } header: {
                Text("Vision")
            }
            
            Section {
                SettingsLink(color: .blue, icon: "hand.point.up.left.fill", id: "Touch") {
                    TouchView()
                }
                if Device().hasFaceAuth {
                    SettingsLink(color: .green, icon: "faceid", id: "Face ID & Attention") {
                        FaceAttentionView()
                    }
                }
                if Device().isPhone {
                    SettingsLink(color: .blue, icon: "iphone.badge.dot.radiowaves.up.forward", id: "Control Nearby Devices") {
                        ControlNearbyDevicesView()
                    }
                }
            } header: {
                Text("Physical and Motor")
            }
            
            Section {
                SettingsLink(color: .blue, icon: "captions.bubble.fill", id: "Subtitles & Captioning") {
                    SubtitlesCaptioningView()
                }
            } header: {
                Text("Hearing")
            }
            
            Section {
                SettingsLink(color: .black, icon: "keyboard.badge.waveform.fill", id: "Live Speech", status: "Off") {
                    LiveSpeechView()
                }
                CustomNavigationLink(title: "Vocal Shortcuts", status: "Off", destination: EmptyView())
            } header: {
                Text("Speech")
            }
            
            Section {
                SettingsLink(color: .gray, icon: "keyboard", id: "Keyboards & Typing") {}
            } header: {
                Text("Accessories")
            }
            
            Section {} header: {
                Text("General")
            }
        }
    }
}

#Preview {
    NavigationStack {
        AccessibilityView()
    }
}
