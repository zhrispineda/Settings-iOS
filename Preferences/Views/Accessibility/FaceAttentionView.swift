//
//  FaceAttentionView.swift
//  Preferences
//
//  Settings > Accessibility > Face ID & Attention
//

import SwiftUI

struct FaceAttentionView: View {
    // Variables
    @State private var attentionAwareFeatures = true
    
    var body: some View {
        CustomList(title: "Face ID & Attention") {
            Section(content: {
                Toggle("Attention Aware Features", isOn: $attentionAwareFeatures)
            }, footer: {
                if Device().isPhone {
                    Text("iPhone will check for attention before dimming the display, expanding a notification when locked, or lowering the volume of some alerts.")
                } else if Device().isTablet {
                    Text("iPad will check for attention before dimming the display or lowering the volume of some alerts.")
                }
            })
        }
    }
}

#Preview {
    NavigationStack {
        FaceAttentionView()
    }
}
