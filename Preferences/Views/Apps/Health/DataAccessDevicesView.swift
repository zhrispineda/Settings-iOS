//
//  DataAccessDevicesView.swift
//  Preferences
//
//  Settings > Apps > Health > Data Access & Devices
//

import SwiftUI

struct DataAccessDevicesView: View {
    let wellness = "/System/Library/PrivateFrameworks/HealthToolbox.framework"
    let table = "WellnessDashboard-Localizable"
    
    var body: some View {
        CustomList(title: "SOURCES".localized(path: wellness, table: table), topPadding: true) {
            Section {
                Text("APPS_NONE".localized(path: wellness, table: table))
                    .foregroundStyle(.secondary)
            } header: {
                Text("APPS_LIST_HEADER".localized(path: wellness, table: table))
            } footer: {
                Text("APPS_LIST_EXPLANATION".localized(path: wellness, table: table))
            }
            
            Section {
                Text("APPS_NONE".localized(path: wellness, table: table))
                    .foregroundStyle(.secondary)
            } header: {
                Text("RESEARCH_STUDIES_LIST_HEADER".localized(path: wellness, table: table))
            } footer: {
                Text("RESEARCH_STUDIES_LIST_EXPLANATION".localized(path: wellness, table: table))
            }
            
            Section {
                Label(UIDevice.IsSimulator ? "\(UIDevice().systemName) Simulator" : UIDevice.current.model, systemImage: "\(UIDevice.current.model.lowercased())")
            } header: {
                Text("DEVICES_LIST_HEADER".localized(path: wellness, table: table))
            }
        }
    }
}

#Preview {
    NavigationStack {
        DataAccessDevicesView()
    }
}
