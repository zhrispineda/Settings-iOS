//
//  BatteryView.swift
//  Preferences
//
//  Settings > Battery
//

import SwiftUI

struct BatteryView: View {
    // Variables
    @AppStorage("batteryPercentage") private var batteryPercentageEnabled = true
    @AppStorage("lowPowerMode") private var lowPowerModeEnabled = false
    let table = "BatteryUI"
    
    var body: some View {
        CustomList(title: "BATTERY_TITLE".localize(table: table)) {
            Section {
                Toggle("BATTERY_PERCENTAGE".localize(table: table), isOn: $batteryPercentageEnabled)
                Toggle("BATTERY_SAVER_MODE".localize(table: table), isOn: $lowPowerModeEnabled)
            } footer: {
                Text(UIDevice.iPhone ? "FOOTNOTE_BATTERYSAVERMODE_IPHONE".localize(table: table) : "FOOTNOTE_BATTERYSAVERMODE_IPAD".localize(table: table))
            }
            
            Section {
                if UIDevice.DeviceSupportsBatteryInformation {
                    CustomNavigationLink(title: "BATTERY_HEALTH_TITLE".localize(table: table), status: "NORMAL_STATE".localize(table: table), destination: BatteryHealthView())
                    if UIDevice.iPhone {
                        NavigationLink("CHARGING_TITLE_CHARGING".localize(table: table), destination: ChargingOptimizationView())
                    }
                } else {
                    if UIDevice.iPhone {
                        NavigationLink("BATTERY_HEALTH".localize(table: table), destination: BatteryHealthChargingView())
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
