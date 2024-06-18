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
    
    var body: some View {
        CustomList(title: "Face ID & Attention") {
            Section {
                Toggle("Require Attention for Face ID", isOn: $requireAttentionEnabled)
            } footer: {
                Text("TrueDepth camera will provide an additional level of security by verifying that you are looking at \(Device().model) before unlocking. Some sunglasses may block attention detection.")
            }
            
            Section {
                Toggle("Attention Aware Features", isOn: $attentionAwareFeaturesEnabled)
            } footer: {
                if Device().isPhone {
                    Text("iPhone will check for attention before dimming the display, expanding a notification when locked, or lowering the volume of some alerts.")
                } else if Device().isTablet {
                    Text("iPad will check for attention before dimming the display or lowering the volume of some alerts.")
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
