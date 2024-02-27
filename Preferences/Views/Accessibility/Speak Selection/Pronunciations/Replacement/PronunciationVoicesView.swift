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
                Button(action: {
                    selected = ["All"]
                }, label: {
                    HStack {
                        Text("All")
                            .foregroundStyle(Color(UIColor.label))
                        Spacer()
                        Image(systemName: "checkmark")
                            .opacity(selected.contains("All") ? 1 : 0)
                    }
                })
            }
            
            Section {
                ForEach(languages, id: \.self) { option in
                    Button(action: {
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
                    }, label: {
                        HStack {
                            Text(option)
                                .foregroundStyle(Color(UIColor.label))
                            Spacer()
                            Image(systemName: "checkmark")
                                .opacity(selected.contains(option) ? 1 : 0)
                        }
                    })
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
