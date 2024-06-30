//
//  HealthDetailsDataView.swift
//  Preferences
//
//  Settings > Apps > Health > Health Details > [Health Data]
//

import SwiftUI

struct HealthDetailsDataView: View {
    // Variables
    var title = String()
    
    var body: some View {
        CustomList(title: title) {
            Section {
                Text("None")
                    .foregroundStyle(.secondary)
            } header: {
                Text("Apps and Services Allowed to Read Data")
            } footer: {
                Text("Share \(title.contains("Fitzpatrick") ? "Fitzpatrick skin type" : title.contains("That") ? "this" : title.lowercased()) data with apps and services listed above. As apps and services request access to your Health data, they will be added to the list.")
            }
            
            Section {
                Text("None")
                    .foregroundStyle(.secondary)
            } header: {
                Text("Research Studies Allowed to Read Data")
            } footer: {
                Text("Share \(title.contains("Fitzpatrick") ? "Fitzpatrick skin type" : title.contains("That") ? "this" : title.lowercased()) data with the studies in Research listed above. As you authorize studies in the Research app they will be added to the list. You can review and manage all of the studies you are enrolled in by going to the Research app.")
            }
            
            if title == "Fitzpatrick Skin Type" {
                VStack(alignment: .leading, spacing: 5) {
                    Text("**Description**")
                        .foregroundStyle(.secondary)
                        .font(.caption)
                    Text("The Fitzpatrick scale is a rating of your skin type, based on your skin‘s tendency to burn and your skin‘s ability to tan.\nThe scale ranges from skin type I (always burns, never tans) to skin type VI (never burns, no change in appearance when tan).")
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
        .padding(.top, 19)
    }
}

#Preview {
    NavigationStack {
        HealthDetailsDataView(title: "Fitzpatrick Skin Type")
    }
}
