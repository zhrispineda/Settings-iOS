//
//  SystemServicesView.swift
//  Preferences
//
//  Settings > Screen Time > Content & Privacy Restrictions > Location Services > System Services
//

import SwiftUI

struct SystemServicesView: View {
    @State private var alertsShortcutsAutomationsEnabled = true
    @State private var carbonAnalysisEnabled = true
    @State private var cellNetworkSearchEnabled = true
    @State private var deviceManagementEnabled = true
    @State private var findMyEnabled = true
    @State private var homeKitEnabled = true
    @State private var networkingWirelessEnabled = true
    @State private var homeEnergyEnabled = true
    @State private var showingNetworkingAlert = false
    @State private var settingTimeZoneEnabled = true
    @State private var suggestionsSearchEnabled = true
    @State private var systemCustomizationEnabled = false
    @State private var deviceAnalyticsEnabled = true
    @State private var routingTrafficEnabled = false
    @State private var improveMapsEnabled = false
    @State private var controlCenterIconEnabled = false
    @State private var showingSheet = false
    let path = "/System/Library/PrivateFrameworks/Settings/PrivacySettingsUI.framework"
    let table = "Location Services"
    let privTable = "LocationServicesPrivacy"
    
    var body: some View {
        CustomList(title: "SYSTEM_SERVICES".localized(path: path, table: table)) {
            Section {
                Toggle("LOCATION_BASED_ALERTS".localized(path: path, table: privTable), isOn: $alertsShortcutsAutomationsEnabled)
                if UIDevice.IsSimulator {
                    Toggle("Carbon Analysis", isOn: $carbonAnalysisEnabled)
                }
                if UIDevice.iPhone {
                    Toggle("Cell Network Search", isOn: $cellNetworkSearchEnabled)
                }
                Toggle("Device Management", isOn: $deviceManagementEnabled)
                if UIDevice.IsSimulator {
                    Toggle("Find My Mac", isOn: $findMyEnabled)
                }
                Toggle("HOMEKIT".localized(path: path, table: privTable), isOn: $homeKitEnabled)
                if UIDevice.IsSimulator {
                    Toggle("HomeEnergyDaemon.framework", isOn: $homeEnergyEnabled)
                }
                Toggle("NETWORKING_WIRELESS".localized(path: path, table: privTable), isOn: $networkingWirelessEnabled)
                    .confirmationDialog("WIRELESS_DISABLE_TITLE".localized(path: path, table: privTable), isPresented: $showingNetworkingAlert) {
                        Button("WIRELESS_DISABLE_CONFIRM".localized(path: path, table: privTable)) {}
                        Button("WIRELESS_DISABLE_CANCEL".localized(path: path, table: privTable), role: .cancel) {}
                    } message: {
                        Text("WIRELESS_DISABLE_MESSAGE_WIFI".localized(path: path, table: privTable))
                    }
                    .onChange(of: networkingWirelessEnabled) {
                        showingNetworkingAlert = !networkingWirelessEnabled
                    }
                Toggle("Setting Time Zone", isOn: $settingTimeZoneEnabled)
                Toggle(isOn: $suggestionsSearchEnabled) {
                    HStack {
                        Text("Suggestions & Search")
                        Spacer()
                        Image(systemName: "location.fill")
                            .foregroundStyle(.gray)
                            .font(.title2)
                    }
                }
                Toggle("SYSTEM_CUSTOMIZATION".localized(path: path, table: privTable), isOn: $systemCustomizationEnabled)
            }
            
            Section {
                Toggle("WIRELESS_DIAGNOSTICS".localized(path: path, table: table), isOn: $deviceAnalyticsEnabled)
                if !UIDevice.IsSimulator {
                    Toggle("ROUTING_AND_TRAFFIC".localized(path: path, table: privTable), isOn: $routingTrafficEnabled)
                }
                Toggle("POLARIS_TITLE".localized(path: path, table: table), isOn: $improveMapsEnabled)
            } header: {
                Text("PRODUCT_IMPROVEMENT".localized(path: path, table: table))
            } footer: {
                VStack(alignment: .leading) {
                    Text(.init("\("POLARIS_FOOTER".localized(path: path, table: table, "[\("LEARN_MORE".localized(path: path, table: table))](pref://)"))\n"))
                    
                    Group {
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
            
            Section {
                Toggle("STATUS_BAR_ICON".localized(path: path, table: table), isOn: $controlCenterIconEnabled)
            } footer: {
                Text("SYSTEM_SERVICES_STATUS_BAR_ICON_EXPLANATION".localized(path: path, table: table))
            }
        }
        .onOpenURL { url in
            if url.scheme == "pref" {
                showingSheet = true
            }
        }
        .sheet(isPresented: $showingSheet) {
            OnBoardingKitView(bundleID: "com.apple.onboarding.maps")
                .ignoresSafeArea()
        }
    }
}

#Preview {
    NavigationStack {
        SystemServicesView()
    }
}
