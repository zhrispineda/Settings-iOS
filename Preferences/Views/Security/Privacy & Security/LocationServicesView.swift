//
//  LocationServicesView.swift
//  Preferences
//
//  Settings > Privacy & Security > Location Services
//

import SwiftUI

struct LocationServicesView: View {
    @State private var locationServicesEnabled = true
    @State private var showingSheet = false
    let table = "Location Services"
    let privTable = "LocationServicesPrivacy"
    
    var body: some View {
        CustomList(title: "LOCATION_SERVICES".localize(table: table)) {
            Section {
                Toggle("LOCATION_SERVICES".localize(table: table), isOn: $locationServicesEnabled)
                NavigationLink("PRIVACY_ALERTS".localize(table: table), destination: LocationAlertsView())
            } footer: {
                Text("\(UIDevice.iPhone ? "DESCRIPTION_GPS_WIFI".localize(table: table) : "DESCRIPTION_NOGPS_WIFI".localize(table: table)) [\("ABOUT_LOCATION_AND_PRIVACY".localize(table: table))](pref://)")
            }
            
            if locationServicesEnabled {
                Section {
                    SLink("APP_CLIPS".localize(table: "Dim-Sum"), color: .white, iconColor: .blue, icon: "appclip", status: "0") { AppClipsView()
                    }
                    SLink("LOCATION_SHARING".localize(table: table), icon: "Placeholder", status: "NOT_DETERMINED_AUTHORIZATION_SHORT".localize(table: privTable)) {
                        LocationPermissionsDetailView(title: "LOCATION_SHARING")
                    }
                    SLink("Siri", icon: "appleSiri", status: "NOT_DETERMINED_AUTHORIZATION_SHORT".localize(table: privTable)) {
                        LocationPermissionsDetailView(title: "Siri")
                    }
                    SLink("SYSTEM_SERVICES".localize(table: table), color: .gray, icon: "gear", status: "location.fill") {
                        SystemServicesView()
                    }
                } footer: {
                    VStack(alignment: .leading) {
                        Text("\("GENERAL_EXPLANATION_ITEM".localize(table: table))\n")
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
        .onOpenURL { url in
            if url.scheme == "locationSettingsOBK" {
                showingSheet = true
            }
        }
        .sheet(isPresented: $showingSheet) {
            OnBoardingKitView(bundleID: "com.apple.onboarding.locationservices")
                .ignoresSafeArea()
        }
    }
}

#Preview {
    NavigationStack {
        LocationServicesView()
    }
}
