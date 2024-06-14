//
//  ScreenDistanceView.swift
//  Preferences
//
//  Settings > Screen Time > Screen Distance
//

import SwiftUI

struct ScreenDistanceView: View {
    // Variables
    @State private var screenDistanceEnabled = false
    
    var body: some View {
        CustomList(title: "Screen Distance") {
            Section {
                Toggle("Screen Distance", isOn: $screenDistanceEnabled)
            } footer: {
                Text("To reduce eye strain, and the risk of myopia in children, Screen Distance will alert you to hold an iPhone or iPad with Face ID at a recommended distance.")
            }
        }
    }
}

#Preview {
    NavigationStack {
        ScreenDistanceView()
    }
}
