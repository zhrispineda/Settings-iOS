//
//  RestrictionsLocationServicesView.swift
//  Preferences
//
//  Settings > Screen Time > Content & Privacy Restrictions > Location Services
//

import SwiftUI

struct RestrictionsLocationServicesView: View {
    @State private var selected = "AllowChangesSpecifierName"
    @State private var locationServicesEnabled = true
    @State private var showingDisableLocationServicesAlert = false
    @State private var showingDisableLocationServicesDialog = false
    let path = "/System/Library/PrivateFrameworks/Settings/PrivacySettingsUI.framework"
    let options = ["AllowChangesSpecifierName", "DontAllowChangesSpecifierName"]
    let restrict = "/System/Library/PrivateFrameworks/ScreenTimeSettingsUI.framework"
    let table = "Restrictions"
    let locTable = "Location Services"
    let privTable = "LocationServicesPrivacy"
    
    var body: some View {
        CustomList(title: "LocationServicesSpecifierName".localized(path: restrict, table: table)) {
            Section {
                Picker("AllowChangesLabel".localized(path: path, table: table), selection: $selected) {
                    ForEach(options, id: \.self) {
                        Text($0.localized(path: restrict, table: table))
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } footer: {
                Text("LOCATION_EXPLANATION".localized(path: path, table: table))
            }
            
            Section {
                Toggle("LocationServicesSpecifierName".localized(path: restrict, table: table), isOn: $locationServicesEnabled.animation())
                    .alert("LocationServicesSpecifierName".localized(path: restrict, table: table), isPresented: $showingDisableLocationServicesAlert) {
                        Button("CONFIRM_LOCATION_TURN_OFF".localized(path: path, table: locTable), role: .none) {}
                        Button("CANCEL".localized(path: path, table: locTable), role: .cancel) { locationServicesEnabled.toggle() }
                    } message: {
                        Text("CONFIRM_LOCATION_TITLE".localized(path: path, table: locTable))
                    }
                    .confirmationDialog("CONFIRM_LOCATION_TITLE".localized(path: path, table: locTable), isPresented: $showingDisableLocationServicesDialog,
                                        titleVisibility: .visible,
                                        actions: {
                        Button("CONFIRM_LOCATION_TURN_OFF".localized(path: path, table: locTable), role: .destructive) {}
                        Button("CANCEL".localized(path: path, table: locTable), role: .cancel) { locationServicesEnabled.toggle() }
                    })
                    .onChange(of: locationServicesEnabled) {
                        if !locationServicesEnabled {
                            UIDevice.iPhone ? showingDisableLocationServicesDialog.toggle() : showingDisableLocationServicesAlert.toggle()
                        }
                    }
                NavigationLink("PRIVACY_ALERTS".localized(path: path, table: locTable), destination: LocationAlertsView())
            } footer: {
                Text("\(UIDevice.iPad ? "DISABLED_WARNING_WIFI".localize(table: locTable) + "\n\n" : "")\(UIDevice.iPad ? "DESCRIPTION_NOGPS_WIFI".localized(path: path, table: locTable) : "DESCRIPTION_GPS_WIFI".localized(path: path, table: locTable)) [\("ABOUT_LOCATION_AND_PRIVACY".localized(path: path, table: locTable))](#)")
            }
            
            if locationServicesEnabled {
                Section {
                    SLink("AppClipsSpecifierName".localized(path: restrict, table: table), icon: "com.apple.graphic-icon.app-clips") {
                        AppClipsView()
                    }
                    SettingsLink("AppGenius.bundle", status: "NEVER_AUTHORIZATION".localized(path: path, table: privTable), destination: LocationPermissionsDetailView(title: "AppGenius.bundle", selected: "NEVER_AUTHORIZATION".localize(table: privTable)))
                    SettingsLink("AssistantServices.framework", status: "NOT_DETERMINED_AUTHORIZATION_SHORT".localized(path: path, table: privTable), destination: LocationPermissionsDetailView(title: "AssistantServices.framework"))
                    SettingsLink("BulletinBoard.framework", status: "NOT_DETERMINED_AUTHORIZATION_SHORT".localized(path: path, table: privTable), destination: LocationPermissionsDetailView(title: "BulletinBoard.framework"))
                    SettingsLink("CompassCalibration.bundle", status: "NOT_DETERMINED_AUTHORIZATION_SHORT".localized(path: path, table: privTable), destination: LocationPermissionsDetailView(title: "CompassCalibration.bundle"))
                    SettingsLink("Emergency SOS.bundle", status: "NOT_DETERMINED_AUTHORIZATION_SHORT".localized(path: path, table: privTable), destination: LocationPermissionsDetailView(title: "Emergency SOS.bundle"))
                    SettingsLink("MobileWiFi.framework", status: "NOT_DETERMINED_AUTHORIZATION_SHORT".localized(path: path, table: privTable), destination: LocationPermissionsDetailView(title: "MobileWiFi.framework"))
                    SettingsLink("MotionCalibration.bundle", status: "NOT_DETERMINED_AUTHORIZATION_SHORT".localized(path: path, table: privTable), destination: LocationPermissionsDetailView(title: "MotionCalibration.bundle"))
                    SettingsLink("PassbookMerchantLookup.bundle", status: "NOT_DETERMINED_AUTHORIZATION_SHORT".localized(path: path, table: privTable), destination: LocationPermissionsDetailView(title: "PassbookMerchantLookup.bundle"))
                    SLink("LOCATION_SHARING".localized(path: path, table: locTable), icon: "com.", status: "NOT_DETERMINED_AUTHORIZATION_SHORT".localized(path: path, table: privTable)) {
                        LocationPermissionsDetailView(title: "LOCATION_SHARING".localized(path: path, table: locTable))
                    }
                    SLink("SiriDictationSpecifierName".localized(path: restrict, table: table), icon: "com.apple.application-icon.siri", status: "NOT_DETERMINED_AUTHORIZATION_SHORT".localized(path: path, table: privTable)) {
                        LocationPermissionsDetailView(title: "SiriDictationSpecifierName".localized(path: restrict, table: table))
                    }
                    SettingsLink("SystemCustomization.bundle", status: "NOT_DETERMINED_AUTHORIZATION_SHORT".localized(path: path, table: privTable), location: true, destination: LocationPermissionsDetailView(title: "SystemCustomization.bundle"))
                    SettingsLink("Traffic.bundle", status: "NOT_DETERMINED_AUTHORIZATION_SHORT".localized(path: path, table: privTable), destination: LocationPermissionsDetailView(title: "Traffic.bundle"))
                    SLink("SYSTEM_SERVICES".localized(path: path, table: locTable), icon: "com.apple.graphic-icon.gear", status: "location.fill") {
                        SystemServicesView()
                    }
                } footer: {
                    VStack(alignment: .leading) {
                        Text("GENERAL_EXPLANATION_ITEM".localized(path: path, table: locTable) + "\n")
                        HStack(spacing: 15) {
                            Image(systemName: "location.fill")
                                .foregroundStyle(.purple)
                                .font(.headline)
                            Text("ACTIVE_EXPLANATION_ITEM".localized(path: path, table: locTable))
                        }
                        .padding(.trailing)
                        .padding(.bottom, 5)
                        
                        HStack(spacing: 15) {
                            Image(systemName: "location.fill")
                                .foregroundStyle(.gray)
                                .font(.headline)
                            Text("RECENT_EXPLANATION_ITEM".localized(path: path, table: locTable))
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
        RestrictionsLocationServicesView()
    }
}
