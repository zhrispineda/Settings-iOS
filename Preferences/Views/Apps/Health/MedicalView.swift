//
//  MedicalView.swift
//  Preferences
//
//  Settings > Apps > Health > Medical ID
//

import SwiftUI

struct MedicalView: View {
    let wellness = "/System/Library/PrivateFrameworks/HealthToolbox.framework"
    let table = "WellnessDashboard-Localizable"
    
    var body: some View {
        CustomList {
            VStack {
                Text("MEDICAL_ID_DESCRIPTION".localized(path: wellness, table: table))
                    .multilineTextAlignment(.leading)
                Button {} label: {
                    Text("CREATE_MEDICAL_ID".localized(path: wellness, table: table))
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Image(systemName: "staroflife.fill")
                    Text("MEDICAL_ID".localized(path: wellness, table: table))
                }
                .foregroundStyle(Color(UIColor.red))
            }
        }
    }
}

#Preview {
    NavigationStack {
        MedicalView()
    }
}
