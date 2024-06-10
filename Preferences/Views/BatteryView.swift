//
//  BatteryView.swift
//  Preferences
//
//  Settings > Battery
//

import SwiftUI

struct BatteryView: View {
    // Variables
    @State private var batteryPercentageEnabled = false
    @State private var lowPowerModeEnabled = false
    
    var body: some View {
        CustomList(title: "Battery") {
            Section(content: {
                Toggle("Battery Percentage", isOn: $batteryPercentageEnabled)
                Toggle("Low Power Mode", isOn: $lowPowerModeEnabled)
            }, footer: {
                Text("Low Power Mode temporarily reduces background activity like downloads and mail fetch until you can fully charge your \(DeviceInfo().model).")
            })
            
            Section {
                if DeviceInfo().hasExtraBatteryFeatures {
                    CustomNavigationLink(title: "Battery Health", status: "Normal", destination: BatteryHealthView())
                    if DeviceInfo().isPhone {
                        CustomNavigationLink(title: "Charging Optimization", status: "Optimized", destination: ChargingOptimizationView())
                    }
                } else {
                    NavigationLink("Battery Health & Charging", destination: {})
                }
            }
            
            Section {
                ProgressView()
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

#Preview {
    NavigationStack {
        BatteryView()
    }
}
