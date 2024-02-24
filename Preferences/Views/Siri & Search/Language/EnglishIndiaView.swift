//
//  EnglishIndiaView.swift
//  Preferences
//
//  Settings > Siri & Search > Language > English (India)
//

import SwiftUI

struct EnglishIndiaView: View {
    @State private var selected = "English Only"
    let options = ["English & Hindi", "English Only"]
    
    var body: some View {
        CustomList(title: "English (India)") {
            Section(content: {}, footer: {
                Text("Siri can recognize multiple languages in India. You can speak to Siri using English mixed with Bangla, Gujarati, Hindi, Kannada, Malayalam, Marathi, Punjabi, Tamil, or Telugu. [Learn more...](https://support.apple.com/en-us/105012)")
            })
            
            Section(content: {
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        selected = option
                    }, label: {
                        Label(option, systemImage: selected == option ? "checkmark" : "")
                            .tint(.white)
                    })
                }
            }, header: {
                Text("Preferred Response Language")
            }, footer: {
                if selected == "English Only" {
                    Text("Siri will respond in English only.")
                } else {
                    Text("Siri will respond either in English or in Hindi, based on the primary language you use to interact with Siri. This selection applies to iOS only.")
                }
            })
        }
    }
}

#Preview {
    EnglishIndiaView()
}
