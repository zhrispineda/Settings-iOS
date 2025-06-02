//
//  BatteryHealthChargingView.swift
//  Preferences
//
//  Settings > Battery > Battery Health & Charging
//

import SwiftUI

struct BatteryHealthChargingView: View {
    @AppStorage("CleanEnergyChargingToggle") private var cleanEnergyChargingEnabled = true
    @AppStorage("OptimizedBatteryChargingToggle") private var optimizedBatteryChargingEnabled = true
    @AppStorage("CleanChargingPaused") private var temporaryCleanPauseEnabled = false
    @AppStorage("OptimizedChargingPaused") private var temporaryOptimizePauseEnabled = false
    @State private var maximumCapacity = 100
    @State private var showingCleanEnergyWarning = false
    @State private var showingOptimizeWarning = false
    let table = "BatteryUI"
    
    var body: some View {
        CustomList(title: "BATTERY_HEALTH".localize(table: table)) {
            if maximumCapacity > 79 {
                // About Batteries Footer
                Section {} footer: {
                    Text(.init("ABOUT_BATTERIES_TEXT_IPHONE".localize(table: table, "[\("ABOUT_BATTERIES_LINK".localize(table: table))](\("BW_LM_URL_3".localize(table: table)))")))
                }
            } else {
                // Service Recommended Warning
                VStack(alignment: .leading) {
                    Text("RECALIBRATION_TITLE", tableName: table)
                        .fontWeight(.semibold)
                    Text("SERVICE_RECOMMENDED_IPHONE", tableName: table)
                        .font(.subheadline)
                }
                Button("SERVICE_RECOMMENDED_LINK".localize(table: table)) {}
            }
            
            // Maximum Capacity
            Section {
                LabeledContent("MAXIMUM_CAPACITY_NAME".localize(table: table), value: "\(maximumCapacity)%")
            } footer: {
                Text("MAXIMUM_CAPACITY_FOOTER_TEXT", tableName: table)
            }
            
            // Peak Performance Capability
            Section {
                Text("PPC_NAME", tableName: table)
            } footer: {
                Text("PPC_PERFMGMT_DYNAMIC", tableName: table)
            }
            
            // Optimized Battery Charging
            Section {
                Toggle("SC_TITLE".localize(table: table), isOn: $optimizedBatteryChargingEnabled)
                    .onChange(of: optimizedBatteryChargingEnabled) {
                        showingOptimizeWarning = !optimizedBatteryChargingEnabled
                        temporaryOptimizePauseEnabled = false
                    }
            } footer: {
                Text("\("SC_FOOTER_TEXT".localize(table: table, "80%")) \(temporaryOptimizePauseEnabled ? "SC_FOOTER_TEXT_TEMP_DISABLE_ADDITION".localize(table: table, "6:00 AM") : "")")
            }
            
            // Clean Energy Charging
            Section {
                Toggle("CLEAN_ENERGY_TITLE".localize(table: table), isOn: $cleanEnergyChargingEnabled)
                    .onChange(of: cleanEnergyChargingEnabled) {
                        showingCleanEnergyWarning = !cleanEnergyChargingEnabled
                        temporaryCleanPauseEnabled = false
                    }
            } footer: {
                Text("\("CLEAN_ENERGY_FOOTER".localize(table: table)) \(temporaryCleanPauseEnabled ? "SC_FOOTER_TEXT_TEMP_DISABLE_ADDITION".localize(table: table, "6:00 AM") : "")")
            }
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
        BatteryHealthChargingView()
    }
}
