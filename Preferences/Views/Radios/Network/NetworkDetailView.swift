//
//  NetworkDetailView.swift
//  Preferences
//
//  Settings > Wi-Fi > [Network]
//

import SwiftUI

struct NetworkDetailView: View {
    @State private var privateWifiAddressEnabled = true
    
    var body: some View {
        CustomList(title: "NETWORK") {
//            Section {
//                Text("**Unsecured Network**")
//                Text("Open networks provide no security and expose all network traffic.")
//                    .foregroundStyle(.secondary)
//                    .listRowSeparator(.hidden)
//                Text("If this is your Wi-Fi network, configure the router to use WPA2 (AES) or WPA3 security type.")
//                    .foregroundStyle(.secondary)
//                Text("**Privacy Warning**")
//                Text("Private Wi-Fi address is turned off for this network.")
//                    .foregroundStyle(.secondary)
//                    .listRowSeparator(.hidden)
//                Text("Using a private address helps reduce tracking of your iPhone across different Wi-Fi networks.")
//                    .foregroundStyle(.secondary)
//            } footer: {
//                Text("[Learn more about recommended settings for Wi-Fi...](#)")
//            }
            
            Section {
                Button("Join This Network", action: {})
            }
            
            Section {
                Toggle("Private Wi-Fi Address", isOn: $privateWifiAddressEnabled)
                LabeledContent("Wi-Fi Address", value: "00:00:0X:XX:0X:X0")
            } footer: {
                Text("Using a privatr address helps reduce tracking of your \(Device().model) across different Wi-Fi networks.")
            }
            
            Section {
                CustomNavigationLink(title: "Configure IP", status: "Automatic", destination: EmptyView())
            } header: {
                Text("IPv4 Address")
            }
            
            Section {
                CustomNavigationLink(title: "Configure DNS", status: "Automatic", destination: EmptyView())
            } header: {
                Text("DNS")
            }
            
            Section {
                CustomNavigationLink(title: "Configure Proxy", status: "Off", destination: EmptyView())
            } header: {
                Text("HTTP Proxy")
            }
        }
    }
}

#Preview {
    NavigationStack {
        NetworkDetailView()
    }
}
