//
//  FocusView.swift
//  Preferences
//
//  Settings > Focus
//

import SwiftUI

struct FocusView: View {
    // Variables
    @State private var shareAcrossDevicesEnabled = true
    
    var body: some View {
        CustomList(title: "Focus") {
            Section {
                // Do Not Disturb
                NavigationLink {} label: {
                    HStack {
                        Image(systemName: "moon.fill").imageScale(.large)
                            .frame(width: 30)
                            .foregroundColor(.indigo)
                        Text("Do Not Disturb")
                            .padding(.horizontal, 10)
                    }
                }
                
                // Personal
                NavigationLink {} label: {
                    HStack {
                        Image(systemName: "person.fill").imageScale(.large)
                            .frame(width: 30)
                            .foregroundColor(.purple)
                        Text("Personal")
                            .padding(.horizontal, 10)
                        Spacer()
                        Text("Set Up").foregroundStyle(.secondary)
                    }
                }
                
                // Sleep
                NavigationLink {} label: {
                    HStack {
                        Image(systemName: "bed.double.fill").imageScale(.large)
                            .frame(width: 30)
                            .foregroundColor(.cyan)
                        Text("Sleep")
                            .padding(.horizontal, 10)
                        Spacer()
                        Text("Set Up").foregroundStyle(.secondary)
                    }
                }
                
                // Work
                NavigationLink {} label: {
                    HStack {
                        Image(systemName: "person.crop.square.fill").imageScale(.large)
                            .frame(width: 30)
                            .foregroundColor(.cyan)
                        Text("Work")
                            .padding(.horizontal, 10)
                        Spacer()
                        Text("Set Up").foregroundStyle(.secondary)
                    }
                }
            } footer: {
                Text("Focus lets you customize your device and silence calls and notifications. Turn it on and off in Control Center.")
            }
            
            Section {
                Toggle("Share Across Devices", isOn: $shareAcrossDevicesEnabled)
            } footer: {
                Text("Focus is shared across your devices, and turning one on for this device will turn it on for all of them.")
            }
            
            Section {
                CustomNavigationLink(title: "Focus Status", status: "Off", destination: EmptyView())
            } footer: {
                Text("When you give an app permission, it can share that you have notifications silenced when using Focus.")
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {} label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        FocusView()
    }
}
