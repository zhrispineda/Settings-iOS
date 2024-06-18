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
                Section {
                    ForEach(highlightOptions, id: \.self) { option in
                        Button {
                            withAnimation {
                                selectedHighlightOption = option
                            }
                        } label: {
                            HStack {
                                Text(option)
                                    .foregroundStyle(Color["Label"])
                                Spacer()
                                if selectedHighlightOption == option {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                    }
                }
                
                if selectedHighlightOption != "Words" {
                    Section {
                        ForEach(highlightStyles, id: \.self) { option in
                            Button {
                                selectedHighlightStyle = option
                            } label: {
                                HStack {
                                    Text(option)
                                        .foregroundStyle(Color["Label"])
                                    Spacer()
                                    if selectedHighlightOption == option {
                                        Image(systemName: "checkmark")
                                    }
                                }
                            }
                        }
                    } header: {
                        Text("Sentence Highlight Style")
                    }
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
