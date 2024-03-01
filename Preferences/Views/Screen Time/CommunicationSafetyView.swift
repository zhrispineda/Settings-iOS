//
//  CommunicationSafetyView.swift
//  Preferences
//
//  Settings > Screen Time > Communication Safety
//

import SwiftUI

struct CommunicationSafetyView: View {
    // Variables
    @State private var communicationSafetyEnabled = false
    @State private var improveCommunicationSafety = false
    
    var body: some View {
        CustomList(title: "Communication Safety") {
            Section(content: {
                Toggle("Sensitive Content Warning", isOn: $communicationSafetyEnabled)
            }, header: {
                Text("\n\nSensitive Photos and Videos")
            }, footer: {
                Text("Communication Safety can detect nude photos and videos before they‘re sent or viewed on your child‘s device, and provide guidance and age-appropriate resources to help them make a safe choice. Apple does not have access to the photos or videos. [Learn more...](https://support.apple.com/en-us/HT212850)")
            })
            
            Section(content: {
                Button("View Child Safety Resources", action: {})
            }, footer: {
                Text("Resources to help have conversations with your child about digital safety topics like sexting and nudes.")
            })
            
            Section(content: {
                Toggle("Improve Communication Safety", isOn: $improveCommunicationSafety)
                    .disabled(!communicationSafetyEnabled)
            }, header: {
                Text("Analytics & Improvements")
            }, footer: {
                Text("Help Apple improve Communication Safety by sharing analytics and usage data. Analytics and data aggregated in a form that is not personally identifiable. No messages or media are shared with Apple. [About Improve Sensitive Content Safety & Privacy...](#)")
            })
        }
    }
}

#Preview {
    NavigationStack {
        CommunicationSafetyView()
    }
}
