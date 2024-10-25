//
//  MotionView.swift
//  Preferences
//
//  Settings > Accessibility > Motion
//

import SwiftUI

struct MotionView: View {
    // Variables
    @State private var reduceMotionEnabled = false
    @State private var preferCrossFadeTransitionsEnabled = false
    @State private var dimFlashingLightsEnabled = false
    @State private var autoPlayAnimatedImagesEnabled = true
    @State private var autoPlayVideoPreviewsEnabled = true
    @State private var autoPlayMessageEffectsEnabled = true
    @State private var preferNonBlinkingCursor = false
    @State private var limitFrameRateEnabled = false
    let table = "Accessibility"
    let localTable = "LocalizedStrings"
    let generalTable = "GeneralAccessibility"
    let animateTable = "Accessibility-AnimatedImages"
    
    var body: some View {
        CustomList(title: "MOTION_TITLE".localize(table: table)) {
            Section {
                Toggle("REDUCE_MOTION".localize(table: table), isOn: $reduceMotionEnabled)
            } footer: {
                Text("ReduceMotionFooterText", tableName: table)
            }
            
            if reduceMotionEnabled {
                Section {
                    Toggle("REDUCE_MOTION_REDUCE_SLIDE_ANIMATIONS".localize(table: table), isOn: $preferCrossFadeTransitionsEnabled)
                } footer: {
                    Text("REDUCE_MOTION_REDUCE_SLIDE_ANIMATIONS_FOOTER", tableName: table)
                }
            }
            
            Section {
                Toggle("DIM_FLASHING_LIGHTS_FULL_WIDTH".localize(table: localTable), isOn: $dimFlashingLightsEnabled)
            } footer: {
                Text("PSE_FOOTER_TEXT", tableName: generalTable)
            }
            
            Section {
                Toggle("REDUCE_MOTION_AUTOPLAY_ANIMATED_IMAGES".localize(table: animateTable), isOn: $autoPlayAnimatedImagesEnabled)
                Toggle("REDUCE_MOTION_AUTOPLAY_VIDEO_PREVIEWS".localize(table: table), isOn: $autoPlayVideoPreviewsEnabled)
                Toggle("REDUCE_MOTION_AUTOPLAY_MESSAGES_EFFECTS".localize(table: table), isOn: $autoPlayMessageEffectsEnabled)
            } footer: {
                Text("ReduceMotionFooterText_Autoplay", tableName: animateTable)
            }
            
            Section {
                Toggle("PREFER_NONBLINKING_CURSOR".localize(table: table), isOn: $preferNonBlinkingCursor)
            } footer: {
                Text("PREFER_NONBLINKING_CURSOR_FOOTER", tableName: table)
            }
            
            if UIDevice.ProDevice {
                Section {
                    Toggle("RefreshRateSlider".localize(table: table), isOn: $limitFrameRateEnabled)
                } footer: {
                    Text("RefreshRateFooterText", tableName: table)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        MotionView()
    }
}
