//
//  NetworkView.swift
//  Preferences
//
//  Settings > Wi-Fi
//

import SwiftUI

struct NetworkView: View {
    // Variables
    @State private var networkEnabled = true
    
    var body: some View {
        CustomList(title: "Wi-Fi") {
            Section(content: {
                Toggle(isOn: $networkEnabled, label: {
                    HStack {
                        Image(systemName: "checkmark")
                            .foregroundStyle(.clear)
                        Text("Wi-Fi")
                    }
                })
            }, footer: {
                if !networkEnabled {
                    Text("AirDrop, AirPlay, Notify When Left Behind, and \(DeviceInfo().isPhone ? "improved location accuracy" : "location services") require Wi-Fi.")
                }
            })
            
            if networkEnabled {
                Section(content: {
                    Button(action: {}, label: {
                        HStack {
                            Image(systemName: "checkmark")
                                .foregroundStyle(.clear)
                            Text("Other...")
                                .foregroundStyle(Color["Label"])
                        }
                    })
                }, header: {
                    Text("Networks")
                })
                
                Section(content: {
                    CustomNavigationLink(title: "Ask to Join Networks", status: "Off", destination: EmptyView())
                }, footer: {
                    Text("Known networks will be joined automatically. If no known networks are available, you will have to manually select a network.")
                })
                
                Section(content: {
                    CustomNavigationLink(title: "Auto-Join Hotspot", status: "Never", destination: EmptyView())
                }, footer: {
                    Text("Allow this device to automatically discover nearby personal hotspots when no Wi-Fi network is available.")
                })
            }
        }
        .toolbar {
            EditButton()
        }
    }
}

#Preview {
    NavigationStack {
        NetworkView()
    }
}