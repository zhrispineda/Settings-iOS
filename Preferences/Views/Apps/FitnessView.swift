//
//  FitnessView.swift
//  Preferences
//
//  Settings > Apps > Fitness
//

import SwiftUI

struct FitnessView: View {
    // Variables
    @State private var cellularEnabled = true
    @State private var useSessionData = true
    
    var body: some View {
        CustomList(title: "Fitness", topPadding: true) {
            PermissionsView(appName: "Fitness", liveActivityToggle: true, location: false, notifications: false, cellularEnabled: $cellularEnabled)
            
            Section {
                Toggle("All Workout and Mindfulness Session Data", isOn: $useSessionData)
            } header: {
                Text("Fitness+")
            } footer: {
                Text("Fitness+ can make workout and mindfulness recommendations using data added to Health from other apps.")
            }
            
            Section {
                Button("See how your data is managed...") {}
            }
            
            Section("Activity Sharing") {
                Button("See how your data is managed...") {}
            }
        }
    }
}

#Preview {
    NavigationStack {
        FitnessView()
    }
}
