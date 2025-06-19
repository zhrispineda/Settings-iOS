//
//  AccessibilityView.swift
//  Preferences
//
//  Settings > Accessibility
//

import SwiftUI

struct AccessibilityView: View {
    // Variables
    @AppStorage("SiriEnabled") private var siriEnabled = false
    @Environment(\.colorScheme) private var colorScheme
    @State private var opacity: Double = 0.0
    @State private var frameY: Double = 0.0
    @State private var showingHelpSheet = false
    let table = "Accessibility"
    let titleTable = "AccessibilityTitles"
    let cameraTable = "Accessibility-D93"
    let hapticTable = "Accessibility-HapticMusic"
    
    var body: some View {
        CustomList(title: "Accessibility".localize(table: table)) {
            // MARK: Placard
            Section {
                Placard(title: "PLACARD_TITLE".localize(table: table), color: .blue, icon: "com.apple.graphic-icon.accessibility", description: "\(UIDevice.iPhone ? "PLACARD_SUBTITLE_IPHONE".localize(table: table) : "PLACARD_SUBTITLE_IPAD".localize(table: table)) [\("PLACARD_LEARN_MORE".localize(table: table))](pref://helpkit)", frameY: $frameY, opacity: $opacity)
            }
            
            // MARK: Vision
            Section {
                if !UIDevice.IsSimulator {
                    // VoiceOver
                    SLink("VOICEOVER_TITLE".localize(table: titleTable), color: .black, icon: "voiceover", status: "OFF".localize(table: table)) {
                        BundleControllerView("AccessibilitySettings", controller: "VoiceOverController", title: "VOICEOVER_TITLE", table: table)
                    }
                    // Zoom
                    SLink("ZOOM_TITLE".localize(table: titleTable), color: .black, icon: "arrowtriangles.up.right.down.left.magnifyingglass", status: "OFF".localize(table: table)) {
                        ZoomView()
                    }
                }
                if UIDevice.iPad {
                    // Hover Text
                    SLink("HOVERTEXT_TITLE".localize(table: titleTable), color: .blue, icon: "character.magnify", status: "OFF".localize(table: table)) {
                        BundleControllerView("AccessibilitySettings", controller: "HoverTextController", title: "HOVERTEXT_TITLE", table: titleTable)
                    }
                }
                // Display & Text Size
                SLink("DISPLAY_AND_TEXT".localize(table: titleTable), color: .blue, icon: "textformat.size") {
                    BundleControllerView("AccessibilitySettings", controller: "AXDisplayController", title: "DISPLAY_AND_TEXT", table: "Accessibility")
                }
                // Motion
                SLink("MOTION_TITLE".localize(table: titleTable), color: .green, icon: "circle.dotted.and.circle") {
                    BundleControllerView("AccessibilitySettings", controller: "AXMotionController", title: "MOTION_TITLE", table: titleTable)
                }
                // Spoken Content
                SLink("SPEECH_TITLE".localize(table: titleTable), color: .black, icon: "rectangle.3.group.bubble.fill") {
                    BundleControllerView("AccessibilitySettings", controller: "SpeechController", title: "SPEECH_TITLE", table: titleTable)
                }
                if !UIDevice.IsSimulator {
                    // Audio Descriptions
                    SLink("DESCRIPTIVE_VIDEO_SETTING".localize(table: titleTable), color: .blue, icon: "quote.bubble.fill", status: "OFF".localize(table: table)) {}
                }
            } header: {
                Text("VISION", tableName: titleTable)
            }
            
            // MARK: Physical and Motor
            Section {
                if !UIDevice.IsSimulator {
                    // Touch
                    SLink("TOUCH".localize(table: titleTable), color: .blue, icon: "hand.point.up.left.fill") {
                        BundleControllerView("AccessibilitySettings", controller: "AXTouchAndReachability", title: "TOUCH", table: titleTable)
                    }
                }
                if UIDevice.PearlIDCapability {
                    // Face ID & Attention
                    SLink("FACE_ID".localize(table: titleTable), color: .green, icon: "faceid") {
                        FaceAttentionView()
                    }
                }
                if !UIDevice.IsSimulator {
                    // Switch Control
                    SLink("ScannerSwitchTitle".localize(table: titleTable), color: .black, icon: "square.grid.2x2", status: "OFF".localize(table: table)) {}
                    // Voice Control
                    SLink("CommandAndControlTitle".localize(table: titleTable), color: .blue, icon: "voice.control", status: "OFF".localize(table: table)) {}
                    // Eye Tracking
                    SLink("Eye Tracking", color: .indigo, icon: "eye.tracking", status: "OFF".localize(table: table)) {}
                    if UIDevice.iPhone {
                        // Side Button
                        SLink("SIDE_CLICK_TITLE".localize(table: titleTable), color: .blue, icon: "iphone.side.button.arrow.left") {}
                        if UIDevice.AdvancedPhotographicStylesCapability {
                            // Camera Button
                            SLink("CAMERA_BUTTON_TITLE".localize(table: cameraTable), color: .blue, icon: "iphone.side.button.arrow.left") {}
                        }
                        // Apple Watch Mirroring
                        SLink("APPLE_WATCH_REMOTE_SCREEN".localize(table: table), color: .blue, icon: "inset.filled.applewatch.case") {}
                    } else {
                        // Top Button
                        SLink("TOP_CLICK_TITLE".localize(table: table), color: .blue, icon: "ipad.top.button.arrow.down") {}
                        // Apple Pencil
                        SLink("PencilTitle".localize(table: table), color: .gray, icon: "pencil") {}
                    }
                }
                if UIDevice.iPhone {
                    // Control Nearby Devices
                    SLink("CONTROL_NEARBY_DEVICES".localize(table: table), color: .blue, icon: "iphone.badge.dot.radiowaves.up.forward") {
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
                    SLink("HEARING_AID_TITLE".localize(table: titleTable), color: .blue, icon: "ear") {}
                    // Hearing Control Center
                    SLink("HEARING_CONTROL_CENTER_TITLE".localize(table: table), color: .gray, icon: "switch.2") {}
                    // Sound Recognition
                    SLink("SOUND_RECOGNITION_TITLE".localize(table: titleTable), color: .red, icon: "waveform.and.magnifyingglass", status: "OFF".localize(table: table)) {}
                    // RTT/TTY
                    SLink("TTY_RTT_LABEL".localize(table: titleTable), color: .green, icon: "teletype", status: "OFF".localize(table: table)) {}
                    // Audio & Visual
                    SLink("AUDIO_VISUAL_TITLE".localize(table: titleTable), color: .blue, icon: "speaker.eye.fill") {}
                }
                // Subtitles & Captioning
                SLink("SUBTITLES_CAPTIONING".localize(table: titleTable), color: .blue, icon: "captions.bubble.fill") {
                    BundleControllerView("AccessibilitySettings", controller: "AXCaptioningController", title: "SUBTITLES_CAPTIONING", table: titleTable)
                }
                if !UIDevice.IsSimulator {
                    // Live Captions
                    SLink("RTT_LIVE_TRANSCRIPTIONS_LABEL".localize(table: table), color: .black, icon: "waveform.bubble.fill") {}
                    if UIDevice.iPhone {
                        // Music Haptics
                        SLink("HAPTIC_MUSIC_TITLE".localize(table: hapticTable), color: .red, icon: "apple.haptics.and.music.note", status: "OFF".localize(table: table)) {}
                    }
                }
            } header: {
                Text("HEARING", tableName: titleTable)
            }
            
            // MARK: Speech
            Section {
                // Live Speech
                SLink("LIVE_SPEECH_TITLE".localize(table: titleTable), color: .black, icon: "keyboard.badge.waveform.fill", status: "OFF".localize(table: table)) {
                    BundleControllerView("AccessibilitySettings", controller: "LiveSpeechController", title: "LIVE_SPEECH_TITLE", table: titleTable)
                }
                if UIDevice.IsSimulator {
                    // Vocal Shortcuts
                    NavigationLink {
                        Text(String())
                            .onAppear {
                                exit(0)
                            }
                    } label: {
                        SettingsLink("ADAPTIVE_VOICE_SHORTCUTS_TITLE".localize(table: titleTable), status: "OFF".localize(table: table), destination: EmptyView())
                    }
                } else {
                    // Personal Voice
                    SLink("PERSONAL_VOICE_TITLE".localize(table: titleTable), color: .blue, icon: "person.badge.waveform.fill") {}
                    // Vocal Shortcuts
                    SLink("ADAPTIVE_VOICE_SHORTCUTS_TITLE".localize(table: titleTable), color: .black, icon: "waveform.arrow.triangle.branch.right", status: "OFF".localize(table: table)) {}
                }
            } header: {
                Text("SPEECH_HEADING", tableName: titleTable)
            }
            
            // MARK: Accessories
            Section {
                // Keyboards & Typing
                SLink("KEYBOARDS".localize(table: titleTable), color: .gray, icon: "keyboard.fill") {
                    BundleControllerView("AccessibilitySettings", controller: "AXKeyboardsController", title: "KEYBOARDS", table: titleTable)
                }
                if !UIDevice.IsSimulator {
                    // Apple TV Remote
                    SLink("APPLE_TV_REMOTE".localize(table: titleTable), color: .gray, icon: "appletvremote.gen4.fill") {}
                }
            } header: {
                Text("ACCESSORIES_HEADING", tableName: titleTable)
            }
            
            // MARK: General
            Section {
                if !UIDevice.IsSimulator {
                    // Guided Access
                    SLink("GUIDED_ACCESS_TITLE".localize(table: titleTable), color: .black, icon: "lock.square.dotted", status: "OFF".localize(table: table)) {}
                    // Assistive Access
                    SLink("CLARITY_UI_TITLE".localize(table: titleTable), color: .gray, icon: "apps.iphone.assistive.access") {}
                    // Siri
                    if siriEnabled {
                        SLink("SIRI_SETTINGS_TITLE".localize(table: titleTable), color: .clear, icon: UIDevice.IntelligenceCapability ? colorScheme == .dark ? "siri" : "siriSymbolLight" : "appleSiri") {}
                    }
                    // Accessibility Shortcut
                    SLink("TRIPLE_CLICK_TITLE".localize(table: titleTable), color: .blue, icon: "accessibility", status: "OFF".localize(table: table)) {}
                    // Per-App Settings
                    SLink("APP_AX_SETTINGS_TITLE".localize(table: titleTable), color: .blue, icon: "app.badge.checkmark") {}
                }
            } header: {
                Text("GENERAL_HEADING", tableName: titleTable)
            }
        }
        .onOpenURL { url in
            if url.absoluteString == "pref://helpkit" {
                showingHelpSheet = true
            }
        }
        .sheet(isPresented: $showingHelpSheet) {
            HelpKitView(topicID: UIDevice.iPhone ? "iph3e2e4367" : "ipad9a2465f9")
                .ignoresSafeArea(edges: .bottom)
                .interactiveDismissDisabled()
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

struct AccessibilityRoute: Routable {
    func destination() -> AnyView {
        AnyView(AccessibilityView())
    }
}

#Preview {
    NavigationStack {
        AccessibilityView()
    }
}
