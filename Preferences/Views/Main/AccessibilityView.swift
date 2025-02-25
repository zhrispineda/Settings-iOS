//
//  AccessibilityView.swift
//  Preferences
//
//  Settings > Accessibility
//

import SwiftUI

struct AccessibilityView: View {
    // Variables
    @Environment(\.colorScheme) private var colorScheme
    @State private var opacity: Double = 0
    @State private var frameY: Double = 0
    let table = "Accessibility"
    let titleTable = "AccessibilityTitles"
    let cameraTable = "Accessibility-D93"
    let hapticTable = "Accessibility-HapticMusic"
    
    var body: some View {
        CustomList(title: "Accessibility".localize(table: table)) {
            // MARK: Placard
            Section {
                Placard(title: "PLACARD_TITLE".localize(table: table), color: .blue, icon: "accessibility", description: UIDevice.iPhone ? "\("PLACARD_SUBTITLE_IPHONE".localize(table: table)) [\("PLACARD_LEARN_MORE".localize(table: "Accessibility"))](https://support.apple.com/guide/iphone/get-started-with-accessibility-features-iph3e2e4367/ios)" : "\("PLACARD_SUBTITLE_IPAD".localize(table: table)) [\("PLACARD_LEARN_MORE".localize(table: table))](https://support.apple.com/guide/ipad/get-started-with-accessibility-features-ipad9a2465f9/ipados)", frameY: $frameY, opacity: $opacity)
            }
            
            // MARK: Vision
            Section {
                if !UIDevice.IsSimulator {
                    // VoiceOver
                    SettingsLink(icon: "voiceover", id: "VOICEOVER_TITLE".localize(table: titleTable), status: "OFF".localize(table: table)) {
                        VoiceOverView()
                    }
                    // Zoom
                    SettingsLink(icon: "arrowtriangles.up.right.down.left.magnifyingglass", id: "ZOOM_TITLE".localize(table: titleTable), status: "OFF".localize(table: table)) {
                        ZoomView()
                    }
                }
                if UIDevice.iPad {
                    // Hover Text
                    SettingsLink(color: .blue, icon: "character.magnify", id: "HOVERTEXT_TITLE".localize(table: titleTable), status: "OFF".localize(table: table)) {
                        HoverTextView()
                    }
                }
                // Display & Text Size
                SettingsLink(color: .blue, icon: "textformat.size", id: "DISPLAY_AND_TEXT".localize(table: titleTable)) {
                    DisplayTextSizeView()
                }
                // Motion
                SettingsLink(color: .green, icon: "circle.dotted.and.circle", id: "MOTION_TITLE".localize(table: titleTable)) {
                    MotionView()
                }
                // Spoken Content
                SettingsLink(color: .black, icon: "rectangle.3.group.bubble.fill", id: "SPEECH_TITLE".localize(table: titleTable)) {
                    SpeakSelectionView()
                }
                if !UIDevice.IsSimulator {
                    // Audio Descriptions
                    SettingsLink(color: .blue, icon: "quote.bubble.fill", id: "DESCRIPTIVE_VIDEO_SETTING".localize(table: titleTable), status: "OFF".localize(table: table)) {
                        SpeakSelectionView()
                    }
                }
            } header: {
                Text("VISION", tableName: titleTable)
            }
            
            // MARK: Physical and Motor
            Section {
                if !UIDevice.IsSimulator {
                    // Touch
                    SettingsLink(color: .blue, icon: "hand.point.up.left.fill", id: "TOUCH".localize(table: titleTable)) {
                        TouchView()
                    }
                }
                if UIDevice.PearlIDCapability {
                    // Face ID & Attention
                    SettingsLink(color: .green, icon: "faceid", id: "FACE_ID".localize(table: titleTable)) {
                        FaceAttentionView()
                    }
                }
                if !UIDevice.IsSimulator {
                    // Switch Control
                    SettingsLink(icon: "square.grid.2x2", id: "ScannerSwitchTitle".localize(table: titleTable), status: "OFF".localize(table: table)) {}
                    // Voice Control
                    SettingsLink(color: .blue, icon: "voice.control", id: "CommandAndControlTitle".localize(table: titleTable), status: "OFF".localize(table: table)) {}
                    // Eye Tracking
                    SettingsLink(color: .indigo, icon: "eye.tracking", id: "Eye Tracking", status: "OFF".localize(table: table)) {}
                    if UIDevice.iPhone {
                        // Side Button
                        SettingsLink(color: .blue, icon: "iphone.side.button.arrow.left", id: "SIDE_CLICK_TITLE".localize(table: titleTable)) {}
                        if UIDevice.AdvancedPhotographicStylesCapability {
                            // Camera Button
                            SettingsLink(color: .blue, icon: "iphone.side.button.arrow.left", id: "CAMERA_BUTTON_TITLE".localize(table: cameraTable)) {}
                        }
                        // Apple Watch Mirroring
                        SettingsLink(color: .blue, icon: "inset.filled.applewatch.case", id: "APPLE_WATCH_REMOTE_SCREEN".localize(table: table)) {}
                    } else {
                        // Top Button
                        SettingsLink(color: .blue, icon: "ipad.top.button.arrow.down", id: "TOP_CLICK_TITLE".localize(table: table)) {}
                        // Apple Pencil
                        SettingsLink(color: .gray, icon: "pencil", id: "PencilTitle".localize(table: table)) {}
                    }
                }
                if UIDevice.iPhone {
                    // Control Nearby Devices
                    SettingsLink(color: .blue, icon: "iphone.badge.dot.radiowaves.up.forward", id: "CONTROL_NEARBY_DEVICES".localize(table: table)) {
                        ControlNearbyDevicesView()
                    }
                }
            } header: {
                Text("MOBILITY_HEADING", tableName: titleTable)
            }
            
            // MARK: Hearing
            Section {
                if !UIDevice.IsSimulator {
                    // Hearing Devices
                    SettingsLink(color: .blue, icon: "ear", id: "HEARING_AID_TITLE".localize(table: titleTable)) {}
                    // Hearing Control Center
                    SettingsLink(color: .gray, icon: "switch.2", id: "HEARING_CONTROL_CENTER_TITLE".localize(table: table)) {}
                    // Sound Recognition
                    SettingsLink(color: .red, icon: "waveform.and.magnifyingglass", id: "SOUND_RECOGNITION_TITLE".localize(table: titleTable), status: "OFF".localize(table: table)) {}
                    // RTT/TTY
                    SettingsLink(color: .green, icon: "teletype", id: "TTY_RTT_LABEL".localize(table: titleTable), status: "OFF".localize(table: table)) {}
                    // Audio & Visual
                    SettingsLink(color: .blue, icon: "speaker.eye.fill", id: "AUDIO_VISUAL_TITLE".localize(table: titleTable)) {}
                }
                // Subtitles & Captioning
                SettingsLink(color: .blue, icon: "captions.bubble.fill", id: "SUBTITLES_CAPTIONING".localize(table: titleTable)) {
                    SubtitlesCaptioningView()
                }
                if !UIDevice.IsSimulator {
                    // Live Captions
                    SettingsLink(icon: "waveform.bubble.fill", id: "RTT_LIVE_TRANSCRIPTIONS_LABEL".localize(table: table)) {}
                    if UIDevice.iPhone {
                        // Music Haptics
                        SettingsLink(color: .red, icon: "apple.haptics.and.music.note", id: "HAPTIC_MUSIC_TITLE".localize(table: hapticTable), status: "OFF".localize(table: table)) {}
                    }
                }
            } header: {
                Text("HEARING", tableName: titleTable)
            }
            
            // MARK: Speech
            Section {
                // Live Speech
                SettingsLink(color: .black, icon: "keyboard.badge.waveform.fill", id: "LIVE_SPEECH_TITLE".localize(table: titleTable), status: "OFF".localize(table: table)) {
                    LiveSpeechView()
                }
                if UIDevice.IsSimulator {
                    // Vocal Shortcuts
                    NavigationLink {
                        Text(String())
                            .onAppear {
                                exit(0)
                            }
                    } label: {
                        CustomNavigationLink(title: "ADAPTIVE_VOICE_SHORTCUTS_TITLE".localize(table: titleTable), status: "OFF".localize(table: table), destination: EmptyView())
                    }
                } else {
                    // Personal Voice
                    SettingsLink(color: .blue, icon: "person.badge.waveform.fill", id: "PERSONAL_VOICE_TITLE".localize(table: titleTable)) {}
                    // Vocal Shortcuts
                    SettingsLink(icon: "waveform.arrow.triangle.branch.right", id: "ADAPTIVE_VOICE_SHORTCUTS_TITLE".localize(table: titleTable), status: "OFF".localize(table: table)) {}
                }
            } header: {
                Text("SPEECH_HEADING", tableName: titleTable)
            }
            
            // MARK: Accessories
            Section {
                // Keyboards & Typing
                SettingsLink(color: .gray, icon: "keyboard.fill", id: "KEYBOARDS".localize(table: titleTable)) {
                    KeyboardsTypingView()
                }
                if !UIDevice.IsSimulator {
                    // Apple TV Remote
                    SettingsLink(color: .gray, icon: "appletvremote.gen4.fill", id: "APPLE_TV_REMOTE".localize(table: titleTable)) {}
                }
            } header: {
                Text("ACCESSORIES_HEADING", tableName: titleTable)
            }
            
            // MARK: General
            Section {
                if !UIDevice.IsSimulator {
                    // Guided Access
                    SettingsLink(icon: "lock.square.dotted", id: "GUIDED_ACCESS_TITLE".localize(table: titleTable), status: "OFF".localize(table: table)) {}
                    // Assistive Access
                    SettingsLink(color: .gray, icon: "apps.iphone.assistive.access", id: "CLARITY_UI_TITLE".localize(table: titleTable)) {}
                    // Siri
                    SettingsLink(color: .clear, icon: UIDevice.IntelligenceCapability ? colorScheme == .dark ? "siri" : "siriSymbolLight" : "appleSiri", id: "SIRI_SETTINGS_TITLE".localize(table: titleTable)) {}
                    // Accessibility Shortcut
                    SettingsLink(color: .blue, icon: "accessibility", id: "TRIPLE_CLICK_TITLE".localize(table: titleTable), status: "OFF".localize(table: table)) {}
                    // Per-App Settings
                    SettingsLink(color: .blue, icon: "app.badge.checkmark", id: "APP_AX_SETTINGS_TITLE".localize(table: titleTable)) {}
                }
            } header: {
                Text("GENERAL_HEADING", tableName: titleTable)
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("ROOT_LEVEL_TITLE", tableName: table)
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
