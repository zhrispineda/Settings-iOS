//
//  SiriAppClipsView.swift
//  Preferences
//
//  Settings > Siri > App Clips
//

import SwiftUI

struct SiriAppClipsView: View {
    // Variables
    @State private var learnAppClipsEnabled = true
    @State private var showSearchEnabled = true
    @State private var suggestAppClipsEnabled = true
    
    var body: some View {
        CustomList(title: "App Clips") {
            Section {
                Toggle("Learn from App Clips", isOn: $learnAppClipsEnabled)
            } header: {
                Text("In App Clips")
            } footer: {
                Text("Allow Siri to learn how you use app clips to make suggestions across apps.")
            }
            
            Section {
                Toggle("Show in Search", isOn: $showSearchEnabled)
                Toggle("Suggest App Clips", isOn: $suggestAppClipsEnabled)
            } header: {
                Text("On Home Screen")
            } footer: {
                Text("Allow Search and Shortcuts to show app clips. App clip suggestions are based on your location.")
            }
        }
    }
}

#Preview {
    SiriAppClipsView()
}
