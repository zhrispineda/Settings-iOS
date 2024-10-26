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
    let table = "Captioning"
    let profTable = "ProfileNames"
    let podTable = "Captioning-dinnerbell"
    
    var body: some View {
        CustomList(title: "CAPTIONING_TITLE".localize(table: table)) {
            Section {
                Toggle("PREFER_SDH".localize(table: table), isOn: $closedCaptionsSDHEnabled)
            } footer: {
                Text("SDH_FOOTER_TEXT", tableName: table)
            }
            
            Section {
                CustomNavigationLink(title: "CAPTION_THEME".localize(table: table), status: "MALocalize-MADefault".localize(table: profTable), destination: StyleView())
            }
            
            Section {
                Toggle("SHOW_AUDIO_TRANSCRIPTIONS".localize(table: podTable), isOn: $showAudioTranscriptionsEnabled)
            } footer: {
                Text("SHOW_AUDIO_TRANSCRIPTIONS_FOOTER", tableName: podTable)
            }
            
            Section {
                Toggle("SHOW_WHEN_MUTED".localize(table: table), isOn: $showWhenMuted)
            } header: {
                Text("AUTOMATIC_SUBTITLES", tableName: table)
            } footer: {
                Text("SHOW_WHEN_MUTED_FOOTER", tableName: table)
            }
            
            Section {
                Toggle("SHOW_ON_SKIP_BACK".localize(table: table), isOn: $showOnSkipBack)
            } footer: {
                Text("SHOW_ON_SKIP_BACK_FOOTER", tableName: table)
            }
        }
    }
}

#Preview {
    NavigationStack {
        SubtitlesCaptioningView()
    }
}
