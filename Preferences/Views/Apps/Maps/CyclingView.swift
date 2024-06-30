//
//  CyclingView.swift
//  Preferences
//
//  Settings > Maps > Cycling
//

import SwiftUI

struct CyclingView: View {
    // Variables
    @State private var avoidHillsEnabled = false
    @State private var avoidBusyRoads = false
    
    var body: some View {
        CustomList(title: "Cycling") {
            Section {
                Toggle("Hills", isOn: $avoidHillsEnabled)
                Toggle("Busy Roads", isOn: $avoidBusyRoads)
            } header: {
                Text("Avoid")
            }
        }
    }
}

#Preview {
    CyclingView()
}
