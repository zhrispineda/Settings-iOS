//
//  AppleCareWarrantyView.swift
//  Preferences
//
//  Settings > General > AppleCare & Warranty
//

import SwiftUI

struct AppleCareWarrantyView: View {
    // Variables
    let table = "NewDeviceOutreachUI"
    
    var body: some View {
//        CustomList(title: "AppleCare & Warranty", topPadding: true) {
//            Section {
//                SLink(icon: UIDevice.current.model.lowercased(), id: UIDevice.current.model, subtitle: "Limited Warranty") {}
//            } header: {
//                Text("This Device")
//            } footer: {
//                Text("Coverage is shown for devices connected to your Apple Account and select Bluetooth-paired devices.")
//            }
//        }
//        .refreshable {}
        ScrollView {
            ZStack {
                Spacer().containerRelativeFrame(.vertical)
                ContentUnavailableView(
                    "CC_NO_ACCOUNT_ERROR_TITLE".localize(table: table),
                    systemImage: "person.crop.circle",
                    description: Text("CC_NO_ACCOUNT_ERROR_SUBTITLE", tableName: table)
                )
            }
        }
        .navigationTitle("COVERAGE".localize(table: "General"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        AppleCareWarrantyView()
    }
}
