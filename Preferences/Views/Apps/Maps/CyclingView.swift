//
//  CyclingView.swift
//  Preferences
//
//  Settings > Maps > Cycling
//

import SwiftUI

struct CyclingView: View {
    @State private var avoidHillsEnabled = false
    @State private var avoidBusyRoads = false
    let path = "/System/Library/PreferenceBundles/MapsSettings.bundle"
    
    var body: some View {
        CustomList(title: "Cycling Transportation Mode Label [Settings]".localized(path: path), topPadding: true) {
            Section {
                Toggle("Avoid Hills Switch Label [Settings]".localized(path: path), isOn: $avoidHillsEnabled)
                Toggle("Avoid Busy Roads Switch Label [Settings]".localized(path: path), isOn: $avoidBusyRoads)
            } header: {
                Text("Avoid Group Label [Settings]".localized(path: path))
            }
        }
    }
}

#Preview {
    NavigationStack {
        CyclingView()
    }
}
