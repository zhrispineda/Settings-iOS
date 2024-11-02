//
//  DataAccessDevicesView.swift
//  Preferences
//
//  Settings > Apps > Health > Data Access & Devices
//

import SwiftUI

struct DataAccessDevicesView: View {
    // Variables
    let table = "WellnessDashboard-Localizable"
    
    var body: some View {
        CustomList(title: "SOURCES".localize(table: table), topPadding: true) {
            Section {
                Text("APPS_NONE", tableName: table)
                    .foregroundStyle(.secondary)
            } header: {
                Text("APPS_LIST_HEADER", tableName: table)
            } footer: {
                Text("APPS_LIST_EXPLANATION", tableName: table)
            }
            
            Section {
                Text("APPS_NONE", tableName: table)
                    .foregroundStyle(.secondary)
            } header: {
                Text("RESEARCH_STUDIES_LIST_HEADER", tableName: table)
            } footer: {
                Text("RESEARCH_STUDIES_LIST_EXPLANATION", tableName: table)
            }
            
            Section {
                Label(UIDevice.IsSimulator ? "\(UIDevice().systemName) Simulator" : UIDevice.current.model, systemImage: "\(UIDevice.current.model.lowercased())")
            } header: {
                Text("DEVICES_LIST_HEADER", tableName: table)
            }
        }
    }
}

#Preview {
    NavigationStack {
        DataAccessDevicesView()
    }
}
