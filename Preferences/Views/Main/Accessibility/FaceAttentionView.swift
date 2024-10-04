//
//  FaceAttentionView.swift
//  Preferences
//
//  Settings > Accessibility > Face ID & Attention
//

import SwiftUI

struct FaceAttentionView: View {
    // Variables
    @State private var requireAttentionEnabled = true
    @State private var attentionAwareFeaturesEnabled = true
    @State private var hapticAuthentication = false
    
    var body: some View {
        CustomList(title: "Face ID & Attention") {
            if !UIDevice.IsSimulator {
                Section {
                    Toggle("Require Attention for Face ID", isOn: $requireAttentionEnabled)
                } footer: {
                    Text("TrueDepth camera will provide an additional level of security by verifying that you are looking at \(UIDevice.current.model) before unlocking. Some sunglasses may block attention detection.")
                }
            }
            
            Section {
                Toggle("Attention Aware Features", isOn: $attentionAwareFeaturesEnabled)
            } footer: {
                if UIDevice.iPhone {
                    Text("iPhone will check for attention before dimming the display, expanding a notification when locked, or lowering the volume of some alerts.")
                } else if UIDevice.iPad {
                    Text("iPad will check for attention before dimming the display or lowering the volume of some alerts.")
                }
            }
            
            if !UIDevice.IsSimulator && UIDevice.iPhone {
                Section {
                    Toggle("Haptic on Successful Authentication", isOn: $hapticAuthentication)
                } header: {
                    Text("Haptics")
                } footer: {
                    Text("Play a haptic when Face ID successfully unlocks iPhone, authorizes Apple Pay, or verifies iTunes and App Store purchases.")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        FaceAttentionView()
    }
}
