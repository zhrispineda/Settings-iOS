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
        CustomList(title: "BATTERY_TITLE") {
            Section {
                Toggle("BATTERY_PERCENTAGE", isOn: $batteryPercentageEnabled)
                Toggle("BATTERY_SAVER_MODE", isOn: $lowPowerModeEnabled)
            } footer: {
                Text(UIDevice.iPhone ? "FOOTNOTE_BATTERYSAVERMODE_IPHONE" : "FOOTNOTE_BATTERYSAVERMODE_IPAD")
            }
            
            Section {
                if UIDevice.DeviceSupportsBatteryInformation {
                    CustomNavigationLink(title: "BATTERY_HEALTH_TITLE", status: "NORMAL_STATE", destination: BatteryHealthView())
                    if UIDevice.iPhone {
                        NavigationLink("CHARGING_TITLE_CHARGING", destination: ChargingOptimizationView())
                    }
                } else {
                    if UIDevice.iPhone {
                        NavigationLink("BATTERY_HEALTH", destination: BatteryHealthChargingView())
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
