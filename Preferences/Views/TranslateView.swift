//
//  TranslateView.swift
//  Preferences
//
//  Settings > Translate
//

import SwiftUI

struct TranslateView: View {
    // Variables
    @State private var onDeviceModeEnabled = false
    
    var body: some View {
        CustomList(title: "Translate") {
            Section(content: {
                NavigationLink("Downloaded Languages", destination: {})
            }, footer: {
                Text("Download languages to translate when offline or when on-device mode is turned on.")
            })
            
            Section(content: {
                Toggle("On-Device Mode", isOn: $onDeviceModeEnabled)
            }, footer: {
                Text("Always translate offline using downloaded languages. Offline translations may not be as accurate as online translations. Siri and Safari will always process translations online.")
            })
            
            Section(content: {}, footer: {
                Text("[About Translation & Privacy...](#)")
            })
        }
    }
}

#Preview {
    TranslateView()
}
