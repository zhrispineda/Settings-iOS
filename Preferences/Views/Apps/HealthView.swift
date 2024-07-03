//
//  HealthView.swift
//  Preferences
//
//  Settings > Apps > Health
//

import SwiftUI

struct HealthView: View {
    var body: some View {
        CustomList(title: "Health") {
            PermissionsView(appName: "Health", cellular: false, location: false, cellularEnabled: .constant(false))
            
            Section {
                NavigationLink("Health Details", destination: HealthDetailsView())
                if Device().isPhone {
                    NavigationLink("Medical ID", destination: MedicalView())
                }
            } header: {
                Text("Medical Details")
            }
            
            Section {
                NavigationLink("Data Access & Devices", destination: DataAccessDevicesView())
            } header: {
                Text("Data")
            }
            
            if Device().isPhone {
                Section {
                    Link("Open Health Checklist", destination: URL(string: "x-apple-health://")!)
                } footer: {
                    Text("Health Checklist can help set up your iPhone and Apple Watch to keep an eye on things for you.")
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
