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
    @State private var wifiAssistEnabled = true
    @State private var cellularUsageStatisticsEnabled = true
    
    var body: some View {
        CustomList(title: "Cellular") {
            Section(content: {
                Toggle("Cellular Data", isOn: $cellularDataEnabled)
                CustomNavigationLink(title: "Cellular Data Options", status: "Roaming Off", destination: EmptyView())
                Button("Set Up Personal Hotspot", action: {})
            }, footer: {
                Text("Turn off cellular data to restrict all data to Wi-Fi, including email, web browsing, and push notifications.")
            })
            
            Section(content: {
                Toggle("Turn On This Line", isOn: .constant(true))
                CustomNavigationLink(title: "Cellular Plans", status: "Plan", destination: EmptyView())
                CustomNavigationLink(title: "Network Selection", status: "Network", destination: EmptyView())
                CustomNavigationLink(title: "Wi-Fi Calling", status: "On", destination: EmptyView())
                CustomNavigationLink(title: "Calls on Other Devices", status: "On", destination: EmptyView())
                CustomNavigationLink(title: "Usage", status: "Used 0 KB - Unlimited", destination: EmptyView())
                NavigationLink("Carrier Services", destination: {})
                NavigationLink("SIM PIN", destination: {})
                Button("Delete eSIM", role: .destructive, action: {})
            }, header: {
                Text("Carrier")
            })
            
            Section {
                Button(action: {}, label: {
                    Text("Add eSIM")
                })
            }
            
            Section(content: {
                EmptyView()
            }, header: {
                Text("Cellular Data")
            })
            
            Section(content: {
                Toggle(isOn: $wifiAssistEnabled, label: {
                    Text("Wi-Fi Assist")
                    Text("0 KB")
                })
            }, footer: {
                Text("Automatically use cellular data when Wi-Fi connectivity is poor.")
            })
            
//            Section(content: {
//                EmptyView()
//            }, footer: {
//                Text("When not connected to Wi-Fi, use cellular network to transfer documents and data.")
//            })
            
//            Section(content: {
//                EmptyView()
//            }, footer: {
//                Text("When not connected to Wi-Fi, use your cellular network to automatically back up to iCloud. This may cause you to exceed your cellular data plan.")
//            })
            
            Section(content: {
                Toggle("Cellular Usage Statistics", isOn: $cellularUsageStatisticsEnabled)
                Button("Reset Statistics", action: {})
            }, header: {
                Text("Cellular Usage Statistics")
            }, footer: {
                Text("Disabling cellular usage statistics will disable all cellular usage tracking, as well as reset any currently tracked usage to zero.\n\nLast Reset: ")
            })
        }
    }
}

#Preview {
    NavigationStack {
        CellularView()
    }
}
