//
//  HealthDetailsView.swift
//  Preferences
//
//  Settings > Apps > Health > Health Details
//

import SwiftUI

struct HealthDetailsView: View {
    let path = "/System/Library/Frameworks/HealthKit.framework"
    let health = "/System/Library/PrivateFrameworks/HealthUI.framework"
    let wellness = "/System/Library/PrivateFrameworks/HealthToolbox.framework"
    let table = "WellnessDashboard-Localizable"
    let dataTable = "Localizable-DataTypes"
    
    var body: some View {
        CustomList(title: "HEALTH_PROFILE_TITLE".localized(path: wellness, table: table)) {
            Section {
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 72))
                    .foregroundStyle(.white, .gray.gradient)
                    .listRowBackground(Color.clear)
                    .frame(maxWidth: .infinity)
            }
            
            Section {
                LabeledContent("FIRST_NAME".localized(path: wellness, table: table), value: "FIRST_NAME_NOT_SET".localized(path: wellness, table: table))
                LabeledContent("LAST_NAME".localized(path: wellness, table: table), value: "LAST_NAME_NOT_SET".localized(path: wellness, table: table))
                SettingsLink("BIRTHDATE".localized(path: wellness, table: table), status: "BIRTHDATE_NOT_SET".localized(path: wellness, table: table), destination: HealthDetailsDataView(title: "BIRTHDATE".localized(path: wellness, table: table)))
                SettingsLink("BIOLOGICAL_SEX".localized(path: path, table: dataTable), status: "BIOLOGICAL_SEX_NOT_SET".localized(path: wellness, table: table), destination: HealthDetailsDataView(title: "BIOLOGICAL_SEX".localized(path: wellness, table: table)))
                SettingsLink("BLOOD_TYPE".localized(path: path, table: dataTable), status: "BLOOD_TYPE_NOT_SET".localized(path: wellness, table: table), destination: HealthDetailsDataView(title: "BLOOD_TYPE_TITLE_EMBEDDED".localized(path: path, table: dataTable)))
                SettingsLink("FITZPATRICK_SKIN_TYPE".localized(path: path, table: dataTable), status: "FITZPATRICK_SKIN_TYPE_NOT_SET".localized(path: wellness, table: table), destination: HealthDetailsDataView(title: "FITZPATRICK_SKIN_TYPE"))
            }
            
            Section {
                SettingsLink("WHEELCHAIR_USE_TITLE_EMBEDDED".localized(path: path, table: dataTable), status: "WHEELCHAIR_USE_NOT_SET".localized(path: wellness, table: table), destination: HealthDetailsDataView(title: "WHEELCHAIR_USE_TITLE_EMBEDDED".localized(path: wellness, table: table)))
            } footer: {
                if UIDevice.iPhone {
                    Text("WHEELCHAIR_USE_COREMOTION_TEXT_IPHONE".localized(path: wellness, table: table))
                } else if UIDevice.iPad {
                    Text("WHEELCHAIR_USE_COREMOTION_TEXT_IPAD".localized(path: wellness, table: table))
                }
            }
            
            Section {
                Button("HEALTH_DETAILS_ADD_PREGNANCY".localized(path: health, table: "HealthUI-Localizable-Pregnancy")) {}
            }
            
            Section {
                SettingsLink("CARDIO_FITNESS_RELATED_MEDICATIONS".localized(path: wellness, table: table), status: "0", destination: HealthDetailsDataView(title: "CARDIO_FITNESS_RELATED_MEDICATIONS".localized(path: wellness, table: table)))
            } footer: {
                Text("CARDIO_FITNESS_RELATED_MEDICATIONS_FOOTER_TEXT".localized(path: wellness, table: table))
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
