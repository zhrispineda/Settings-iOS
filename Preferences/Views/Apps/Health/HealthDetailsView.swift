//
//  HealthDetailsView.swift
//  Preferences
//
//  Settings > Apps > Health > Health Details
//

import SwiftUI

struct HealthDetailsView: View {
    // Variables
    let table = "WellnessDashboard-Localizable"
    let dataTable = "Localizable-DataTypes"
    
    var body: some View {
        CustomList(title: "HEALTH_PROFILE_TITLE".localize(table: table)) {
            Section {
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 72))
                    .foregroundStyle(.white, .gray.gradient)
                    .listRowBackground(Color.clear)
                    .frame(maxWidth: .infinity)
            }
            
            Section {
                LabeledContent("FIRST_NAME".localize(table: table), value: "FIRST_NAME_NOT_SET".localize(table: table))
                LabeledContent("LAST_NAME".localize(table: table), value: "LAST_NAME_NOT_SET".localize(table: table))
                CustomNavigationLink(title: "BIRTHDATE".localize(table: table), status: "BIRTHDATE_NOT_SET".localize(table: table), destination: HealthDetailsDataView(title: "BIRTHDATE".localize(table: table)))
                CustomNavigationLink(title: "BIOLOGICAL_SEX".localize(table: dataTable), status: "BIOLOGICAL_SEX_NOT_SET".localize(table: table), destination: HealthDetailsDataView(title: "BIOLOGICAL_SEX".localize(table: dataTable)))
                CustomNavigationLink(title: "BLOOD_TYPE".localize(table: dataTable), status: "BLOOD_TYPE_NOT_SET".localize(table: table), destination: HealthDetailsDataView(title: "BLOOD_TYPE_TITLE_EMBEDDED".localize(table: dataTable)))
                CustomNavigationLink(title: "FITZPATRICK_SKIN_TYPE".localize(table: dataTable), status: "FITZPATRICK_SKIN_TYPE_NOT_SET".localize(table: table), destination: HealthDetailsDataView(title: "FITZPATRICK_SKIN_TYPE"))
            }
            
            Section {
                CustomNavigationLink(title: "WHEELCHAIR_USE_TITLE_EMBEDDED".localize(table: dataTable), status: "WHEELCHAIR_USE_NOT_SET".localize(table: table), destination: HealthDetailsDataView(title: "WHEELCHAIR_USE_TITLE_EMBEDDED".localize(table: dataTable)))
            } footer: {
                if UIDevice.iPhone {
                    Text("WHEELCHAIR_USE_COREMOTION_TEXT_IPHONE", tableName: table)
                } else if UIDevice.iPad {
                    Text("WHEELCHAIR_USE_COREMOTION_TEXT_IPAD", tableName: table)
                }
            }
            
            Section {
                CustomNavigationLink(title: "CARDIO_FITNESS_RELATED_MEDICATIONS".localize(table: table), status: "0", destination: HealthDetailsDataView(title: "CARDIO_FITNESS_RELATED_MEDICATIONS".localize(table: table)))
            } footer: {
                Text("CARDIO_FITNESS_RELATED_MEDICATIONS_FOOTER_TEXT", tableName: table)
            }
        }
        .toolbar {
            EditButton()
        }
    }
}

#Preview {
    NavigationStack {
        HealthDetailsView()
    }
}
