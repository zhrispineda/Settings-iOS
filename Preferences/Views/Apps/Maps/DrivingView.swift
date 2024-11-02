//
//  DrivingView.swift
//  Preferences
//
//  Settings > Maps > Driving
//

import SwiftUI

struct DrivingView: View {
    // Variables
    @State private var avoidTollsEnabled = false
    @State private var avoidHighwaysEnabled = false
    let table = "MapsSettings"
    
    var body: some View {
        CustomList(title: "Driving Transportation Mode Label [Settings]".localize(table: table), topPadding: true) {
            Section {
                Toggle("Avoid Tolls Switch Label [Settings]".localize(table: table), isOn: $avoidTollsEnabled)
                Toggle("Avoid Highways Switch Label [Settings]".localize(table: table), isOn: $avoidHighwaysEnabled)
            } header: {
                Text("Avoid Group Label [Settings]", tableName: table)
            }
        }
    }
}

#Preview {
    NavigationStack {
        DrivingView()
    }
}
