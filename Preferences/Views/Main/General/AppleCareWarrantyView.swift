//
//  AppleCareWarrantyView.swift
//  Preferences
//
//  Settings > General > AppleCare & Warranty
//

import SwiftUI

struct AppleCareWarrantyView: View {
    var body: some View {
        CustomList(title: "AppleCare & Warranty", topPadding: true) {
            Section {
                SettingsLink(icon: UIDevice.current.model.lowercased(), id: UIDevice.current.model, subtitle: "Limited Warranty") {}
            } header: {
                Text("This Device")
            } footer: {
                Text("Coverage is shown for devices connected to your Apple Account and select Bluetooth-paired devices.")
            }
        }
        .refreshable {}
    }
}

#Preview {
    NavigationStack {
        AppleCareWarrantyView()
    }
}
