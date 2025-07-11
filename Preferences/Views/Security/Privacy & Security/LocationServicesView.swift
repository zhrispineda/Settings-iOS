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
    let path = "/System/Library/PrivateFrameworks/Settings/PrivacySettingsUI.framework"
    let table = "Location Services"
    let privTable = "LocationServicesPrivacy"
    
    var body: some View {
        CustomList(title: "LOCATION_SERVICES".localized(path: path, table: table)) {
            Section {
                Toggle("LOCATION_SERVICES".localized(path: path, table: table), isOn: $locationServicesEnabled)
                NavigationLink("PRIVACY_ALERTS".localized(path: path, table: table), destination: LocationAlertsView())
            } footer: {
                Text("\(UIDevice.iPhone ? "DESCRIPTION_GPS_WIFI".localized(path: path, table: table) : "DESCRIPTION_NOGPS_WIFI".localize(table: table)) [\("ABOUT_LOCATION_AND_PRIVACY".localized(path: path, table: table))](pref://)")
            }
            
            if locationServicesEnabled {
                Section {
                    SLink("APP_CLIPS".localized(path: "/System/Library/PrivateFrameworks/Settings/PrivacySettingsUI.framework", table: "Dim-Sum"), icon: "com.apple.graphic-icon.app-clips", status: "0") {
                        AppClipsView()
                    }
                    SLink("LOCATION_SHARING".localized(path: path, table: table), icon: "com.", status: "NOT_DETERMINED_AUTHORIZATION_SHORT".localized(path: path, table: privTable)) {
                        LocationPermissionsDetailView(title: "LOCATION_SHARING")
                    }
                    SLink("Siri", icon: "com.apple.application-icon.siri", status: "NOT_DETERMINED_AUTHORIZATION_SHORT".localized(path: path, table: privTable)) {
                        LocationPermissionsDetailView(title: "Siri")
                    }
                    SLink("SYSTEM_SERVICES".localized(path: path, table: table), icon: "com.apple.graphic-icon.gear", status: "location.fill") {
                        SystemServicesView()
                    }
                } footer: {
                    VStack(alignment: .leading) {
                        Text("\("GENERAL_EXPLANATION_ITEM".localized(path: path, table: table))\n")
                        HStack(spacing: 15) {
                            Image(systemName: "location.fill")
                                .foregroundStyle(.purple)
                                .font(.headline)
                            Text("ACTIVE_EXPLANATION_ITEM".localized(path: path, table: table))
                        }
                        .padding(.trailing)
                        .padding(.bottom, 5)
                        
                        HStack(spacing: 15) {
                            Image(systemName: "location.fill")
                                .foregroundStyle(.gray)
                                .font(.headline)
                            Text("RECENT_EXPLANATION_ITEM".localized(path: path, table: table))
                        }
                        .padding(.trailing)
                    }
                }
            }
        }
        .onOpenURL { url in
            if url.absoluteString == "pref://" {
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
