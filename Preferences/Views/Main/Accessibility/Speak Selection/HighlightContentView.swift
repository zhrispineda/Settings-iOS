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
    @State private var selectedHighlightOption = "Words and Sentences"
    let highlightOptions = ["Words", "Sentences", "Words and Sentences"]
    @State private var selectedHighlightStyle = "Underline"
    let highlightStyles = ["Underline", "Background Color"]
    
    var body: some View {
        CustomList(title: "Highlight Content") {
            Section {
                Toggle("Highlight Content", isOn: $highlightContentEnabled.animation())
            }
            
            if highlightContentEnabled {
                Picker("", selection: $selectedHighlightOption.animation()) {
                    ForEach(highlightOptions, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
                
                if selectedHighlightOption != "Words" {
                    Picker("Sentence Highlight Style", selection: $selectedHighlightStyle) {
                        ForEach(highlightStyles, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.inline)
                }
                
                Section {
                    if selectedHighlightOption == "Words and Sentences" {
                        CustomNavigationLink(title: "Word Color", status: "Default", destination: HighlightColorView(title: "Word Color"))
                    }
                    CustomNavigationLink(title: "Sentence Color", status: "Default", destination: HighlightColorView(title: "Sentence Color"))
                } header: {
                    Text("Highlight Colors")
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
