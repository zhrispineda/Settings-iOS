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
    
    var body: some View {
        CustomList(title: "Motion") {
            Section {
                Toggle("Reduce Motion", isOn: $reduceMotionEnabled)
            } footer: {
                Text("Reduce the motion of the user interface, including the parallax effect of icons.")
            }
            
            if reduceMotionEnabled {
                Section {
                    Toggle("Prefer Cross-Fade Transitions", isOn: $preferCrossFadeTransitionsEnabled)
                } footer: {
                    Text("Reduce the motion for user interface controls that slide in when appearing and disappearing.")
                }
            }
            
            Section {
                Toggle("Dim Flashing Lights", isOn: $dimFlashingLightsEnabled)
            } footer: {
                Text("Video content that depicts repeated flashing or strobing lights will be automatically dimmed.")
            }
            
            Section {
                Toggle("Auto-Play Animated Images", isOn: $autoPlayAnimatedImagesEnabled)
                Toggle("Auto-Play Video Previews", isOn: $autoPlayVideoPreviewsEnabled)
                Toggle("Auto-Play Message Effects", isOn: $autoPlayMessageEffectsEnabled)
            } footer: {
                Text("Control if videos, animated imags, and full screen effects in messages play automatically.")
            }
            
            Section {
                Toggle("Prefer Non-Blinking Cursor", isOn: $preferNonBlinkingCursor)
            } footer: {
                Text("Prefer the cursor indicator in text does not blink.")
            }
            
            if UIDevice.ProDevice {
                Section {
                    Toggle("Limit Frame Rate", isOn: $limitFrameRateEnabled)
                } footer: {
                    Text("Sets the maximum frame rate of the display to 60 frames per second.")
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
