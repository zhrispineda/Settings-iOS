//
//  PronunciationVoicesView.swift
//  Preferences
//
//  Settings > Accessibility > Spoken Content > Pronunciations > Replacement > Voices
//

import SwiftUI

struct PronunciationVoicesView: View {
    // Variables
    @State private var selected = ["All"]
    let languages = ["Albert", "Bad News", "Bahh", "Bells", "Boing", "Bubbles", "Cellos", "Fred", "Good News", "Jester", "Junior", "Kathy", "Organ", "Ralpha", "Samantha", "Siri Voice 4 (Enhanced)", "Superstar", "Trinoids", "Whisper", "Wobble", "Zarvox"]
    
    var body: some View {
        CustomList(title: "Voices") {
            Section {
                Button {
                    selected = ["All"]
                } label: {
                    HStack {
                        Text("All")
                            .foregroundStyle(Color["Label"])
                        Spacer()
                        if selected.contains("All") {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
            
            Section {
                ForEach(languages, id: \.self) { option in
                    Button {
                        if selected.contains("All") {
                            selected = []
                        }
                        if let index = selected.firstIndex(of: option) {
                            selected.remove(at: index)
                            if selected.isEmpty {
                                selected = ["All"]
                            }
                        } else {
                            selected.append(option)
                        }
                    } label: {
                        HStack {
                            Text(option)
                                .foregroundStyle(Color["Label"])
                            Spacer()
                            if selected.contains(option) {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        PronunciationVoicesView()
    }
}
