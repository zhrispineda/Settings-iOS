//
//  RestrictionsLocationServicesView.swift
//  Preferences
//
//  Settings > Screen Time > Content & Privacy Restrictions > Location Services
//

import SwiftUI

struct RestrictionsLocationServicesView: View {
    // Variables
    @State private var selected = "AllowChangesSpecifierName"
    @State private var locationServicesEnabled = true
    @State private var showingDisableLocationServicesAlert = false
    @State private var showingDisableLocationServicesDialog = false
    let options = ["AllowChangesSpecifierName", "DontAllowChangesSpecifierName"]
    let table = "Restrictions"
    let locTable = "Location Services"
    let privTable = "LocationServicesPrivacy"
    
    var body: some View {
        CustomList(title: "LocationServicesSpecifierName".localize(table: table)) {
            Section {
                Picker("AllowChangesLabel".localize(table: table), selection: $selected) {
                    ForEach(options, id: \.self) {
                        Text($0.localize(table: table))
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } footer: {
                Text("LOCATION_EXPLANATION", tableName: table)
            }
            
            Section {
                Toggle("LocationServicesSpecifierName".localize(table: table), isOn: $locationServicesEnabled.animation())
                    .alert("LocationServicesSpecifierName".localize(table: table), isPresented: $showingDisableLocationServicesAlert) {
                        Button("CONFIRM_LOCATION_TURN_OFF".localize(table: locTable), role: .none) {}
                        Button("CANCEL".localize(table: locTable), role: .cancel) { locationServicesEnabled.toggle() }
                    } message: {
                        Text("CONFIRM_LOCATION_TITLE", tableName: locTable)
                    }
                    .confirmationDialog("CONFIRM_LOCATION_TITLE".localize(table: locTable), isPresented: $showingDisableLocationServicesDialog,
                                        titleVisibility: .visible,
                                        actions: {
                        Button("CONFIRM_LOCATION_TURN_OFF".localize(table: locTable), role: .destructive) {}
                        Button("CANCEL".localize(table: locTable), role: .cancel) { locationServicesEnabled.toggle() }
                    })
                    .onChange(of: locationServicesEnabled) {
                        if !locationServicesEnabled {
                            UIDevice.iPhone ? showingDisableLocationServicesDialog.toggle() : showingDisableLocationServicesAlert.toggle()
                        }
                    }
                NavigationLink("PRIVACY_ALERTS".localize(table: locTable), destination: LocationAlertsView())
            } footer: {
                Text("\(UIDevice.iPad ? "DISABLED_WARNING_WIFI".localize(table: locTable) + "\n\n" : "")\(UIDevice.iPad ? "DESCRIPTION_NOGPS_WIFI".localize(table: locTable) : "DESCRIPTION_GPS_WIFI".localize(table: locTable)) [\("ABOUT_LOCATION_AND_PRIVACY".localize(table: locTable))](#)")
            }
            
            if locationServicesEnabled {
                Section {
                    SLink("AppClipsSpecifierName".localize(table: table), color: .white, iconColor: .blue, icon: "appclip") {
                        AppClipsView()
                    }
                    SettingsLink("AppGenius.bundle", status: "NEVER_AUTHORIZATION".localize(table: privTable), destination: LocationPermissionsDetailView(title: "AppGenius.bundle", selected: "NEVER_AUTHORIZATION".localize(table: privTable)))
                    SettingsLink("AssistantServices.framework", status: "NOT_DETERMINED_AUTHORIZATION_SHORT".localize(table: privTable), destination: LocationPermissionsDetailView(title: "AssistantServices.framework"))
                    SettingsLink("BulletinBoard.framework", status: "NOT_DETERMINED_AUTHORIZATION_SHORT".localize(table: privTable), destination: LocationPermissionsDetailView(title: "BulletinBoard.framework"))
                    SettingsLink("CompassCalibration.bundle", status: "NOT_DETERMINED_AUTHORIZATION_SHORT".localize(table: privTable), destination: LocationPermissionsDetailView(title: "CompassCalibration.bundle"))
                    SettingsLink("Emergency SOS.bundle", status: "NOT_DETERMINED_AUTHORIZATION_SHORT".localize(table: privTable), destination: LocationPermissionsDetailView(title: "Emergency SOS.bundle"))
                    SettingsLink("MobileWiFi.framework", status: "NOT_DETERMINED_AUTHORIZATION_SHORT".localize(table: privTable), destination: LocationPermissionsDetailView(title: "MobileWiFi.framework"))
                    SettingsLink("MotionCalibration.bundle", status: "NOT_DETERMINED_AUTHORIZATION_SHORT".localize(table: privTable), destination: LocationPermissionsDetailView(title: "MotionCalibration.bundle"))
                    SettingsLink("PassbookMerchantLookup.bundle", status: "NOT_DETERMINED_AUTHORIZATION_SHORT".localize(table: privTable), destination: LocationPermissionsDetailView(title: "PassbookMerchantLookup.bundle"))
                    SLink("LOCATION_SHARING".localize(table: locTable), icon: "Placeholder", status: "NOT_DETERMINED_AUTHORIZATION_SHORT".localize(table: privTable)) {
                        LocationPermissionsDetailView(title: "LOCATION_SHARING".localize(table: locTable))
                    }
                    SLink("SiriDictationSpecifierName".localize(table: table), icon: "appleSiri", status: "NOT_DETERMINED_AUTHORIZATION_SHORT".localize(table: privTable)) {
                        LocationPermissionsDetailView(title: "SiriDictationSpecifierName".localize(table: table))
                    }
                    SettingsLink("SystemCustomization.bundle", status: "NOT_DETERMINED_AUTHORIZATION_SHORT".localize(table: privTable), location: true, destination: LocationPermissionsDetailView(title: "SystemCustomization.bundle"))
                    SettingsLink("Traffic.bundle", status: "NOT_DETERMINED_AUTHORIZATION_SHORT".localize(table: privTable), destination: LocationPermissionsDetailView(title: "Traffic.bundle"))
                    SLink("SYSTEM_SERVICES".localize(table: locTable), color: .gray, icon: "gear", status: "location.fill") {
                        SystemServicesView()
                    }
                } footer: {
                    VStack(alignment: .leading) {
                        Text("GENERAL_EXPLANATION_ITEM".localize(table: locTable) + "\n")
                        HStack(spacing: 15) {
                            Image(systemName: "location.fill")
                                .foregroundStyle(.purple)
                                .font(.headline)
                            Text("ACTIVE_EXPLANATION_ITEM", tableName: locTable)
                        }
                        .padding(.trailing)
                        .padding(.bottom, 5)
                        
                        HStack(spacing: 15) {
                            Image(systemName: "location.fill")
                                .foregroundStyle(.gray)
                                .font(.headline)
                            Text("RECENT_EXPLANATION_ITEM", tableName: locTable)
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
