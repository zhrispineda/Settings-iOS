//
//  WalkingView.swift
//  Preferences
//
//  Settings > Maps > Walking
//

import SwiftUI

struct WalkingView: View {
    @State private var avoidHillsEnabled = false
    @State private var avoidBusyRoadsEnabled = false
    @State private var avoidStairsEnabled = false
    @State private var raiseToView = true
    @State private var enhancedAccuracy = true
    let path = "/System/Library/PreferenceBundles/MapsSettings.bundle"
    
    var body: some View {
        CustomList(title: "Walking Transportation Mode Label [Settings]".localized(path: path), topPadding: true) {
            Section {
                Toggle("Avoid Hills Switch Label [Settings]".localized(path: path), isOn: $avoidHillsEnabled)
                Toggle("Avoid Busy Roads Switch Label [Settings]".localized(path: path), isOn: $avoidBusyRoadsEnabled)
                Toggle("Avoid Stairs Switch Label [Settings]".localized(path: path), isOn: $avoidStairsEnabled)
            } header: {
                Text("Avoid Group Label [Settings]".localized(path: path))
            }
            
            if UIDevice.iPhone {
                Section {
                    Toggle("Directions In The Real World Raise to View Switch Label [Settings]".localized(path: path), isOn: $raiseToView)
                } header: {
                    Text("Directions In The Real World Section Title [Settings]".localized(path: path))
                } footer: {
                    Text("Directions In The Real World Section Footer [Settings]".localized(path: path).replacing("{ARKIT_ICON}@", with: ""))
                }
                
                Section {
                    Toggle("Optical Heading Switch Label [Settings]".localized(path: path), isOn: $enhancedAccuracy)
                } header: {
                    Text("Optical Heading Section Title [Settings]".localized(path: path))
                } footer: {
                    Text("Optical Heading Section Footer [Settings]".localized(path: path))
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
