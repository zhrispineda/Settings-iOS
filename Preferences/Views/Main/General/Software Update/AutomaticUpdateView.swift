//
//  AutomaticUpdateView.swift
//  Preferences
//
//  Settings > General > Software Update > Automatic Updates
//

import SwiftUI

struct AutomaticUpdateView: View {
    // Variables
    @State private var automaticUpdatesEnabled = true
    @State private var securityResponsesEnabled = true
    @State private var automaticDownloadsEnabled = true
    
    var body: some View {
        CustomList(title: "Automatic Updates") {
            Section {
                Toggle("\(UIDevice().systemName) Updates", isOn: $automaticUpdatesEnabled)
                Toggle("Security Responses & System Files", isOn: $securityResponsesEnabled)
            } header: {
                Text("Automatically Install")
            } footer: {
                Text("Automatically install \(UIDevice().systemName) software updates when this \(Device().model) is connected to Wi-Fi, charging, and locked.")
            }
            
            Section {
                Toggle("\(UIDevice().systemName) Updates", isOn: $automaticDownloadsEnabled)
            } header: {
                Text("Automatically Download")
            } footer: {
                Text("\(UIDevice().systemName) software updates, Rapid Security Responses, and system files can be automatically downloaded and prepared for installation.")
            }
        }
    }
}

#Preview {
    NavigationStack {
        AutomaticUpdateView()
    }
}
