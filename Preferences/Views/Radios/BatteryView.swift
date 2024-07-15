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
            Section {
                Toggle("Battery Percentage", isOn: $batteryPercentageEnabled)
                Toggle("Low Power Mode", isOn: $lowPowerModeEnabled)
            } footer: {
                Text("Low Power Mode temporarily reduces background activity like downloads and mail fetch until you can fully charge your \(UIDevice.current.model).")
            }
            
            Section {
                if UIDevice.DeviceSupportsBatteryInformation {
                    CustomNavigationLink(title: "Battery Health", status: "Normal", destination: BatteryHealthView())
                    if UIDevice.iPhone {
                        //CustomNavigationLink(title: "Charging Optimization", status: "Optimized", destination: ChargingOptimizationView())
                        NavigationLink("Charging", destination: ChargingOptimizationView())
                    }
                } else {
                    if UIDevice.iPhone {
                        NavigationLink("Battery Health & Charging", destination: BatteryHealthChargingView())
                    }
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
