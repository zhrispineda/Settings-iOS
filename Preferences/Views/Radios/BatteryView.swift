//
//  BatteryView.swift
//  Preferences
//
//  Settings > Battery
//

import SwiftUI

struct BatteryView: View {
    var body: some View {
        CustomViewController("/System/Library/PreferenceBundles/BatteryUsageUI.bundle/BatteryUsageUI", controller: "BatteryUIController")
            .ignoresSafeArea()
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Battery")
                        .fontWeight(.semibold)
                        .font(.subheadline)
                }
            }
    }
}

#Preview {
    BatteryView()
}
