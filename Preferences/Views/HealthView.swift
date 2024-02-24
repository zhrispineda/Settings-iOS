//
//  HealthView.swift
//  Preferences
//
//  Settings > Health
//

import SwiftUI

struct HealthView: View {
    var body: some View {
        CustomList(title: "Health") {
            Section(content: {
                SettingsLink(icon: "applesiri", id: "Siri & Search", content: {
                    SiriSearchDetailView(appName: "Health")
                })
            }, header: {
                Text("Allow Health to Access")
            })
            
            Section(content: {
                NavigationLink("Health Details", destination: HealthDetailsView())
                NavigationLink("Medical ID", destination: MedicalView())
            }, header: {
                Text("Medical Details")
            })
            
            Section(content: {
                NavigationLink("Data Access & Devices", destination: DataAccessDevicesView())
            }, header: {
                Text("Data")
            })
        }
    }
}

#Preview {
    NavigationStack {
        HealthView()
    }
}
