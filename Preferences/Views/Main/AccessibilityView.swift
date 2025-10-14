//
//  AccessibilityView.swift
//  Preferences
//
//  Settings > Accessibility
//

import SwiftUI

struct AccessibilityView: View {
    @AppStorage("SiriEnabled") private var siriEnabled = false
    @State private var opacity: Double = 0.0
    @State private var frameY: Double = 0.0
    @State private var showingHelpSheet = false
    let path = "/System/Library/PrivateFrameworks/AccessibilityUIUtilities.framework"
    let settings = "/System/Library/PreferenceBundles/AccessibilitySettings.bundle"
    let table = "Accessibility"
    let titleTable = "AccessibilityTitles"
    let cameraTable = "Accessibility-D93"
    let hapticTable = "Accessibility-HapticMusic"
    
    var body: some View {
        CustomList(title: "Accessibility".localize(table: table)) {
            // MARK: Placard
            Section {
                Placard(title: "PLACARD_TITLE".localized(path: settings, table: table), icon: "com.apple.graphic-icon.accessibility", description: "\(UIDevice.iPhone ? "PLACARD_SUBTITLE_IPHONE".localized(path: settings, table: table) : "PLACARD_SUBTITLE_IPAD".localized(path: settings, table: table)) [\("PLACARD_LEARN_MORE".localized(path: settings, table: table))](pref://helpkit)", frameY: $frameY, opacity: $opacity)
            }
            
            // MARK: Vision
            Section {
                if !UIDevice.IsSimulator {
                    // VoiceOver
                    SLink("VOICEOVER_TITLE".localized(path: settings, table: titleTable), icon: "com.apple.graphic-icon.voice-over", status: "OFF".localized(path: settings, table: table)) {
                        BundleControllerView("AccessibilitySettings", controller: "VoiceOverController", title: "VOICEOVER_TITLE", path: settings, table: titleTable)
                    }
                    // Zoom
                    SLink("ZOOM_TITLE".localized(path: settings, table: titleTable), icon: "com.apple.AccessibilityUIServer.zoom", status: "OFF".localized(path: settings, table: table)) {
                        ZoomView()
                    }
                }
                if UIDevice.iPad {
                    // Hover Text
                    SLink("HOVERTEXT_TITLE".localized(path: settings, table: titleTable), icon: "com.apple.AccessibilityUIServer.hovertext", status: "OFF".localized(path: settings, table: table)) {
                        BundleControllerView("AccessibilitySettings", controller: "HoverTextController", title: "HOVERTEXT_TITLE", table: titleTable)
                    }
                }
                // Display & Text Size
                SLink("DISPLAY_AND_TEXT".localized(path: settings, table: titleTable), icon: "com.apple.AccessibilityUIServer.text.size") {
                    BundleControllerView("AccessibilitySettings", controller: "AXDisplayController", title: "DISPLAY_AND_TEXT", path: settings , table: titleTable)
                }
                // Motion
                SLink("MOTION_TITLE".localized(path: settings, table: titleTable), icon: "com.apple.AccessibilityUIServer.motion") {
                    BundleControllerView("AccessibilitySettings", controller: "AXMotionController", title: "MOTION_TITLE", path: settings , table: titleTable)
                }
                // Spoken Content
                SLink("SPEECH_TITLE".localized(path: settings, table: titleTable), icon: "com.apple.graphic-icon.spoken-content") {
                    BundleControllerView("AccessibilitySettings", controller: "SpeechController", title: "SPEECH_TITLE", path: settings , table: titleTable)
                }
                if !UIDevice.IsSimulator {
                    // Audio Descriptions
                    SLink("DESCRIPTIVE_VIDEO_SETTING".localized(path: settings, table: titleTable), icon: "com.apple.AccessibilityUIServer.audio.descriptions", status: "OFF".localized(path: settings, table: table)) {}
                }
            } header: {
                Text("VISION".localized(path: settings, table: titleTable))
            }
            
            // MARK: Physical and Motor
            Section {
                if !UIDevice.IsSimulator {
                    // Touch
                    SLink("TOUCH".localized(path: settings, table: titleTable), icon: "com.apple.AccessibilityUIServer.touch") {
                        BundleControllerView("AccessibilitySettings", controller: "AXTouchAndReachability", title: "TOUCH", table: titleTable)
                    }
                }
                if UIDevice.PearlIDCapability {
                    // Face ID & Attention
                    SLink("FACE_ID".localized(path: settings, table: titleTable), icon: "com.apple.graphic-icon.face-id") {
                        FaceAttentionView()
                    }
                }
                if !UIDevice.IsSimulator {
                    // Switch Control
                    SLink("ScannerSwitchTitle".localized(path: settings, table: titleTable), icon: "com.apple.AccessibilityUIServer.switch.control", status: "OFF".localized(path: settings, table: table)) {}
                    // Voice Control
                    SLink("CommandAndControlTitle".localized(path: settings, table: titleTable), icon: "com.apple.AccessibilityUIServer.voice.control", status: "OFF".localized(path: settings, table: table)) {}
                    // Eye Tracking
                    SLink("Eye Tracking", icon: "com.apple.AccessibilityUIServer.eye.tracking", status: "OFF".localized(path: settings, table: table)) {}
                    if UIDevice.iPhone {
                        // Side Button
                        SLink("SIDE_CLICK_TITLE".localized(path: settings, table: titleTable), icon: "com.apple.AccessibilityUIServer.side.button") {}
                        if UIDevice.AdvancedPhotographicStylesCapability {
                            // Camera Button
                            SLink("CAMERA_BUTTON_TITLE".localized(path: path, table: cameraTable), icon: "com.apple.AccessibilityUIServer.camera.button") {}
                        }
                        // Apple Watch Mirroring
                        SLink("APPLE_WATCH_REMOTE_SCREEN".localized(path: settings, table: table), icon: "com.apple.AccessibilityUIServer.applewatch.remote.mirroring") {}
                    } else {
                        // Top Button
                        SLink("TOP_CLICK_TITLE".localized(path: settings, table: titleTable), icon: "com.apple.AccessibilityUIServer.top.button") {}
                        // Apple Pencil
                        SLink("PencilTitle".localized(path: settings, table: titleTable), icon: "com.apple.AccessibilityUIServer.pencil") {}
                    }
                }
                if UIDevice.iPhone {
                    // Control Nearby Devices
                    SLink("CONTROL_NEARBY_DEVICES".localized(path: settings, table: table), icon: "com.apple.AccessibilityUIServer.control.nearby.devices") {
                        ControlNearbyDevicesView()
                    }
                }
            } header: {
                Text("MOBILITY_HEADING".localized(path: settings, table: table))
            }
            
            // MARK: Hearing
            Section {
                if !UIDevice.IsSimulator {
                    // Hearing Devices
                    SLink("HEARING_AID_TITLE".localized(path: settings, table: table), icon: "com.apple.AccessibilityUIServer.hearing.devices") {}
                    // Hearing Control Center
                    SLink("HEARING_CONTROL_CENTER_TITLE".localized(path: settings, table: table), icon: "com.apple.AccessibilityUIServer.hearing.control.center") {}
                    // Sound Recognition
                    SLink("SOUND_RECOGNITION_TITLE".localized(path: settings, table: table), icon: "com.apple.AccessibilityUIServer.sound.recognition", status: "OFF".localized(path: settings, table: table)) {}
                    // RTT/TTY
                    SLink("TTY_RTT_LABEL".localized(path: settings, table: table), icon: "com.apple.AccessibilityUIServer.rtt.tty", status: "OFF".localized(path: settings, table: table)) {}
                    // Audio & Visual
                    SLink("AUDIO_VISUAL_TITLE".localized(path: settings, table: table), icon: "com.apple.AccessibilityUIServer.audio.visual") {}
                }
                // Subtitles & Captioning
                SLink("SUBTITLES_CAPTIONING".localized(path: settings, table: table), icon: "com.apple.AccessibilityUIServer.subtitles.captioning") {
                    BundleControllerView("AccessibilitySettings", controller: "AXCaptioningController", title: "SUBTITLES_CAPTIONING", table: titleTable)
                }
                if !UIDevice.IsSimulator {
                    // Live Captions
                    SLink("RTT_LIVE_TRANSCRIPTIONS_LABEL".localized(path: settings, table: table), icon: "com.apple.AccessibilityUIServer.live.captions") {}
                    if UIDevice.iPhone {
                        // Music Haptics
                        SLink("HAPTIC_MUSIC_TITLE".localized(path: path, table: hapticTable), icon: "com.apple.AccessibilityUIServer.music.haptics", status: "OFF".localized(path: settings, table: table)) {}
                    }
                }
            } header: {
                Text("HEARING".localized(path: settings, table: table))
            }
            
            // MARK: Speech
            Section {
                // Live Speech
                SLink("LIVE_SPEECH_TITLE".localized(path: settings, table: table), icon: "com.apple.AccessibilityUIServer.live.speech", status: "OFF".localized(path: settings, table: table)) {
                    BundleControllerView("AccessibilitySettings", controller: "LiveSpeechController", title: "LIVE_SPEECH_TITLE", table: titleTable)
                }
                if !UIDevice.IsSimulator {
                    // Personal Voice
                    SLink("PERSONAL_VOICE_TITLE".localized(path: settings, table: table), icon: "com.apple.AccessibilityUIServer.personal.voice") {}
                    // Vocal Shortcuts
                    SLink("ADAPTIVE_VOICE_SHORTCUTS_TITLE".localized(path: settings, table: table), icon: "com.apple.AccessibilityUIServer.vocal.shortcuts", status: "OFF".localized(path: settings, table: table)) {}
                }
            } header: {
                Text("SPEECH_HEADING".localized(path: settings, table: table))
            }
            
            // MARK: Accessories
            Section {
                // Keyboards & Typing
                SLink("KEYBOARDS".localized(path: settings, table: table), icon: "com.apple.graphic-icon.keyboard") {
                    BundleControllerView("AccessibilitySettings", controller: "AXKeyboardsController", title: "KEYBOARDS", table: titleTable)
                }
                if !UIDevice.IsSimulator {
                    // Apple TV Remote
                    SLink("APPLE_TV_REMOTE".localized(path: settings, table: table), icon: "com.apple.graphic-icon.apple-tv-remote-settings") {}
                }
            } header: {
                Text("ACCESSORIES_HEADING".localized(path: settings, table: table))
            }
            
            // MARK: General
            Section {
                if !UIDevice.IsSimulator {
                    // Guided Access
                    SLink("GUIDED_ACCESS_TITLE".localized(path: settings, table: table), icon: "com.apple.AccessibilityUIServer.guided.access", status: "OFF".localized(path: settings, table: table)) {}
                    // Assistive Access
                    SLink("CLARITY_UI_TITLE".localized(path: settings, table: titleTable), icon: "com.apple.AccessibilityUIServer.assistive.access") {}
                    // Siri
                    if siriEnabled {
                        SLink("SIRI_SETTINGS_TITLE".localized(path: settings, table: table), icon: UIDevice.IntelligenceCapability ? "com.apple.application-icon.siri-intelligence" : "com.apple.application-icon.siri") {}
                    }
                    // Accessibility Shortcut
                    SLink("TRIPLE_CLICK_TITLE".localized(path: settings, table: table), icon: "com.apple.graphic-icon.accessibility", status: "OFF".localized(path: settings, table: table)) {}
                    // Per-App Settings
                    SLink("APP_AX_SETTINGS_TITLE".localized(path: settings, table: titleTable), icon: "com.apple.AccessibilityUIServer.per.app.settings") {}
                    // Share Accessibility Settings
                    SLink("GUEST_PASS_TITLE".localized(path: settings, table: titleTable), icon: "com.apple.AccessibilityUIServer.guestpass", destination: ShareAccessibilitySettingsView())
                }
            } header: {
                Text("GENERAL_HEADING".localized(path: settings, table: table))
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
                Text("ROOT_LEVEL_TITLE".localized(path: settings, table: table))
                    .fontWeight(.semibold)
                    .font(.subheadline)
                    .opacity(frameY < 50.0 ? opacity : 0)
            }
        }
    }
}

#Preview {
    NavigationStack {
        AccessibilityView()
    }
}
