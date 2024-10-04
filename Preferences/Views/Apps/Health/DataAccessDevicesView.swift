//
//  DataAccessDevicesView.swift
//  Preferences
//
//  Settings > Apps > Health > Data Access & Devices
//

import SwiftUI

struct DataAccessDevicesView: View {
    var body: some View {
        CustomList(title: "Sources") {
            Section {
                Text("None")
                    .foregroundStyle(.secondary)
            } header: {
                Text("Apps and Services")
            } footer: {
                Text("As apps and services request permission to update your Health data, they will be added to the list.")
            }
            
            Section {
                Text("None")
                    .foregroundStyle(.secondary)
            } header: {
                Text("Research Study")
            } footer: {
                Text("As research studies request permission to read your data, they will be added to the list. You can review and manage all of the studies you are enrolled in by going to the Research app.")
            }
            
            Section {
                Label(UIDevice.IsSimulator ? "\(UIDevice().systemName) Simulator" : UIDevice.current.model, systemImage: "\(UIDevice.current.model.lowercased())")
            } header: {
                Text("Devices")
            }
        }
    }
}

#Preview {
    NavigationStack {
        DataAccessDevicesView()
    }
}
