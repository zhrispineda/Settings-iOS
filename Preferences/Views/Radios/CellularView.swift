//
//  CellularView.swift
//  Preferences
//
//  Settings > Cellular
//

import SwiftUI

struct CellularView: View {
    // Variables
    @State private var cellularDataEnabled = true
    @State private var mode: Int = 0
    @State private var wifiAssistEnabled = true
    @State private var cellularUsageStatisticsEnabled = true
    
    var body: some View {
        CustomList(title: "Cellular") {
            Section {
                Toggle("Cellular Data", isOn: $cellularDataEnabled)
                CustomNavigationLink(title: "Cellular Data Options", status: "Roaming Off", destination: EmptyView())
                Button("Set Up Personal Hotspot", action: {})
            } footer: {
                Text("Turn off cellular data to restrict all data to Wi-Fi, including email, web browsing, and push notifications.")
            }
            
            Section {
                Toggle("Turn On This Line", isOn: .constant(true))
                CustomNavigationLink(title: "Cellular Plans", status: "Plan", destination: EmptyView())
                CustomNavigationLink(title: "Network Selection", status: "Network", destination: EmptyView())
                CustomNavigationLink(title: "Wi-Fi Calling", status: "On", destination: EmptyView())
                CustomNavigationLink(title: "Calls on Other Devices", status: "On", destination: EmptyView())
                CustomNavigationLink(title: "Usage", status: "Used 0 KB - Unlimited", destination: EmptyView())
                NavigationLink("Carrier Services", destination: {})
                NavigationLink("SIM PIN", destination: {})
                Button("Delete eSIM", role: .destructive, action: {})
            } header: {
                Text("Carrier")
            }
            
            Section {
                Button {} label: {
                    Text("Add eSIM")
                }
            }
            
            Section {
                Picker("Billing Period", selection: $mode) {
                    Text("This Billing Period").tag(0)
                    Text("Last Billing Period").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, -10)
                HStack {
                    Text("APPS BY USAGE")
                        .font(.system(size: 12))
                    Spacer()
                    Text("SORT BY NAME")
                        .font(.system(size: 12))
                        .foregroundStyle(.blue)
                }
                SettingsLink(color: .gray, icon: "gear", id: "System Services", status: "0 KB", content: {})
            } header: {
                Text("Cellular Data")
            }
            
            Section {
                Toggle(isOn: $wifiAssistEnabled, label: {
                    Text("Wi-Fi Assist")
                    Text("0 KB")
                })
            } footer: {
                Text("Automatically use cellular data when Wi-Fi connectivity is poor.")
            }
            
//            Section {
//                EmptyView()
//            } footer: {
//                Text("When not connected to Wi-Fi, use cellular network to transfer documents and data.")
//            }
            
//            Section {
//                EmptyView()
//            } footer: {
//                Text("When not connected to Wi-Fi, use your cellular network to automatically back up to iCloud. This may cause you to exceed your cellular data plan.")
//            }
            
            Section {
                Toggle("Cellular Usage Statistics", isOn: $cellularUsageStatisticsEnabled)
                Button("Reset Statistics", action: {})
            } header: {
                Text("Cellular Usage Statistics")
            } footer: {
                Text("Disabling cellular usage statistics will disable all cellular usage tracking, as well as reset any currently tracked usage to zero.\n\nLast Reset: ")
            }
        }
    }
}

#Preview {
    NavigationStack {
        CellularView()
    }
}
