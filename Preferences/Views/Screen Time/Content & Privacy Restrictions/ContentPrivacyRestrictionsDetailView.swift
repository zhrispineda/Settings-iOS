//
//  ContentPrivacyRestrictionsDetailView.swift
//  Preferences
//
//  Settings > Screen Time > Content & Privacy Restrictions > [Selection]
//

import SwiftUI

struct ContentPrivacyRestrictionsDetailView: View {
    // Variables
    var title = String()
    @State private var selectedOption = "Allow Changes"
    let options = ["Allow Changes", "Don't Allow Changes"]
    
    var body: some View {
        CustomList(title: title) {
            Section(content: {
                ForEach(options, id: \.self) { option in
                    Button(action: { selectedOption = option }, label: {
                        HStack {
                            Text(option)
                                .foregroundStyle(Color(UIColor.label))
                            Spacer()
                            if selectedOption == option {
                                Image(systemName: "checkmark")
                            }
                        }
                    })
                }
            }, footer: {
                switch title {
                case "Media & Apple Music":
                    Text("Disallowing changes locks the settings below and prevents new apps from accessing Apple Music and using your media library.")
                case "Allow Apps to Request to Track":
                    Text("Disallowing changes disables the settings below and prevents new apps from requesting to track your activity across other companies' apps and websites.")
                case "Speech Recognition":
                    Text("Disallowing changes locks the setting shown below. New apps will be prevented from accessing speech recognition.")
                case "Microphone":
                    Text("Disallowing changes locks the settings shown below. New apps will be prevented from accessing the microphone.")
                case "Bluetooth Sharing":
                    Text("Disallowing changes locks the settings shown below. New apps will be prevented from sharing data via Bluetooth when you're not using them.")
                default:
                    Text("Disallowing changes locks the settings shown below and prevents new apps from using your \(title.lowercased()).")
                }
            })
            
            if title == "Photos" {
                Section(content: {
                    VStack(alignment: .leading) {
                        Text("**Full Photo Library Access**")
                        Text("No Items")
                            .foregroundStyle(.secondary)
                    }
                    .padding(3)
                }, footer: {
                    Text("Photos may contain data associated with location, depth information, captions, and audio.")
                })
            }
            
            Section(content: {
                if title == "Bluetooth Sharing" || title == "Microphone" {
                    SettingsLink(color: .white, icon: "appclip", id: "App Clips", content: { AppClipsView(completeView: false)
                    })
                }
            }, footer: {
                switch title {
                case "Media & Apple Music":
                    Text("Apps that have requested access to Apple Music, your music and video activity, and your media library appear here.")
                case "Allow Apps to Request to Track":
                    Text("Apps that have asked for permission to track your activity with an identifier will appear here. Tracking activity is blocked by apps that you've denied access to.")
                case "Speech Recognition":
                    Text("Applications that have requested access to speech recognition will appear here. Speech recognition sends recorded voice to Apple to process your requests")
                case "Microphone":
                    Text("Applications that have requested access to the microphone will appear here.")
                case "Bluetooth Sharing":
                    Text("Applications that have requested the ability to use Bluetooth will appear here.")
                case "Photos":
                    Text("Apps that have requested access to your photos will appear here.")
                default:
                    Text("Applications that have requested access to your \(title.lowercased()) will appear here.")
                }
            })
        }
    }
}

#Preview {
    ContentPrivacyRestrictionsDetailView()
}
