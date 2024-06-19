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
            SectionHelp(title: "Accessibility", color: .blue, icon: "accessibility", description: "Personalize \(Device().model) in ways that work best for you with accessibility features for vision, mobility, hearing, speech, and cognition. [Learn more...](https://support.apple.com/guide/iphone/get-started-with-accessibility-features-iph3e2e4367/ios)")
            
            Section {
                if Device().isTablet {
                    SettingsLink(color: .blue, icon: "character.magnify", larger: false, id: "Hover Text", status: "Off") {
                        HoverTextView()
                    }
                }
                SettingsLink(color: .blue, icon: "textformat.size", larger: false, id: "Display & Text Size") {
                    DisplayTextSizeView()
                }
                SettingsLink(color: .green, icon: "circle.dotted.and.circle", larger: false, id: "Motion") {
                    MotionView()
                }
                SettingsLink(icon: "Speech29x29", id: "Spoken Content") {
                    SpeakSelectionView()
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
                    SettingsLink(icon: "ControlNearby29x29", id: "Control Nearby Devices") {
                        ControlNearbyDevicesView()
                    }
                }
                SettingsLink(color: .gray, icon: "keyboard", larger: false, id: "Keyboards") {
                    AccessibilityKeyboardsView()
                }
            } header: {
                Text("Physical and Motor")
            }
            
            Section {
                SettingsLink(color: .blue, icon: "captions.bubble.fill", larger: false, id: "Subtitles & Captioning") {
                    SubtitlesCaptioningView()
                }
            } header: {
                Text("Hearing")
            }
            
            Section {
                SettingsLink(color: .black, icon: "keyboard.badge.waveform.fill", id: "Live Speech", status: "Off") {
                    LiveSpeechView()
                }
            } header: {
                Text("Speech")
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
