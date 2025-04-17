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
    @State private var opacity: Double = 0
    @State private var frameY: Double = 0
    let table = UIDevice.iPhone ? "CellulariPhone" : "CellulariPad"
    
    var body: some View {
        CustomList {
            Placard(title: "Cellular", color: .green, icon: "antenna.radiowaves.left.and.right", description: "CELLULAR_SETTINGS_SUBTITLE".localize(table: table), frameY: $frameY, opacity: $opacity)
            
            Section {
                Button("SETUP_CELLULAR".localize(table: table)) {}
            }
            
//            Section {
//                Toggle("Cellular Data", isOn: $cellularDataEnabled)
//                CustomNavigationLink("Cellular Data Options", status: "Roaming Off", destination: EmptyView())
//                Button("Set Up Personal Hotspot") {}
//            } footer: {
//                Text("Turn off cellular data to restrict all data to Wi-Fi, including email, web browsing, and push notifications.")
//            }
//            
//            Section {
//                Toggle("Turn On This Line", isOn: .constant(true))
//                CustomNavigationLink("Cellular Plans", status: "Plan", destination: EmptyView())
//                CustomNavigationLink("Network Selection", status: "Network", destination: EmptyView())
//                CustomNavigationLink("Wi-Fi Calling", status: "On", destination: EmptyView())
//                CustomNavigationLink("Calls on Other Devices", status: "On", destination: EmptyView())
//                CustomNavigationLink("Usage", status: "Used 0 KB - Unlimited", destination: EmptyView())
//                NavigationLink("Carrier Services") {}
//                NavigationLink("SIM PIN") {}
//                Button("Delete eSIM", role: .destructive) {}
//            } header: {
//                Text("Carrier")
//            }
//            
//            Section {
//                Button {} label: {
//                    Text("Add eSIM")
//                }
//            }
//            
//            Section {
//                SLink(color: .gray, icon: "gear", id: "System Services", status: "0 KB", content: {})
//                NavigationLink("Show All") {
//                    CustomList(title: "Cellular Data Usage") {
//                        Picker("Billing Period", selection: $mode) {
//                            Text("This Billing Period").tag(0)
//                            Text("Last Billing Period").tag(1)
//                        }
//                        .pickerStyle(SegmentedPickerStyle())
//                        .padding(.horizontal, -10)
//                        HStack {
//                            Text("APPS BY USAGE")
//                                .font(.system(size: 12))
//                            Spacer()
//                            Text("SORT BY NAME")
//                                .font(.system(size: 12))
//                                .foregroundStyle(.blue)
//                        }
//                        SLink(color: .gray, icon: "gear", id: "System Services", status: "0 KB", content: {})
//                    }
//                }
//            } header: {
//                Text("Cellular Data")
//            }
//            
//            Section {
//                Toggle(isOn: $wifiAssistEnabled) {
//                    Text("Wi-Fi Assist")
//                    Text("0 KB")
//                }
//            } footer: {
//                Text("Automatically use cellular data when Wi-Fi connectivity is poor.")
//            }
            
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
            
//            Section {
//                Toggle("Cellular Usage Statistics", isOn: $cellularUsageStatisticsEnabled)
//                Button("Reset Statistics") {}
//            } header: {
//                Text("Cellular Usage Statistics")
//            } footer: {
//                Text("Disabling cellular usage statistics will disable all cellular usage tracking, as well as reset any currently tracked usage to zero.\n\nLast Reset: \(Date().formatted(date: .abbreviated, time: .shortened))")
//            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("**Cellular**")
                    .font(.subheadline)
                    .opacity(frameY < 50.0 ? opacity : 0) // Only fade when passing the help section title at the top
            }
        }
    }
}

#Preview {
    NavigationStack {
        CellularView()
    }
}
