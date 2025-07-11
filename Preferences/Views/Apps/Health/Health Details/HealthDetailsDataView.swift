//
//  HealthDetailsDataView.swift
//  Preferences
//
//  Settings > Apps > Health > Health Details > [Health Data]
//

import SwiftUI

struct HealthDetailsDataView: View {
    var title = ""
    let health = "/System/Library/Frameworks/HealthKit.framework"
    let wellness = "/System/Library/PrivateFrameworks/HealthToolbox.framework"
    let table = "WellnessDashboard-Localizable"
    let dataTable = "Localizable-DataTypes"
    
    var body: some View {
        CustomList(title: title.localized(path: health, table: dataTable), topPadding: true) {
            Section {
                Text("APPS_NONE".localized(path: wellness, table: table))
                    .foregroundStyle(.secondary)
            } header: {
                Text("APPS_READ_ACCESS_HEADER".localized(path: wellness, table: table))
            } footer: {
                Text("Share \(title.contains("Fitzpatrick") ? "Fitzpatrick skin type" : title.contains("That") ? "this" : "Fitzpatrick skin type") data with apps and services listed above. As apps and services request access to your Health data, they will be added to the list.")
            }
            
            Section {
                Text("APPS_NONE".localized(path: wellness, table: table))
                    .foregroundStyle(.secondary)
            } header: {
                Text("RESEARCH_STUDIES_READ_ACCESS_HEADER".localized(path: wellness, table: table))
            } footer: {
                Text("Share \(title.contains("FITZPATRICK_SKIN_TYPE") ? "Fitzpatrick skin type" : title.contains("That") ? "this" : title.lowercased()) data with the studies in Research listed above. As you authorize studies in the Research app they will be added to the list. You can review and manage all of the studies you are enrolled in by going to the Research app.")
            }
            
            if title == "FITZPATRICK_SKIN_TYPE" {
                VStack(alignment: .leading, spacing: 5) {
                    Text("**Description**")
                        .foregroundStyle(.secondary)
                        .font(.caption)
                    Text("FITZPATRICK_SKIN_TYPE_SUMMARY".localized(path: health, table: dataTable))
                        .foregroundStyle(.secondary)
                        .font(.caption)
                    Text("[Mayo Clinic](https://www.mayoclinic.org)")
                        .font(.caption)
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
            }
        }
        .listStyle(.grouped)
    }
}

#Preview {
    NavigationStack {
        HealthDetailsDataView(title: "FITZPATRICK_SKIN_TYPE")
    }
}

