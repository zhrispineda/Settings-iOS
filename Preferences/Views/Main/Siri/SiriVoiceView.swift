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
    
    let AmericanVoiceOptions = ["Voice 1", "Voice 2", "Voice 3", "Voice 4", "Voice 5"]
    let BritishVoiceOptions = ["Voice 1", "Voice 2", "Voice 3", "Voice 4"]
    let voiceOptions = ["Voice 1", "Voice 2"]
    
    var body: some View {
        CustomList(title: "Siri Voice") {
            Section {
                ForEach(varietyOptions, id: \.self) { option in
                    Button { selectedVariety = option } label: {
                        HStack {
                            Text(option)
                                .foregroundStyle(Color["Label"])
                            Spacer()
                            if selectedVariety == option {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            } header: {
                Text("\n\nVariety")
            }
            
            Section {
                switch selectedVariety {
                case "American":
                    ForEach(AmericanVoiceOptions, id: \.self) { option in
                        Button { selectedAmericanVoice = option } label: {
                            HStack {
                                Text(option)
                                    .foregroundStyle(Color["Label"])
                                Spacer()
                                if selectedAmericanVoice == option {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                    }
                case "British":
                    ForEach(BritishVoiceOptions, id: \.self) { option in
                        Button { selectedBritishVoice = option } label: {
                            HStack {
                                Text(option)
                                    .foregroundStyle(Color["Label"])
                                Spacer()
                                if selectedBritishVoice == option {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                    }
                case "Indian":
                    ForEach(voiceOptions, id: \.self) { option in
                        Button { selectedIndianVoice = option } label: {
                            HStack {
                                Text(option)
                                    .foregroundStyle(Color["Label"])
                                Spacer()
                                if selectedIndianVoice == option {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                    }
                default:
                    ForEach(voiceOptions, id: \.self) { option in
                        Button { selectedOtherVoice = option } label: {
                            HStack {
                                Text(option)
                                    .foregroundStyle(Color["Label"])
                                Spacer()
                                if selectedOtherVoice == option {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                    }
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
