//
//  SubtitlesCaptioningView.swift
//  Preferences
//
//  Settings > Accessibility > Subtitles & Captioning
//

import SwiftUI

struct SubtitlesCaptioningView: View {
    // Variables
    @State private var closedCaptionsSDHEnabled = false
    @State private var showAudioTranscriptionsEnabled = false
    
    var body: some View {
        CustomList(title: "Subtitles & Captioning") {
            Section {
                Toggle("Closed Captioning + SDH", isOn: $closedCaptionsSDHEnabled)
            } footer: {
                Text("When available, prefer captioning or subtitles for the deaf and hard of hearing.")
            }
            
            Section {
                CustomNavigationLink(title: "Style", status: "Transparent Background", destination: StyleView())
            }
            
            Section {
                Toggle("Show Audio Transcriptions", isOn: $showAudioTranscriptionsEnabled)
            } footer: {
                Text("Show audio transcriptions for announcements from HomePod.")
            }
        }
    }
}

#Preview {
    NavigationStack {
        SubtitlesCaptioningView()
    }
}
