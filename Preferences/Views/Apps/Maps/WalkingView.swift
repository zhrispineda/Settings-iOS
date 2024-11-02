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
    let table = "MapsSettings"
    
    var body: some View {
        CustomList(title: "Walking Transportation Mode Label [Settings]".localize(table: table), topPadding: true) {
            Section {
                Toggle("Avoid Hills Switch Label [Settings]".localize(table: table), isOn: $avoidHillsEnabled)
                Toggle("Avoid Busy Roads Switch Label [Settings]".localize(table: table), isOn: $avoidBusyRoadsEnabled)
                Toggle("Avoid Stairs Switch Label [Settings]".localize(table: table), isOn: $avoidStairsEnabled)
            } header: {
                Text("Avoid Group Label [Settings]", tableName: table)
            }
            
            if UIDevice.iPhone {
                Section {
                    Toggle("Directions In The Real World Raise to View Switch Label [Settings]".localize(table: table), isOn: $raiseToView)
                } header: {
                    Text("Directions In The Real World Section Title [Settings]", tableName: table)
                } footer: {
                    Text(NSLocalizedString("Directions In The Real World Section Footer [Settings]", tableName: table, comment: "").replacing("%{ARKIT_ICON}@", with: String()))
                }
                
                Section {
                    Toggle("Optical Heading Switch Label [Settings]".localize(table: table), isOn: $enhancedAccuracy)
                } header: {
                    Text("Optical Heading Section Title [Settings]", tableName: table)
                } footer: {
                    Text("Optical Heading Section Footer [Settings]", tableName: table)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        WalkingView()
    }
}
