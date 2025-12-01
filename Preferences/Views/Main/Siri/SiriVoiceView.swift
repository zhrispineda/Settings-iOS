//
//  SiriVoiceView.swift
//  Preferences
//
//  Settings > Siri > Siri Voice
//

import SwiftUI

struct SiriVoiceView: View {
    @State private var selectedVariety = "REGION_en-US"
    @State private var selectedAmericanVoice = "Voice 4"
    @State private var selectedBritishVoice = "Voice 3"
    @State private var selectedIndianVoice = "Voice 1"
    @State private var selectedOtherVoice = "Voice 2"
    private let varietyOptions = ["REGION_en-US", "REGION_en-AU", "REGION_en-GB", "REGION_en-IN","REGION_en-IE", "REGION_en-ZA"]
    private let americanVoiceOptions = ["Voice 1", "Voice 2", "Voice 3", "Voice 4", "Voice 5"]
    private let britishVoiceOptions = ["Voice 1", "Voice 2", "Voice 3", "Voice 4"]
    private let voiceOptions = ["Voice 1", "Voice 2"]
    private let table = "AssistantSettings"
    private let path = "/System/Library/PrivateFrameworks/AssistantSettingsSupport.framework"
    
    var body: some View {
        CustomList(title: "VOICE".localized(path: path, table: table)) {
            Section {} footer: {
                Text("VOICE_FOOTER".localized(path: path, table: "AssistantVoice"))
            }
            
            Section {
                Picker("VOICE".localized(path: path, table: table), selection: $selectedVariety) {
                    ForEach(varietyOptions, id: \.self) {
                        Text($0.localized(path: path, table: table))
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } header: {
                Text("VOICE_LANGUAGE_VARIATION_HEADER".localized(path: path, table: table))
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
                Text("VOICE_GROUP_HEADER".localized(path: path, table: table))
            }
        }
    }
}

#Preview {
    NavigationStack {
        SiriVoiceView()
    }
}
