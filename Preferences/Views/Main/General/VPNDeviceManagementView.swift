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
        if UIDevice.IsSimulator {
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea()
                .navigationTitle("VPN_DEVICE_MANAGEMENT".localize(table: "General"))
                .onAppear {
                    dismiss()
                }
        } else {
            CustomList(title: "VPN_DEVICE_MANAGEMENT".localize(table: "General")) {
                Section {
                    SLabel("VPN", color: .blue, icon: "network.connected.to.line.below", status: "Not Connected")
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
