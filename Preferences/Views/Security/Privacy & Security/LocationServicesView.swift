//
//  LocationServicesView.swift
//  Preferences
//
//  Settings > Privacy & Security > Location Services
//

import SwiftUI

struct LocationServicesView: View {
    // Variables
    @State private var locationServicesEnabled = true
    var body: some View {
        CustomList(title: "Location Services") {
            Section {
                Toggle("Location Services", isOn: $locationServicesEnabled)
                NavigationLink("Location Alerts", destination: LocationAlertsView())
            } footer: {
                Text("Location Services uses GPS, Bluetooth, and crowd-sourced Wi-Fi hotspot and cell tower locations to determine your approximate location. [About Location Services & Privacy...](#)")
            }
            
//            Section {
//                NavigationLink("Share My Location") {}
//            }
            
            if locationServicesEnabled {
                Section {
                    SettingsLink(color: .white, iconColor: .blue, icon: "appclip", id: "App Clips") { AppClipsView()
                    }
                    CustomNavigationLink(title: "BulletinBoard.framework", status: "When Shared", destination: LocationPermissionsDetailView(title: "BulletinBoard.framework"))
                    CustomNavigationLink(title: "MobileWiFi.framework", status: "When Shared", destination: LocationPermissionsDetailView(title: "MobileWiFi.framework"))
                    SettingsLink(icon: "Placeholder", id: "Share My Location", status: "When Shared") {
                        LocationPermissionsDetailView(title: "Share My Location")
                    }
                    SettingsLink(icon: "appleSiri", id: "Siri", status: "When Shared") {
                        LocationPermissionsDetailView(title: "Siri")
                    }
                    CustomNavigationLink(title: "SystemCustomization.bundle", status: "When Shared", location: true, destination: LocationPermissionsDetailView(title: "SystemCustomization.bundle"))
                    CustomNavigationLink(title: "Traffic.bundle", status: "When Shared", destination: LocationPermissionsDetailView(title: "Traffic.bundle"))
                    SettingsLink(color: .gray, icon: "gear", id: "System Services", status: "location.fill") {
                        SystemServicesView()
                    }
                } footer: {
                    VStack(alignment: .leading) {
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
            }
        }
    }
}

#Preview {
    NavigationStack {
        LocationServicesView()
    }
}
