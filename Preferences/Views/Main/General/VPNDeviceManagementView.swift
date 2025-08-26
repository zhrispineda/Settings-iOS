//
//  VPNDeviceManagementView.swift
//  Preferences
//
//  Settings > General > VPN & Device Management
//

import SwiftUI

struct VPNDeviceManagementView: View {
    @Environment(\.dismiss) private var dismiss
    let path = "/System/Library/ExtensionKit/Extensions/MCUIAppIntents.appex"

    var body: some View {
        if UIDevice.IsSimulator {
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea()
                .navigationTitle("VPN & Device Management".localized(path: path))
                .onAppear {
                    dismiss()
                }
        } else {
            CustomList(title: "VPN & Device Management".localized(path: path)) {
                Section {
                    SLabel("VPN", icon: "com.apple.graphic-icon.vpn", status: "Not Connected")
                }
                
                Button("Sign In to Work or School Account".localized(path: path) + "…") {}
            }
        }
    }
}

#Preview {
    NavigationStack {
        VPNDeviceManagementView()
    }
}
