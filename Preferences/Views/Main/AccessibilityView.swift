//
//  AccessibilityView.swift
//  Preferences
//
//  Settings > Accessibility
//

import SwiftUI

struct AccessibilityView: View {
    // Variables
    let table = "Accessibility"
    @State private var opacity: Double = 0
    @State private var frameY: Double = 0
    
    var body: some View {
        CustomList(title: "ROOT_LEVEL_TITLE".localize(table: table)) {
            Section {
                SectionHelp(title: "PLACARD_TITLE".localize(table: table), color: .blue, icon: "accessibility", description: UIDevice.iPhone ? "\("PLACARD_SUBTITLE_IPHONE".localize(table: table)) [\("PLACARD_LEARN_MORE".localize(table: "Accessibility"))](https://support.apple.com/guide/iphone/get-started-with-accessibility-features-iph3e2e4367/ios)" : "\("PLACARD_SUBTITLE_IPAD".localize(table: table)) [\("PLACARD_LEARN_MORE".localize(table: table))](https://support.apple.com/guide/ipad/get-started-with-accessibility-features-ipad9a2465f9/ipados)")
                    .overlay { // For calculating opacity of the principal toolbar item
                        GeometryReader { geo in
                            Color.clear
                                .onChange(of: geo.frame(in: .scrollView).minY) {
                                    frameY = geo.frame(in: .scrollView).minY
                                    opacity = frameY / -30
                                }
                        }
                    }
            }
            
            Section {
                if !UIDevice.isSimulator {
                    SettingsLink(icon: "voiceover", id: "VOICEOVER_TITLE".localize(table: table), status: "OFF".localize(table: table)) {
                        VoiceOverView()
                    }
                    SettingsLink(icon: "arrowtriangles.up.right.down.left.magnifyingglass", id: "ZOOM_TITLE".localize(table: table), status: "OFF".localize(table: table)) {}
                }
                if UIDevice.iPad {
                    SettingsLink(color: .blue, icon: "character.magnify", id: "HOVERTEXT_TITLE".localize(table: table), status: "OFF".localize(table: table)) {
                        HoverTextView()
                    }
                }
                SettingsLink(color: .blue, icon: "textformat.size", id: "DISPLAY_AND_TEXT".localize(table: table)) {
                    DisplayTextSizeView()
                }
                SettingsLink(color: .green, icon: "circle.dotted.and.circle", id: "MOTION_TITLE".localize(table: table)) {
                    MotionView()
                }
                SettingsLink(color: .black, icon: "rectangle.3.group.bubble.fill", id: "SPEECH_TITLE".localize(table: table)) {
                    SpeakSelectionView()
                }
                if !UIDevice.isSimulator {
                    SettingsLink(color: .blue, icon: "quote.bubble.fill", id: "DESCRIPTIVE_VIDEO".localize(table: table)) {
                        SpeakSelectionView()
                    }
                }
            } header: {
                Text("VISION".localize(table: table))
            }
            
            Section {
                if !UIDevice.isSimulator {
                    SettingsLink(color: .blue, icon: "hand.point.up.left.fill", id: "TOUCH".localize(table: table)) {
                        TouchView()
                    }
                }
                if UIDevice.PearlIDCapability {
                    SettingsLink(color: .green, icon: "faceid", id: "FACE_ID".localize(table: table)) {
                        FaceAttentionView()
                    }
                }
                if !UIDevice.isSimulator {
                    SettingsLink(icon: "square.grid.2x2", id: "ScannerSwitchTitle".localize(table: table)) {}
                    SettingsLink(color: .blue, icon: "voice.control", id: "CommandAndControlTitle".localize(table: table)) {}
                    SettingsLink(color: .indigo, icon: "eye.tracking", id: "Eye Tracking") {}
                    if UIDevice.iPhone {
                        SettingsLink(color: .blue, icon: "iphone.side.button.arrow.left", id: "SIDE_CLICK_TITLE".localize(table: table)) {}
                        SettingsLink(color: .blue, icon: "iphone.side.button.arrow.left", id: "CAMERA_BUTTON_TITLE".localize(table: table)) {}
                        SettingsLink(color: .blue, icon: "inset.filled.applewatch.case", id: "APPLE_WATCH_REMOTE_SCREEN".localize(table: table)) {}
                    } else {
                        SettingsLink(color: .blue, icon: "ipad.top.button.arrow.down", id: "TOP_CLICK_TITLE".localize(table: table)) {}
                        SettingsLink(color: .gray, icon: "pencil", id: "PencilTitle".localize(table: table)) {}
                    }
                }
                if UIDevice.iPhone {
                    SettingsLink(color: .blue, icon: "iphone.badge.dot.radiowaves.up.forward", id: "CONTROL_NEARBY_DEVICES".localize(table: table)) {
                        ControlNearbyDevicesView()
                    }
                }
            } header: {
                Text("MOBILITY_HEADING".localize(table: table))
            }
            
            Section {
                if !UIDevice.isSimulator {
                    SettingsLink(color: .blue, icon: "ear", id: "HEARING_AID_TITLE".localize(table: table)) {}
                    SettingsLink(color: .gray, icon: "switch.2", id: "HEARING_CONTROL_CENTER_TITLE".localize(table: table)) {}
                    SettingsLink(color: .red, icon: "waveform.and.magnifyingglass", id: "SOUND_RECOGNITION_TITLE".localize(table: table)) {}
                    SettingsLink(color: .green, icon: "teletype", id: "TTY_RTT_LABEL".localize(table: table)) {}
                    SettingsLink(color: .blue, icon: "speaker.eye.fill", id: "AUDIO_VISUAL_TITLE".localize(table: table)) {}
                }
                SettingsLink(color: .blue, icon: "captions.bubble.fill", id: "SUBTITLES_CAPTIONING".localize(table: table)) {
                    SubtitlesCaptioningView()
                }
                if !UIDevice.isSimulator {
                    SettingsLink(icon: "waveform.bubble.fill", id: "RTT_LIVE_TRANSCRIPTIONS_LABEL".localize(table: table)) {}
                    if UIDevice.iPhone {
                        SettingsLink(color: .red, icon: "apple.haptics.and.music.note", id: "Music Haptics") {}
                    }
                }
            } header: {
                Text("HEARING".localize(table: table))
            }
            
            Section {
                SettingsLink(color: .black, icon: "keyboard.badge.waveform.fill", id: "LIVE_SPEECH".localize(table: table), status: "OFF".localize(table: table)) {
                    LiveSpeechView()
                }
                if UIDevice.isSimulator {
                    CustomNavigationLink(title: "ADAPTIVE_VOICE_SHORTCUTS_TITLE".localize(table: table), status: "OFF".localize(table: table), destination: EmptyView())
                } else {
                    SettingsLink(color: .blue, icon: "person.badge.waveform.fill", id: "PERSONAL_VOICE_TITLE".localize(table: table), status: "OFF".localize(table: table)) {}
                    SettingsLink(icon: "waveform.arrow.triangle.branch.right", id: "ADAPTIVE_VOICE_SHORTCUTS_TITLE".localize(table: table), status: "OFF".localize(table: table)) {}
                }
            } header: {
                Text("SPEECH_HEADING".localize(table: table))
            }
            
            Section {
                SettingsLink(color: .gray, icon: "keyboard.fill", id: "Keyboards & Typing") {}
                if !UIDevice.isSimulator {
                    SettingsLink(color: .gray, icon: "appletvremote.gen4.fill", id: "APPLE_TV_REMOTE".localize(table: table)) {}
                }
            } header: {
                Text("ACCESSORIES_HEADING".localize(table: table))
            }
            
            Section {
                if !UIDevice.isSimulator {
                    SettingsLink(icon: "lock.square.dotted", id: "GUIDED_ACCESS_TITLE".localize(table: table), status: "OFF".localize(table: table)) {}
                    SettingsLink(color: .gray, icon: "apps.iphone.assistive.access", id: "AssistiveAccessTitle".localize(table: table)) {}
                    SettingsLink(color: .clear, icon: "appleSiri", id: "SIRI_SETTINGS_TITLE".localize(table: table)) {}
                    SettingsLink(color: .blue, icon: "accessibility", id: "TRIPLE_CLICK_TITLE".localize(table: table), status: "OFF".localize(table: table)) {}
                    SettingsLink(color: .blue, icon: "app.badge.checkmark", id: "Per-App Settings") {}
                }
            } header: {
                Text("GENERAL_HEADING".localize(table: table))
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("ROOT_LEVEL_TITLE".localize(table: table))
                    .fontWeight(.semibold)
                    .font(.subheadline)
                    .opacity(frameY < 50.0 ? opacity : 0) // Only fade when passing the help section title at the top
            }
        }
    }
}

#Preview {
    NavigationStack {
        AccessibilityView()
    }
}
