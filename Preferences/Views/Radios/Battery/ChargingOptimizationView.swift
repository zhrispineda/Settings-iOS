//
//  ChargingOptimizationView.swift
//  Preferences
//
//  Settings > Battery > Charging Optimization
//

import SwiftUI

struct ChargingOptimizationView: View {
    // Variables
    @State private var selected = "Optimized Battery Charging"
    @State private var showingNoneWarning = false
    @State private var showingOptimizeWarning = false
    @State private var temporaryOptimizePauseEnabled = false
    @State private var optimizedBatteryChargingEnabled = true
    @State private var temporaryCleanPauseEnabled = false
    @State private var cleanEnergyChargingEnabled = true
    @State private var showingCleanEnergyWarning = false
    @State private var chargeLimit = 100.0
    let options = ["Optimized Battery Charging", "80% Limit", "None"]
    let table = "BatteryUI"
    
    var body: some View {
        CustomList(title: "CHARGING_TITLE_CHARGING".localize(table: table)) {
            Section {} footer: {
                Text(.init("CHARGING_LIMIT_FOOTER".localize(table: table, "[\("LM_TEXT".localize(table: table))](\("CHARGING_LIMIT_URL".localize(table: table)))")))
            }
            
            Section {
                Slider(
                    value: $chargeLimit,
                    in: 80.0...100.0,
                    step: 5.0
                )
                .onChange(of: chargeLimit) {
                    if chargeLimit < 100 {
                        optimizedBatteryChargingEnabled = false
                    }
                }
            } header: {
                Text("CHARGING_LIMIT_HEADER".localize(table: table))
            }
            
            Section {
                Toggle("SC_TITLE".localize(table: table), isOn: $optimizedBatteryChargingEnabled)
                    .onChange(of: optimizedBatteryChargingEnabled) {
                        showingOptimizeWarning = !optimizedBatteryChargingEnabled
                        temporaryOptimizePauseEnabled = false
                    }
            } footer: {
                Text("CHARGING_OPTIMIZED_BATTERY_CHARGING_FOOTER_WITH_CHARGE_LIMIT".localize(table: table, "100%", "80%") + " \(temporaryOptimizePauseEnabled ? "SC_FOOTER_TEXT_TEMP_DISABLE_ADDITION".localize(table: table, "6:00 AM") : String())")
            }
            .disabled(chargeLimit < 100.0)
            .alert("SC_ALERT_TITLE".localize(table: table), isPresented: $showingOptimizeWarning) {
                Button("SC_ALERT_TEMP_DISABLE".localize(table: table), role: .none) {
                    temporaryOptimizePauseEnabled = true
                }
                Button("SC_ALERT_DISABLE".localize(table: table), role: .none) {
                    temporaryOptimizePauseEnabled = false
                }
                Button("SC_ALERT_LEAVE_ON".localize(table: table), role: .none) {
                    optimizedBatteryChargingEnabled = true
                }
            }
            
            Section {
                Toggle("CLEAN_ENERGY_TITLE".localize(table: table), isOn: $cleanEnergyChargingEnabled)
                    .onChange(of: cleanEnergyChargingEnabled) {
                        showingCleanEnergyWarning = !cleanEnergyChargingEnabled
                        temporaryCleanPauseEnabled = false
                    }
            } footer: {
                Text(.init("CLEAN_ENERGY_FOOTER".localize(table: table) + " \(temporaryCleanPauseEnabled ? "CEC_FOOTER_TEXT_TEMP_DISABLE_ADDITION".localize(table: table, "6:00 AM") : String())" + "[\("CEC_LINK".localize(table: table))](https://support.apple.com/en-us/108068)"))
            }
            .alert("CEC_ALERT_TITLE", isPresented: $showingCleanEnergyWarning) {
                Button("CEC_ALERT_TEMP_DISABLE", role: .none) {
                    temporaryCleanPauseEnabled = true
                }
                Button("CEC_ALERT_DISABLE", role: .none) {
                    cleanEnergyChargingEnabled = false
                }
                Button("CEC_ALERT_LEAVE_ON", role: .none) {
                    cleanEnergyChargingEnabled = true
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ChargingOptimizationView()
    }
}
