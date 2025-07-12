//
//  HealthView.swift
//  Preferences
//
//  Settings > Apps > Health
//

import SwiftUI

struct HealthView: View {
    let path = "/System/Library/PrivateFrameworks/HealthUI.framework"
    let table = "HealthUI-Localizable"
    let wellTable = "WellnessDashboard-Localizable"
    let wellness = "/System/Library/PrivateFrameworks/HealthToolbox.framework"
    let settings = "/System/Library/PrivateFrameworks/HealthSettingsUI.framework"
    let specTable = "HealthSettingsSpecifiers"
    
    var body: some View {
        CustomList(title: "HEALTH".localized(path: path, table: table), topPadding: true) {
            PermissionsView(appName: "HEALTH".localized(path: path, table: table), cellular: false, location: false, cellularEnabled: .constant(false))
            
            Section {
                NavigationLink("HEALTH_PROFILE_TITLE".localized(path: wellness, table: wellTable), destination: HealthDetailsView())
                if UIDevice.iPhone {
                    NavigationLink("MEDICAL_ID".localized(path: wellness, table: wellTable), destination: MedicalView())
                }
            } header: {
                Text("DETAILS_GROUP_TITLE".localized(path: settings, table: specTable))
            }
            
            Section {
                NavigationLink("SOURCES_ITEM".localized(path: settings, table: specTable), destination: DataAccessDevicesView())
            } header: {
                Text("DATA_GROUP_TITLE".localized(path: settings, table: specTable))
            }
            
            if UIDevice.iPhone {
                Section {
                    Link("HEALTH_CHECKLIST_ITEM".localized(path: settings, table: specTable), destination: URL(string: "x-apple-health://")!)
                } footer: {
                    Text("HEALTH_CHECKLIST_FOOTER_PHONE_ONLY".localized(path: settings, table: specTable))
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
