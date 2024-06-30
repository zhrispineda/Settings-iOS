//
//  SiriVoiceView.swift
//  Preferences
//
//  Settings > Siri > Siri Voice
//

import SwiftUI

struct SiriVoiceView: View {
    // Variables
    @State private var selectedVariety = "American"
    let varietyOptions = ["American", "Australian", "British", "Indian"," Irish", "South African"]
    
    @State private var selectedAmericanVoice = "Voice 4"
    @State private var selectedBritishVoice = "Voice 3"
    @State private var selectedIndianVoice = "Voice 1"
    @State private var selectedOtherVoice = "Voice 2"
    
    let americanVoiceOptions = ["Voice 1", "Voice 2", "Voice 3", "Voice 4", "Voice 5"]
    let britishVoiceOptions = ["Voice 1", "Voice 2", "Voice 3", "Voice 4"]
    let voiceOptions = ["Voice 1", "Voice 2"]
    
    var body: some View {
        CustomList(title: "Siri Voice") {
            Section {
                Picker("", selection: $selectedVariety) {
                    ForEach(varietyOptions, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } header: {
                Text("Variety")
            }
            
            Section {
                switch selectedVariety {
                case "American":
                    Picker("", selection: $selectedAmericanVoice) {
                        ForEach(americanVoiceOptions, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.inline)
                    .labelsHidden()
                case "British":
                    Picker("", selection: $selectedBritishVoice) {
                        ForEach(britishVoiceOptions, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.inline)
                    .labelsHidden()
                case "Indian":
                    Picker("", selection: $selectedIndianVoice) {
                        ForEach(voiceOptions, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.inline)
                    .labelsHidden()
                default:
                    Picker("", selection: $selectedOtherVoice) {
                        ForEach(voiceOptions, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.inline)
                    .labelsHidden()
                }
            } header: {
                Text("Voice")
            }
        }
    }
}

#Preview {
    SiriVoiceView()
}
