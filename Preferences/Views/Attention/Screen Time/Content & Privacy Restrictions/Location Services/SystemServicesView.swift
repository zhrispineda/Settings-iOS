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
    
    var body: some View {
        CustomList(title: "System Services") {
            Section {
                Toggle("Alerts & Shortcuts Automations", isOn: $alertsShortcutsAutomationsEnabled)
                Toggle("Carbon Analysis", isOn: $carbonAnalysisEnabled)
                if Device().isPhone {
                    Toggle("Cell Network Search", isOn: $cellNetworkSearchEnabled)
                }
                Toggle("Device Management", isOn: $deviceManagementEnabled)
                Toggle("Find My Mac", isOn: $findMyEnabled)
                Toggle("HomeKit", isOn: $homeKitEnabled)
                Toggle("Networking & Wireless", isOn: $networkingWirelessEnabled)
                    .alert("Location for Networking & Wireless", isPresented: $showingNetworkingAlert) {
                        Button("Turn Off") {}
                        Button("Cancel", role: .cancel) {}
                    } message: {
                        Text("Turning off location for networking and wireless may affect Bluetooth and Wi-Fi performance.")
                    }
                    .onChange(of: networkingWirelessEnabled) {
                        showingNetworkingAlert = !networkingWirelessEnabled
                    }
                Toggle("Setting Time Zone", isOn: $settingTimeZoneEnabled)
                Toggle(isOn: $suggestionsSearchEnabled, label: {
                    HStack {
                        Text("Suggestions & Search")
                        Spacer()
                        Image(systemName: "location.fill")
                            .foregroundStyle(.gray)
                            .font(.title2)
                    }
                })
                Toggle("System Customization", isOn: $systemCustomizationEnabled)
            }
            
            Section(content: {
                Toggle("\(Device().model) Analytics", isOn: $deviceAnalyticsEnabled)
                Toggle("Routing & Traffic", isOn: $routingTrafficEnabled)
                Toggle("Improve Maps", isOn: $improveMapsEnabled)
            }, header: {
                Text("Product Improvement")
            }, footer: {
                VStack(alignment: .leading) {
                    Text("Allow Apple to use your frequent location information to improve Maps. [About Improve Maps & Privacy...](#)\n\n\n")
                    
                    Group {
                        Text("System services that have requested access to your location will appear here.\n")
                        HStack(spacing: 15) {
                            Image(systemName: "location.fill")
                                .foregroundStyle(.purple)
                                .font(.headline)
                            Text("A purple arrow indicates that an item has recently used your location.")
                        }
                        .padding(.trailing)
                        .padding(.bottom, 5)
                        
                        HStack(spacing: 15) {
                            Image(systemName: "location.fill")
                                .foregroundStyle(.gray)
                                .font(.headline)
                            Text("A gray arrow indicates that an item has used your location in the last 24 hours.")
                        }
                        .padding(.trailing)
                    }
                }
            })
            
            Section(content: {
                Toggle("Status Bar Icon", isOn: $controlCenterIconEnabled)
            }, footer: {
                Text("Show the Location Services icon in the Status Bar when the services above request your location.")
            })
        }
    }
}

#Preview {
    SystemServicesView()
}
