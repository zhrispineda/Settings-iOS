//
//  HealthView.swift
//  Preferences
//
//  Settings > Apps > Health
//

import SwiftUI

struct HealthView: View {
    // Variables
    let table = "HealthUI-Localizable"
    let wellTable = "WellnessDashboard-Localizable"
    let specTable = "HealthSettingsSpecifiers"
    
    var body: some View {
        CustomList(title: "HEALTH".localize(table: table), topPadding: true) {
            PermissionsView(appName: "HEALTH".localize(table: table), cellular: false, location: false, cellularEnabled: .constant(false))
            
            Section {
                NavigationLink("HEALTH_PROFILE_TITLE".localize(table: wellTable), destination: HealthDetailsView())
                if UIDevice.iPhone {
                    NavigationLink("MEDICAL_ID".localize(table: wellTable), destination: MedicalView())
                }
            } header: {
                Text("DETAILS_GROUP_TITLE", tableName: specTable)
            }
            
            Section {
                NavigationLink("SOURCES_ITEM".localize(table: specTable), destination: DataAccessDevicesView())
            } header: {
                Text("DATA_GROUP_TITLE", tableName: specTable)
            }
            
            if UIDevice.iPhone {
                Section {
                    Link("HEALTH_CHECKLIST_ITEM".localize(table: specTable), destination: URL(string: "x-apple-health://")!)
                } footer: {
                    Text("HEALTH_CHECKLIST_FOOTER_PHONE_ONLY", tableName: specTable)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        HealthView()
    }
}
