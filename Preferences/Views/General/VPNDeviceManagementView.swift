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
        Color(UIColor.systemGroupedBackground)
            .ignoresSafeArea()
            .navigationTitle("VPN & Device Management")
            .onAppear {
                dismiss()
            }
    }
}

#Preview {
    VPNDeviceManagementView()
}
