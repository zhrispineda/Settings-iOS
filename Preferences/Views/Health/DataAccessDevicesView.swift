//
//  DataAccessDevicesView.swift
//  Preferences
//
//  Settings > Health > Data Access & Devices
//

import SwiftUI

struct DataAccessDevicesView: View {
    var body: some View {
        CustomList(title: "Sources") {
            Section(content: {
                Text("None")
                    .foregroundStyle(.secondary)
            }, header: {
                Text("\n\nApps and Services")
            }, footer: {
                Text("As apps and services request permission to update your Health data, they will be added to the list.")
            })
            
            Section(content: {
                Text("None")
                    .foregroundStyle(.secondary)
            }, header: {
                Text("Research Study")
            }, footer: {
                Text("As research studies request permission to read your data, they will be added to the list. You can review and manage all of the studies you are enrolled in by going to the Research app.")
            })
            
            Section(content: {
                Label("iOS Simulator", systemImage: "iphone")
            }, header: {
                Text("Devices")
            })
        }
    }
}

#Preview {
    NavigationStack {
        DataAccessDevicesView()
    }
}
