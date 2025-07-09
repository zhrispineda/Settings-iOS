//
//  DrivingView.swift
//  Preferences
//
//  Settings > Maps > Driving
//

import SwiftUI

struct DrivingView: View {
    @State private var avoidTollsEnabled = false
    @State private var avoidHighwaysEnabled = false
    let path = "/System/Library/PreferenceBundles/MapsSettings.bundle"
    
    var body: some View {
        CustomList(title: "Driving Transportation Mode Label [Settings]".localized(path: path), topPadding: true) {
            Section {
                Toggle("Avoid Tolls Switch Label [Settings]".localized(path: path), isOn: $avoidTollsEnabled)
                Toggle("Avoid Highways Switch Label [Settings]".localized(path: path), isOn: $avoidHighwaysEnabled)
            } header: {
                Text("Avoid Group Label [Settings]".localized(path: path))
            }
        }
    }
}

#Preview {
    NavigationStack {
        DrivingView()
    }
}
