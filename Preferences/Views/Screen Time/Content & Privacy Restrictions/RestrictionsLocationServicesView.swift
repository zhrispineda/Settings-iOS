//
//  RestrictionsLocationServicesView.swift
//  Preferences
//
//  Settings > Screen Time > Content & Privacy Restrictions > Location Services
//

import SwiftUI

struct RestrictionsLocationServicesView: View {
    // Variables
    @State private var selected = "Allow Changes"
    @State private var locationServicesEnabled = true
    @State private var showingDisableLocationServicesAlert = false
    @State private var showingDisableLocationServicesDialog = false
    let options = ["Allow Changes", "Don't Allow Changes"]
    
    var body: some View {
        CustomList(title: "Location Services") {
            Section(content: {
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        selected = option
                    }, label: {
                        HStack {
                            Text(option)
                                .foregroundStyle(Color(UIColor.label))
                            Spacer()
                            Image(systemName: "\(selected == option ? "checkmark" : "")")
                        }
                    })
                }
            }, footer: {
                Text("Disallowing changes locks the settings shown below and prevents new apps from using location services.")
            })
            
            Section(content: {
                Toggle("Location Services", isOn: $locationServicesEnabled.animation())
                    .alert("Location Services", isPresented: $showingDisableLocationServicesAlert,
                           actions: {
                        Button("Turn Off Dictation", role: .none) {}
                        Button("Cancel", role: .cancel) { locationServicesEnabled.toggle() }
                    }, message: {
                        Text("Location Services will be disabled for all apps, but your personalized Location Services settings for apps will be temporarily restored if you use Find My iPad to enable Lost Mode.")
                    })
                    .confirmationDialog("Location Services will be disabled for all apps, but your personalized Location Services settings for apps will be temporarily restored if you use Find My iPhone to enable Lost Mode.", isPresented: $showingDisableLocationServicesDialog,
                                        titleVisibility: .visible,
                                        actions: {
                        Button("Turn Off", role: .destructive) {}
                        Button("Cancel", role: .cancel) { locationServicesEnabled.toggle() }
                    })
                    .onChange(of: locationServicesEnabled, {
                        if !locationServicesEnabled {
                            DeviceInfo().isPhone ? showingDisableLocationServicesDialog.toggle() : showingDisableLocationServicesAlert.toggle()
                        }
                    })
                NavigationLink("Location Alerts", destination: LocationAlertsView())
            }, footer: {
                Text("\(DeviceInfo().isTablet ? "Using Location Services requires turning on Wi-Fi.\n\n" : "")Location Services uses \(DeviceInfo().isTablet ? "Bluetooth and crowd-sourced Wi-Fi hotspot locations" : "GPS, Bluetooth, and crowd-sourced Wi-Fi hotspot and cell tower locations") to determine your approximate location. [About Location Services and Privacy...](#)")
            })
            
            if locationServicesEnabled {
                Section(content: {
                    SettingsLink(color: .white, icon: "appclip", id: "App Clips", content: {})
                    CustomNavigationLink(title: "AppGenius.bundle", status: "Never", destination: EmptyView())
                    CustomNavigationLink(title: "AssistantServices.framework", status: "When Shared", destination: EmptyView())
                    CustomNavigationLink(title: "BulletinBoard.framework", status: "When Shared", destination: EmptyView())
                    CustomNavigationLink(title: "CompassCalibration.bundle", status: "When Shared", destination: EmptyView())
                    CustomNavigationLink(title: "Emergency SOS.bundle", status: "When Shared", destination: EmptyView())
                    CustomNavigationLink(title: "MobileWiFi.framework", status: "When Shared", destination: EmptyView())
                    CustomNavigationLink(title: "MotionCalibration.bundle", status: "When Shared", destination: EmptyView())
                    CustomNavigationLink(title: "PassbookMerchantLookup.bundle", status: "When Shared", destination: EmptyView())
                    SettingsLink(icon: "Placeholder_Normal", id: "Share My Location", status: "When Shared", content: {})
                    SettingsLink(icon: "applesiri", id: "Siri & Dictation", status: "When Shared", content: {})
                    CustomNavigationLink(title: "SystemCustomization.bundle", status: "When Shared", location: true, destination: EmptyView())
                    CustomNavigationLink(title: "Traffic.bundle", status: "When Shared", destination: EmptyView())
                    SettingsLink(color: .gray, icon: "gear", id: "System Services", status: "location.fill", content: {})
                }, footer: {
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
                })
            }
        }
    }
}

#Preview {
    NavigationStack {
        RestrictionsLocationServicesView()
    }
}
