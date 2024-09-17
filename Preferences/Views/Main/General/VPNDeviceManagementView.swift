//
//  VPNDeviceManagementView.swift
//  Preferences
//
//  Settings > General > VPN & Device Management
//

import SwiftUI

struct VPNDeviceManagementView: View {
    // Variables
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        if UIDevice.isSimulator {
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea()
                .navigationTitle("VPN & Device Management")
                .onAppear {
                    dismiss()
                }
        } else {
            CustomList(title: "VPN & Device Management") {
                Section {
                    SettingsLabel(color: .blue, icon: "network.connected.to.line.below", id: "VPN", status: "Not Connected")
                }
                
                Button("Sign In to Work or School Account...") {}
            }
        }
    }
}

#Preview {
    NavigationStack {
        VPNDeviceManagementView()
    }
}
