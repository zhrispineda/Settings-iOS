//
//  SiriVoiceView.swift
//  Preferences
//
//  Settings > Siri > Siri Voice
//

import SwiftUI

struct SiriVoiceView: View {
    // Variables
    @State private var selectedVariety = "REGION_en-US"
    let varietyOptions = ["REGION_en-US", "REGION_en-AU", "REGION_en-GB", "REGION_en-IN","REGION_en-IE", "REGION_en-ZA"]
    
    @State private var selectedAmericanVoice = "Voice 4"
    @State private var selectedBritishVoice = "Voice 3"
    @State private var selectedIndianVoice = "Voice 1"
    @State private var selectedOtherVoice = "Voice 2"
    
    let americanVoiceOptions = ["Voice 1", "Voice 2", "Voice 3", "Voice 4", "Voice 5"]
    let britishVoiceOptions = ["Voice 1", "Voice 2", "Voice 3", "Voice 4"]
    let voiceOptions = ["Voice 1", "Voice 2"]
    let table = "AssistantSettings"
    
    var body: some View {
        CustomList(title: "VOICE".localize(table: table), topPadding: true) {
            Section {
                Picker("VOICE".localize(table: table), selection: $selectedVariety) {
                    ForEach(varietyOptions, id: \.self) {
                        Text($0.localize(table: table))
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } header: {
                Text("VOICE_LANGUAGE_HEADER", tableName: table)
            }
            
            Section {
                switch selectedVariety {
                case "REGION_en-US":
                    Picker("", selection: $selectedAmericanVoice) {
                        ForEach(americanVoiceOptions, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.inline)
                    .labelsHidden()
                case "REGION_en-GB":
                    Picker("", selection: $selectedBritishVoice) {
                        ForEach(britishVoiceOptions, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.inline)
                    .labelsHidden()
                case "REGION_en-IN":
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
                Text("VOICE", tableName: table)
            }
        }
    }
}

#Preview {
    NavigationStack {
        SiriVoiceView()
    }
}
