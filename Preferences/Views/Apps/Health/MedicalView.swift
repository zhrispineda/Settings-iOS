//
//  MedicalView.swift
//  Preferences
//
//  Settings > Apps > Health > Medical ID
//

import SwiftUI

struct MedicalView: View {
    // Variables
    let table = "WellnessDashboard-Localizable"
    
    var body: some View {
        CustomList(title: "MEDICAL_ID".localize(table: table)) {
            VStack {
                Text("MEDICAL_ID_DESCRIPTION", tableName: table)
                    .multilineTextAlignment(.leading)
                Button {} label: {
                    Text("CREATE_MEDICAL_ID", tableName: table)
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            }
        }
    }
}

#Preview {
    NavigationStack {
        MedicalView()
    }
}
