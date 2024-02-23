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
    
    var body: some View {
        CustomList(title: "Driving") {
            Section(content: {
                Toggle("Tolls", isOn: $avoidTollsEnabled)
                Toggle("Highways", isOn: $avoidHighwaysEnabled)
            }, header: {
                Text("\n\nAvoid")
            })
        }
    }
}

#Preview {
    DrivingView()
}
