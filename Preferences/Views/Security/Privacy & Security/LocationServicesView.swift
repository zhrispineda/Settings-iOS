//
//  LocationServicesView.swift
//  Preferences
//
//  Settings > Privacy & Security > Location Services
//

import SwiftUI

struct LocationServicesView: View {
    // Variables
    @State private var locationServicesEnabled = true
    let table = "Location Services"
    let privTable = "LocationServicesPrivacy"
    
    var body: some View {
        CustomList(title: "LOCATION_SERVICES".localize(table: table)) {
            Section {
                Toggle("LOCATION_SERVICES".localize(table: table), isOn: $locationServicesEnabled)
                NavigationLink("PRIVACY_ALERTS", destination: LocationAlertsView())
            } footer: {
                Text(UIDevice.iPhone ? "DESCRIPTION_GPS_WIFI" : "DESCRIPTION_NOGPS_WIFI", tableName: table) + Text(" [\("ABOUT_LOCATION_AND_PRIVACY".localize(table: table))](#)")
            }
            
//            Section {
//                NavigationLink("Share My Location") {}
//            }
            
            if locationServicesEnabled {
                Section {
                    SettingsLink(color: .white, iconColor: .blue, icon: "appclip", id: "APP_CLIPS".localize(table: "Dim-Sum")) { AppClipsView()
                    }
                    CustomNavigationLink(title: "BulletinBoard.framework", status: "NOT_DETERMINED_AUTHORIZATION_SHORT".localize(table: privTable), destination: LocationPermissionsDetailView(title: "BulletinBoard.framework"))
                    CustomNavigationLink(title: "MobileWiFi.framework", status: "NOT_DETERMINED_AUTHORIZATION_SHORT".localize(table: privTable), destination: LocationPermissionsDetailView(title: "MobileWiFi.framework"))
                    SettingsLink(icon: "Placeholder", id: "LOCATION_SHARING".localize(table: table), status: "NOT_DETERMINED_AUTHORIZATION_SHORT".localize(table: privTable)) {
                        LocationPermissionsDetailView(title: "LOCATION_SHARING")
                    }
                    SettingsLink(icon: "appleSiri", id: "Siri", status: "NOT_DETERMINED_AUTHORIZATION_SHORT".localize(table: privTable)) {
                        LocationPermissionsDetailView(title: "Siri")
                    }
                    CustomNavigationLink(title: "SystemCustomization.bundle", status: "NOT_DETERMINED_AUTHORIZATION_SHORT".localize(table: privTable), location: true, destination: LocationPermissionsDetailView(title: "SystemCustomization.bundle"))
                    CustomNavigationLink(title: "Traffic.bundle", status: "NOT_DETERMINED_AUTHORIZATION_SHORT".localize(table: privTable), destination: LocationPermissionsDetailView(title: "Traffic.bundle"))
                    SettingsLink(color: .gray, icon: "gear", id: "SYSTEM_SERVICES".localize(table: table), status: "location.fill") {
                        SystemServicesView()
                    }
                } footer: {
                    VStack(alignment: .leading) {
                        Text("GENERAL_EXPLANATION_ITEM", tableName: table) + Text("\n")
                        HStack(spacing: 15) {
                            Image(systemName: "location.fill")
                                .foregroundStyle(.purple)
                                .font(.headline)
                            Text("ACTIVE_EXPLANATION_ITEM", tableName: table)
                        }
                        .padding(.trailing)
                        .padding(.bottom, 5)
                        
                        HStack(spacing: 15) {
                            Image(systemName: "location.fill")
                                .foregroundStyle(.gray)
                                .font(.headline)
                            Text("RECENT_EXPLANATION_ITEM", tableName: table)
                        }
                        .padding(.trailing)
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        LocationServicesView()
    }
}
