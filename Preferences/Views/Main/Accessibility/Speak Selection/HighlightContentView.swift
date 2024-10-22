//
//  HighlightContentView.swift
//  Preferences
//
//  Settings > Accessibility > Spoken Content > Highlight Content
//

import SwiftUI

struct HighlightContentView: View {
    // Variables
    @State private var highlightContentEnabled = false
    @State private var selectedHighlightOption = "WORDS_AND_SENTENCES"
    let highlightOptions = ["WORDS", "SENTENCES", "WORDS_AND_SENTENCES"]
    @State private var selectedHighlightStyle = "UNDERLINE"
    let highlightStyles = ["UNDERLINE", "HIGHLIGHT"]
    let table = "HighlightContentSettings"
    let accTable = "Accessibility"
    
    var body: some View {
        CustomList(title: "HIGHLIGHT_CONTENT".localize(table: table)) {
            Section {
                Toggle("HIGHLIGHT_CONTENT".localize(table: table), isOn: $highlightContentEnabled.animation())
            }
            
            if highlightContentEnabled {
                Picker("", selection: $selectedHighlightOption.animation()) {
                    ForEach(highlightOptions, id: \.self) { option in
                        Text(option.localize(table: table))
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
                
                if selectedHighlightOption != "Words" {
                    Picker("SENTENCE_HIGHLIGHT_STYLE".localize(table: table), selection: $selectedHighlightStyle) {
                        ForEach(highlightStyles, id: \.self) { option in
                            Text(option.localize(table: table))
                        }
                    }
                    .pickerStyle(.inline)
                }
                
                Section {
                    if selectedHighlightOption == "WORDS_AND_SENTENCES" {
                        CustomNavigationLink(title: "WORD_COLOR".localize(table: table), status: "DEFAULT".localize(table: accTable), destination: HighlightColorView(title: "WORD_COLOR"))
                    }
                    CustomNavigationLink(title: "SENTENCE_COLOR".localize(table: table), status: "DEFAULT".localize(table: accTable), destination: HighlightColorView(title: "SENTENCE_COLOR"))
                } header: {
                    Text("COLOR_CHOICE", tableName: table)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        HighlightContentView()
    }
}
