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
    let table = "MapsSettings"
    
    var body: some View {
        CustomList(title: "Cycling Transportation Mode Label [Settings]".localize(table: table), topPadding: true) {
            Section {
                Toggle("Avoid Hills Switch Label [Settings]".localize(table: table), isOn: $avoidHillsEnabled)
                Toggle("Avoid Busy Roads Switch Label [Settings]".localize(table: table), isOn: $avoidBusyRoads)
            } header: {
                Text("Avoid Group Label [Settings]", tableName: table)
            }
        }
    }
}

#Preview {
    NavigationStack {
        CyclingView()
    }
}
