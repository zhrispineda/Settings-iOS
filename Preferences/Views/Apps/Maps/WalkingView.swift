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
    
    var body: some View {
        CustomList(title: "Walking") {
            Section {
                Toggle("Hills", isOn: $avoidHillsEnabled)
                Toggle("Busy Roads", isOn: $avoidBusyRoadsEnabled)
                Toggle("Stairs", isOn: $avoidStairsEnabled)
            } header: {
                Text("Avoid")
            }
        }
    }
}

#Preview {
    WalkingView()
}
