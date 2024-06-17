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
            Section {
                SettingsLink(icon: "applesiri", id: "Siri & Search") {
                    SiriSearchDetailView(appName: "Health")
                }
            } header: {
                Text("Allow Health to Access")
            }
            
            Section {
                NavigationLink("Health Details", destination: HealthDetailsView())
                NavigationLink("Medical ID", destination: MedicalView())
            } header: {
                Text("Medical Details")
            }
            
            Section {
                NavigationLink("Data Access & Devices", destination: DataAccessDevicesView())
            } header: {
                Text("Data")
            }
        }
    }
}

#Preview {
    NavigationStack {
        HealthView()
    }
}
