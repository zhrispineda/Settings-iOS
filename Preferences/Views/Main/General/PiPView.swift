//
//  PiPView.swift
//  Preferences
//
//  Settings > General > Picture in Picture
//

import SwiftUI

struct PiPView: View {
    // Variables
    @State private var startAutomatically = true
    var body: some View {
        CustomList(title: "Picture in Picture", topPadding: true) {
            Section {
                Toggle("Start PiP Automatically", isOn: $startAutomatically)
            } header: {
                Text("Picture in Picture")
            } footer: {
                if UIDevice.HomeButtonCapability {
                    Text("When this is on, videos will continue playing in an overlay, even when you press the Home Button.")
                } else {
                    Text("When you swipe up to go Home or use other apps, videos and FaceTime calls will automatically continue in Picture in Picture.")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        PiPView()
    }
}
