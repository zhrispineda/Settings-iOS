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
            }, header: {
                Text("Carrier")
            })
            
            Section(content: {
                EmptyView()
            }, header: {
                Text("Cellular Data")
            })
            
            Section(content: {
                EmptyView()
            }, footer: {
                Text("Automatically use cellular data when Wi-Fi connectivity is poor.")
            })
            
            Section(content: {
                EmptyView()
            }, footer: {
                Text("When not connected to Wi-Fi, use cellular network to transfer documents and data.")
            })
            
            Section(content: {
                EmptyView()
            }, footer: {
                Text("When not connected to Wi-Fi, use your cellular network to automatically back up to iCloud. This may cause you to exceed your cellular data plan.")
            })
            
            Section(content: {
                EmptyView()
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
