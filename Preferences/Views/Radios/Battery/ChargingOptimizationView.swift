//
//  ChargingOptimizationView.swift
//  Preferences
//
//  Settings > Battery > Charging Optimization
//

import SwiftUI

struct ChargingOptimizationView: View {
    @AppStorage("ChargeLimitValue") private var chargeLimit = 100.0
    @AppStorage("CleanEnergyChargingToggle") private var cleanEnergyChargingEnabled = true
    @AppStorage("OptimizedBatteryChargingToggle") private var optimizedBatteryChargingEnabled = true
    @AppStorage("CleanPauseEnabled") private var temporaryCleanPauseEnabled = false
    @AppStorage("OptimizePauseToggle") private var temporaryOptimizePauseEnabled = false
    @AppStorage("ChargeLimitTempEnabled") private var chargeLimitSchedule = false
    @AppStorage("ChargeLimitPreviousValue") private var previousChargeLimit = 100
    @State private var showingChargeLimitPending = false
    @State private var showingCleanEnergyWarning = false
    @State private var showingOptimizeWarning = false
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
                .onChange(of: chargeLimit) { oldValue, newValue in
                    previousChargeLimit = Int(oldValue)
                    if chargeLimit < 100 {
                        optimizedBatteryChargingEnabled = false
                        chargeLimitSchedule = false
                    } else if chargeLimit == 100.0 && previousChargeLimit != 100 {
                        showingChargeLimitPending = true
                    }
                }
                .tint(.gray)
            } header: {
                Text("CHARGING_LIMIT_HEADER", tableName: table)
            } footer: {
                if chargeLimitSchedule && previousChargeLimit < 100 {
                    Text("CHARGING_LIMIT_TEMP_DISABLE_FOOTER".localize(table: table, "\(previousChargeLimit)%", "6:00 AM"))
                }
            }
            
            Section {
                Toggle("SC_TITLE".localize(table: table), isOn: $optimizedBatteryChargingEnabled)
                    .onChange(of: optimizedBatteryChargingEnabled) {
                        if chargeLimit == 100 {
                            showingOptimizeWarning = !optimizedBatteryChargingEnabled
                        }
                        temporaryOptimizePauseEnabled = false
                    }
            } footer: {
                Text("\("CHARGING_OPTIMIZED_BATTERY_CHARGING_FOOTER_WITH_CHARGE_LIMIT".localize(table: table, "100%", "80%")) \(temporaryOptimizePauseEnabled ? "SC_FOOTER_TEXT_TEMP_DISABLE_ADDITION".localize(table: table, "6:00 AM") : "")")
            }
            .disabled(chargeLimit < 100)
            
            Section {
                Toggle("CLEAN_ENERGY_TITLE".localize(table: table), isOn: $cleanEnergyChargingEnabled)
                    .onChange(of: cleanEnergyChargingEnabled) {
                        showingCleanEnergyWarning = !cleanEnergyChargingEnabled
                        temporaryCleanPauseEnabled = false
                    }
            } footer: {
                Text(.init("\("CLEAN_ENERGY_FOOTER".localize(table: table)) \(temporaryCleanPauseEnabled ? "CEC_FOOTER_TEXT_TEMP_DISABLE_ADDITION".localize(table: table, "6:00 AM") : "") [\("CEC_LINK".localize(table: table))](https://support.apple.com/en-us/108068)"))
            }
        }
        .alert("CHARGING_LIMIT_TO_FULL_ALERT_TITLE".localize(table: table), isPresented: $showingChargeLimitPending) {
            Button("CHARGING_LIMIT_TO_FULL_ALERT_ALLOW_ONCE".localize(table: table), role: .none) {
                chargeLimitSchedule = true
            }
            Button("CHARGING_LIMIT_TO_FULL_ALERT_SET_TO_FULL".localize(table: table, "100%"), role: .none) {
                previousChargeLimit = 100
            }
            Button("CHARGING_LIMIT_TO_FULL_ALERT_CANCEL".localize(table: table), role: .none) {
                chargeLimit = Double(previousChargeLimit)
            }
        } message: {
            Text("CHARGING_LIMIT_TO_FULL_ALERT_BODY".localize(table: table, "100%"))
        }
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
        .alert("CEC_ALERT_TITLE".localize(table: table), isPresented: $showingCleanEnergyWarning) {
            Button("CEC_ALERT_TEMP_DISABLE".localize(table: table), role: .none) {
                temporaryCleanPauseEnabled = true
            }
            Button("CEC_ALERT_DISABLE".localize(table: table), role: .none) {
                cleanEnergyChargingEnabled = false
            }
            Button("CEC_ALERT_LEAVE_ON".localize(table: table), role: .none) {
                cleanEnergyChargingEnabled = true
            }
        }
    }
}

#Preview {
    NavigationStack {
        ChargingOptimizationView()
    }
}
