//
//  SystemServicesView.swift
//  Preferences
//
//  Settings > Screen Time > Content & Privacy Restrictions > Location Services > System Services
//

import SwiftUI

struct SystemServicesView: View {
    // Variables
    @State private var alertsShortcutsAutomationsEnabled = false
    @State private var carbonAnalysisEnabled = true
    @State private var cellNetworkSearchEnabled = true
    @State private var deviceManagementEnabled = true
    @State private var findMyEnabled = true
    @State private var homeKitEnabled = true
    @State private var networkingWirelessEnabled = false
    @State private var showingNetworkingAlert = false
    @State private var settingTimeZoneEnabled = true
    @State private var suggestionsSearchEnabled = true
    @State private var systemCustomizationEnabled = false
    @State private var deviceAnalyticsEnabled = true
    @State private var routingTrafficEnabled = false
    @State private var improveMapsEnabled = false
    @State private var controlCenterIconEnabled = false
    let table = "Location Services"
    let privTable = "LocationServicesPrivacy"
    
    var body: some View {
        CustomList(title: "SYSTEM_SERVICES".localize(table: table)) {
            Section {
                Toggle("LOCATION_BASED_ALERTS".localize(table: privTable), isOn: $alertsShortcutsAutomationsEnabled)
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
                Toggle("HOMEKIT".localize(table: privTable), isOn: $homeKitEnabled)
                Toggle("NETWORKING_WIRELESS".localize(table: privTable), isOn: $networkingWirelessEnabled)
                    .alert("WIRELESS_DISABLE_TITLE".localize(table: privTable), isPresented: $showingNetworkingAlert) {
                        Button("WIRELESS_DISABLE_CONFIRM".localize(table: privTable)) {}
                        Button("WIRELESS_DISABLE_CANCEL".localize(table: privTable), role: .cancel) {}
                    } message: {
                        Text("WIRELESS_DISABLE_MESSAGE_WIFI", tableName: privTable)
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
                Toggle("SYSTEM_CUSTOMIZATION".localize(table: privTable), isOn: $systemCustomizationEnabled)
            }
            
            Section {
                Toggle("WIRELESS_DIAGNOSTICS".localize(table: table), isOn: $deviceAnalyticsEnabled)
                Toggle("ROUTING_AND_TRAFFIC".localize(table: privTable), isOn: $routingTrafficEnabled)
                Toggle("POLARIS_TITLE".localize(table: table), isOn: $improveMapsEnabled)
            } header: {
                Text("PRODUCT_IMPROVEMENT", tableName: table)
            } footer: {
                VStack(alignment: .leading) {
                    Text(.init("POLARIS_FOOTER".localize(table: table, "[\("LEARN_MORE".localize(table: table))](#)"))) + Text("\n")
                    
                    Group {
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
            
            Section {
                Toggle("STATUS_BAR_ICON".localize(table: table), isOn: $controlCenterIconEnabled)
            } footer: {
                Text("SYSTEM_SERVICES_STATUS_BAR_ICON_EXPLANATION", tableName: table)
            }
        }
    }
}

#Preview {
    NavigationStack {
        SystemServicesView()
    }
}
