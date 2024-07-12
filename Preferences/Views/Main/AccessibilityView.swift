//
//  AccessibilityView.swift
//  Preferences
//
//  Settings > Accessibility
//

import SwiftUI

struct AccessibilityView: View {
    var body: some View {
        CustomList(title: "ROOT_LEVEL_TITLE") {
            Section {
                SectionHelp(title: "PLACARD_TITLE", color: .blue, icon: "accessibility", description: Device().isPhone ? "PLACARD_SUBTITLE_IPHONE [PLACARD_LEARN_MORE](https://support.apple.com/guide/iphone/get-started-with-accessibility-features-iph3e2e4367/ios)" : "PLACARD_SUBTITLE_IPAD [PLACARD_LEARN_MORE](https://support.apple.com/guide/ipad/ipados)")
            }
            
            Section {
                if !UIDevice.isSimulator {
                    SettingsLink(icon: "voiceover", id: "VOICEOVER_TITLE", status: "OFF") {}
                    SettingsLink(icon: "arrowtriangles.up.right.down.left.magnifyingglass", id: "ZOOM_TITLE", status: "OFF") {}
                }
                if Device().isTablet {
                    SettingsLink(color: .blue, icon: "character.magnify", id: "HOVERTEXT_TITLE", status: "OFF") {
                        HoverTextView()
                    }
                }
                SettingsLink(color: .blue, icon: "textformat.size", id: "DISPLAY_AND_TEXT") {
                    DisplayTextSizeView()
                }
                SettingsLink(color: .green, icon: "circle.dotted.and.circle", id: "MOTION_TITLE") {
                    MotionView()
                }
                SettingsLink(color: .black, icon: "rectangle.3.group.bubble.fill", id: "SPEECH_TITLE") {
                    SpeakSelectionView()
                }
                if !UIDevice.isSimulator {
                    SettingsLink(color: .blue, icon: "quote.bubble.fill", id: "DESCRIPTIVE_VIDEO") {
                        SpeakSelectionView()
                    }
                }
            } header: {
                Text("VISION")
            }
            
            Section {
                SettingsLink(color: .blue, icon: "hand.point.up.left.fill", id: "TOUCH") {
                    TouchView()
                }
                if Device().hasFaceAuth {
                    SettingsLink(color: .green, icon: "faceid", id: "FACE_ID") {
                        FaceAttentionView()
                    }
                }
                if !UIDevice.isSimulator {
                    SettingsLink(icon: "square.grid.2x2", id: "ScannerSwitchTitle") {}
                    SettingsLink(color: .blue, icon: "voice.control", id: "CommandAndControlTitle") {}
                    SettingsLink(color: .indigo, icon: "eye.tracking", id: "Eye Tracking") {}
                    SettingsLink(color: .blue, icon: "iphone.side.button.arrow.left", id: "SIDE_CLICK_TITLE") {}
                    SettingsLink(color: .blue, icon: "inset.filled.applewatch.case", id: "APPLE_WATCH_REMOTE_SCREEN") {}
                }
                if Device().isPhone {
                    SettingsLink(color: .blue, icon: "iphone.badge.dot.radiowaves.up.forward", id: "CONTROL_NEARBY_DEVICES") {
                        ControlNearbyDevicesView()
                    }
                }
            } header: {
                Text("MOBILITY_HEADING")
            }
            
            Section {
                if !UIDevice.isSimulator {
                    SettingsLink(color: .blue, icon: "ear", id: "HEARING_AID_TITLE") {}
                    SettingsLink(color: .gray, icon: "switch.2", id: "HEARING_CONTROL_CENTER_TITLE") {}
                    SettingsLink(color: .red, icon: "waveform.and.magnifyingglass", id: "SOUND_RECOGNITION_TITLE") {}
                    SettingsLink(color: .green, icon: "teletype", id: "TTY_RTT_LABEL") {}
                    SettingsLink(color: .blue, icon: "speaker.eye.fill", id: "AUDIO_VISUAL_TITLE") {}
                }
                SettingsLink(color: .blue, icon: "captions.bubble.fill", id: "SUBTITLES_CAPTIONING") {
                    SubtitlesCaptioningView()
                }
                if !UIDevice.isSimulator {
                    SettingsLink(icon: "waveform.bubble.fill", id: "RTT_LIVE_TRANSCRIPTIONS_LABEL") {}
                    SettingsLink(color: .red, icon: "apple.haptics.and.music.note", id: "Music Haptics") {}
                }
            } header: {
                Text("HEARING")
            }
            
            Section {
                SettingsLink(color: .black, icon: "keyboard.badge.waveform.fill", id: "LIVE_SPEECH", status: "OFF") {
                    LiveSpeechView()
                }
                if UIDevice.isSimulator {
                    CustomNavigationLink(title: "ADAPTIVE_VOICE_SHORTCUTS_TITLE", status: "OFF", destination: EmptyView())
                } else {
                    SettingsLink(color: .blue, icon: "person.badge.waveform.fill", id: "ADAPTIVE_VOICE_SHORTCUTS_TITLE", status: "OFF") {}
                    SettingsLink(icon: "waveform.arrow.triangle.branch.right", id: "ADAPTIVE_VOICE_SHORTCUTS_TITLE", status: "OFF") {}
                }
            } header: {
                Text("SPEECH_HEADING")
            }
            
            Section {
                SettingsLink(color: .gray, icon: "keyboard.fill", id: "Keyboards & Typing") {}
                if !UIDevice.isSimulator {
                    SettingsLink(color: .gray, icon: "appletvremote.gen4.fill", id: "APPLE_TV_REMOTE") {}
                }
            } header: {
                Text("ACCESSORIES_HEADING")
            }
            
            Section {
                if !UIDevice.isSimulator {
                    SettingsLink(icon: "lock.square.dotted", id: "GUIDED_ACCESS_TITLE", status: "OFF") {}
                    SettingsLink(color: .gray, icon: "apps.iphone.assistive.access", id: "AssistiveAccessTitle") {}
                    SettingsLink(color: .clear, icon: "appleSiri", id: "SIRI_SETTINGS_TITLE") {}
                    SettingsLink(color: .blue, icon: "accessibility", id: "TRIPLE_CLICK_TITLE", status: "OFF") {}
                    SettingsLink(color: .blue, icon: "app.badge.checkmark", id: "Per-App Settings") {}
                }
            } header: {
                Text("GENERAL_HEADING")
            }
        }
    }
}

#Preview {
    NavigationStack {
        AccessibilityView()
    }
}
