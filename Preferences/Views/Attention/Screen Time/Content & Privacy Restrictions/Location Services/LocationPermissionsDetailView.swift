//
//  LocationPermissionsDetailView.swift
//  Preferences
//
//  Settings > Screen Time > Content & Privacy Restrictions > Location Services > [Selection]
//

import SwiftUI

struct LocationPermissionsDetailView: View {
    var title = ""
    @State var selected = "NOT_DETERMINED_AUTHORIZATION"
    let options = ["NEVER_AUTHORIZATION", "NOT_DETERMINED_AUTHORIZATION", "ALWAYS_AUTHORIZATION"]
    @State private var preciseLocationEnabled = true
    let path = "/System/Library/PrivateFrameworks/Settings/PrivacySettingsUI.framework"
    let table = "LocationServicesPrivacy"
    
    var body: some View {
        CustomList(title: title, topPadding: true) {
            Section {
                Picker("", selection: $selected) {
                    ForEach(options, id: \.self) {
                        Text($0.localized(path: path, table: table))
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } header: {
                Text("ALLOW_LOCATION_SERVICES_HEADER".localized(path: path, table: table))
            } footer: {
                if title == "Siri & Dictation" {
                    Text("PURPOSE_STRING".localized(path: path, table: table, "Siri uses your location for things like answering questions and offering suggestions about what‘s nearby."))
                }
            }
            
            if selected != "NEVER_AUTHORIZATION" {
                Section {
                    Toggle("PRECISE_LOCATION".localized(path: path, table: table), isOn: $preciseLocationEnabled)
                } footer: {
                    Text("PRECISE_LOCATION_FOOTER".localized(path: path, table: table))
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        LocationPermissionsDetailView()
    }
}
