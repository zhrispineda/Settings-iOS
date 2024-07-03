//
//  WalkingView.swift
//  Preferences
//
//  Settings > Maps > Walking
//

import SwiftUI

struct WalkingView: View {
    // Variables
    @State private var avoidHillsEnabled = false
    @State private var avoidBusyRoadsEnabled = false
    @State private var avoidStairsEnabled = false
    @State private var raiseToView = true
    @State private var enhancedAccuracy = true
    
    var body: some View {
        CustomList(title: "Walking") {
            Section {
                Toggle("Hills", isOn: $avoidHillsEnabled)
                Toggle("Busy Roads", isOn: $avoidBusyRoadsEnabled)
                Toggle("Stairs", isOn: $avoidStairsEnabled)
            } header: {
                Text("Avoid")
            }
            
            if Device().isPhone {
                Section {
                    Toggle("Raise to View", isOn: $raiseToView)
                } header: {
                    Text("Directions in the Real World")
                } footer: {
                    Text("After you tap \(Image(systemName: "cube.transparent")) you can view directions in the real world simply by raising your iPhone.")
                }
                
                Section {
                    Toggle("Enhanced", isOn: $enhancedAccuracy)
                } header: {
                    Text("Navigation Accuracy")
                } footer: {
                    Text("Use iPhone‘s camera and motion sensors to improve the accuracy of your location and direction when navigating. Camera and sensor data aren‘t stored. Turning this on may use more battery power.")
                }
            }
        }
    }
}

#Preview {
    WalkingView()
}
