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
    @State private var showWhenMuted = true
    @State private var showOnSkipBack = true
    
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
            
            Section {
                Toggle("Show when Muted", isOn: $showWhenMuted)
            } header: {
                Text("Automatic Subtitles")
            } footer: {
                Text("Automatically turn on subtitles when the volume is muted or turned all the way down.")
            }
            
            Section {
                Toggle("Show on Skip Back", isOn: $showOnSkipBack)
            } footer: {
                Text("Temporarily turn on subtitles when you skip back, up to 30 seconds.")
            }
        }
    }
}

#Preview {
    NavigationStack {
        SubtitlesCaptioningView()
    }
}
