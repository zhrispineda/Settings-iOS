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
                Placard(title: "PLACARD_TITLE".localize(table: table), icon: "com.apple.graphic-icon.accessibility", description: "\(UIDevice.iPhone ? "PLACARD_SUBTITLE_IPHONE".localize(table: table) : "PLACARD_SUBTITLE_IPAD".localize(table: table)) [\("PLACARD_LEARN_MORE".localize(table: table))](pref://helpkit)", frameY: $frameY, opacity: $opacity)
            }
            
            // MARK: Vision
            Section {
                if !UIDevice.IsSimulator {
                    // VoiceOver
                    SLink("VOICEOVER_TITLE".localize(table: titleTable), icon: "com.apple.graphic-icon.voice-over", status: "OFF".localize(table: table)) {
                        BundleControllerView("AccessibilitySettings", controller: "VoiceOverController", title: "VOICEOVER_TITLE", table: table)
                    }
                    // Zoom
                    SLink("ZOOM_TITLE".localize(table: titleTable), icon: "com.apple.AccessibilityUIServer.zoom", status: "OFF".localize(table: table)) {
                        ZoomView()
                    }
                }
                if UIDevice.iPad {
                    // Hover Text
                    SLink("HOVERTEXT_TITLE".localize(table: titleTable), icon: "com.apple.AccessibilityUIServer.hovertext", status: "OFF".localize(table: table)) {
                        BundleControllerView("AccessibilitySettings", controller: "HoverTextController", title: "HOVERTEXT_TITLE", table: titleTable)
                    }
                }
                // Display & Text Size
                SLink("DISPLAY_AND_TEXT".localize(table: titleTable), icon: "com.apple.AccessibilityUIServer.text.size") {
                    BundleControllerView("AccessibilitySettings", controller: "AXDisplayController", title: "DISPLAY_AND_TEXT", table: "Accessibility")
                }
                // Motion
                SLink("MOTION_TITLE".localize(table: titleTable), icon: "com.apple.AccessibilityUIServer.motion") {
                    BundleControllerView("AccessibilitySettings", controller: "AXMotionController", title: "MOTION_TITLE", table: titleTable)
                }
                // Spoken Content
                SLink("SPEECH_TITLE".localize(table: titleTable), icon: "com.apple.graphic-icon.spoken-content") {
                    BundleControllerView("AccessibilitySettings", controller: "SpeechController", title: "SPEECH_TITLE", table: titleTable)
                }
                if !UIDevice.IsSimulator {
                    // Audio Descriptions
                    SLink("DESCRIPTIVE_VIDEO_SETTING".localize(table: titleTable), icon: "com.apple.AccessibilityUIServer.audio.descriptions", status: "OFF".localize(table: table)) {}
                }
            } header: {
                Text("VISION", tableName: titleTable)
            }
            
            // MARK: Physical and Motor
            Section {
                if !UIDevice.IsSimulator {
                    // Touch
                    SLink("TOUCH".localize(table: titleTable), icon: "com.apple.AccessibilityUIServer.touch") {
                        BundleControllerView("AccessibilitySettings", controller: "AXTouchAndReachability", title: "TOUCH", table: titleTable)
                    }
                }
                if UIDevice.PearlIDCapability {
                    // Face ID & Attention
                    SLink("FACE_ID".localize(table: titleTable), icon: "com.apple.graphic-icon.face-id") {
                        FaceAttentionView()
                    }
                }
                if !UIDevice.IsSimulator {
                    // Switch Control
                    SLink("ScannerSwitchTitle".localize(table: titleTable), icon: "com.apple.AccessibilityUIServer.switch.control", status: "OFF".localize(table: table)) {}
                    // Voice Control
                    SLink("CommandAndControlTitle".localize(table: titleTable), icon: "com.apple.AccessibilityUIServer.voice.control", status: "OFF".localize(table: table)) {}
                    // Eye Tracking
                    SLink("Eye Tracking", icon: "com.apple.AccessibilityUIServer.eye.tracking", status: "OFF".localize(table: table)) {}
                    if UIDevice.iPhone {
                        // Side Button
                        SLink("SIDE_CLICK_TITLE".localize(table: titleTable), icon: "com.apple.AccessibilityUIServer.side.button") {}
                        if UIDevice.AdvancedPhotographicStylesCapability {
                            // Camera Button
                            SLink("CAMERA_BUTTON_TITLE".localize(table: cameraTable), icon: "com.apple.AccessibilityUIServer.camera.button") {}
                        }
                        // Apple Watch Mirroring
                        SLink("APPLE_WATCH_REMOTE_SCREEN".localize(table: table), icon: "com.apple.AccessibilityUIServer.applewatch.remote.mirroring") {}
                    } else {
                        // Top Button
                        SLink("TOP_CLICK_TITLE".localize(table: table), icon: "com.apple.AccessibilityUIServer.top.button") {}
                        // Apple Pencil
                        SLink("PencilTitle".localize(table: table), icon: "com.apple.AccessibilityUIServer.pencil") {}
                    }
                }
                if UIDevice.iPhone {
                    // Control Nearby Devices
                    SLink("CONTROL_NEARBY_DEVICES".localize(table: table), icon: "com.apple.AccessibilityUIServer.control.nearby.devices") {
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
                    SLink("HEARING_AID_TITLE".localize(table: titleTable), icon: "com.apple.AccessibilityUIServer.hearing.devices") {}
                    // Hearing Control Center
                    SLink("HEARING_CONTROL_CENTER_TITLE".localize(table: table), icon: "com.apple.AccessibilityUIServer.hearing.control.center") {}
                    // Sound Recognition
                    SLink("SOUND_RECOGNITION_TITLE".localize(table: titleTable), icon: "com.apple.AccessibilityUIServer.sound.recognition", status: "OFF".localize(table: table)) {}
                    // RTT/TTY
                    SLink("TTY_RTT_LABEL".localize(table: titleTable), icon: "com.apple.AccessibilityUIServer.rtt.tty", status: "OFF".localize(table: table)) {}
                    // Audio & Visual
                    SLink("AUDIO_VISUAL_TITLE".localize(table: titleTable), icon: "com.apple.AccessibilityUIServer.audio.visual") {}
                }
                // Subtitles & Captioning
                SLink("SUBTITLES_CAPTIONING".localize(table: titleTable), icon: "com.apple.AccessibilityUIServer.subtitles.captioning") {
                    BundleControllerView("AccessibilitySettings", controller: "AXCaptioningController", title: "SUBTITLES_CAPTIONING", table: titleTable)
                }
                if !UIDevice.IsSimulator {
                    // Live Captions
                    SLink("RTT_LIVE_TRANSCRIPTIONS_LABEL".localize(table: table), icon: "com.apple.AccessibilityUIServer.live.captions") {}
                    if UIDevice.iPhone {
                        // Music Haptics
                        SLink("HAPTIC_MUSIC_TITLE".localize(table: hapticTable), icon: "com.apple.AccessibilityUIServer.music.haptics", status: "OFF".localize(table: table)) {}
                    }
                }
            } header: {
                Text("HEARING", tableName: titleTable)
            }
            
            // MARK: Speech
            Section {
                // Live Speech
                SLink("LIVE_SPEECH_TITLE".localize(table: titleTable), icon: "com.apple.AccessibilityUIServer.live.speech", status: "OFF".localize(table: table)) {
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
                    SLink("PERSONAL_VOICE_TITLE".localize(table: titleTable), icon: "com.apple.AccessibilityUIServer.personal.voice") {}
                    // Vocal Shortcuts
                    SLink("ADAPTIVE_VOICE_SHORTCUTS_TITLE".localize(table: titleTable), icon: "com.apple.AccessibilityUIServer.vocal.shortcuts", status: "OFF".localize(table: table)) {}
                }
            } header: {
                Text("SPEECH_HEADING", tableName: titleTable)
            }
            
            // MARK: Accessories
            Section {
                // Keyboards & Typing
                SLink("KEYBOARDS".localize(table: titleTable), icon: "com.apple.graphic-icon.keyboard") {
                    BundleControllerView("AccessibilitySettings", controller: "AXKeyboardsController", title: "KEYBOARDS", table: titleTable)
                }
                if !UIDevice.IsSimulator {
                    // Apple TV Remote
                    SLink("APPLE_TV_REMOTE".localize(table: titleTable), icon: "com.apple.graphic-icon.apple-tv-remote-settings") {}
                }
            } header: {
                Text("ACCESSORIES_HEADING", tableName: titleTable)
            }
            
            // MARK: General
            Section {
                if !UIDevice.IsSimulator {
                    // Guided Access
                    SLink("GUIDED_ACCESS_TITLE".localize(table: titleTable), icon: "com.apple.AccessibilityUIServer.guided.access", status: "OFF".localize(table: table)) {}
                    // Assistive Access
                    SLink("CLARITY_UI_TITLE".localize(table: titleTable), icon: "com.apple.AccessibilityUIServer.assistive.access") {}
                    // Siri
                    if siriEnabled {
                        SLink("SIRI_SETTINGS_TITLE".localize(table: titleTable), icon: UIDevice.IntelligenceCapability ? "com.apple.application-icon.siri-intelligence" : "com.apple.application-icon.siri") {}
                    }
                    // Accessibility Shortcut
                    SLink("TRIPLE_CLICK_TITLE".localize(table: titleTable), icon: "com.apple.graphic-icon.accessibility", status: "OFF".localize(table: table)) {}
                    // Per-App Settings
                    SLink("APP_AX_SETTINGS_TITLE".localize(table: titleTable), icon: "com.apple.AccessibilityUIServer.per.app.settings") {}
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
