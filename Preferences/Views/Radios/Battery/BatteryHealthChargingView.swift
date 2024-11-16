//
//  BatteryHealthChargingView.swift
//  Preferences
//
//  Settings > Battery > Battery Health & Charging
//

import SwiftUI

struct BatteryHealthChargingView: View {
    // Variables
    @State private var maximumCapacity = 100
    
    @AppStorage("OptimizedBatteryChargingToggle") private var optimizedBatteryChargingEnabled = true
    @State private var showingOptimizeWarning = false
    @AppStorage("OptimizedChargingPaused") private var temporaryOptimizePauseEnabled = false
    
    @AppStorage("CleanEnergyChargingToggle") private var cleanEnergyChargingEnabled = true
    @State private var showingCleanEnergyWarning = false
    @AppStorage("CleanChargingPaused") private var temporaryCleanPauseEnabled = false
    
    let table = "BatteryUI"
    
    var body: some View {
        CustomList(title: "BATTERY_HEALTH".localize(table: table)) {
            if Int(maximumCapacity) > 79 {
                Section {} footer: {
                    Text(.init("ABOUT_BATTERIES_TEXT_IPHONE".localize(table: table, "[\("ABOUT_BATTERIES_LINK".localize(table: table))](\("BW_LM_URL_3".localize(table: table)))")))
                }
            } else {
                VStack(alignment: .leading) {
                    Text("RECALIBRATION_TITLE", tableName: table)
                        .fontWeight(.semibold)
                    Text("SERVICE_RECOMMENDED_IPHONE", tableName: table)
                        .font(.subheadline)
                }
                Button("SERVICE_RECOMMENDED_LINK".localize(table: table)) {}
            }
            
            Section {
                LabeledContent("MAXIMUM_CAPACITY_NAME".localize(table: table), value: "\(maximumCapacity == -1 ? "Unknown" : String(maximumCapacity))%")
                    .onAppear {
                        // Get battery capacity value
                        let answer = MGHelper.read(key: "f2DlVMUVcV+MeWs/g2ku+g") ?? "-1"
                        if answer == "101" {
                            maximumCapacity = 100
                        } else if answer != "-1" {
                            maximumCapacity = Int(answer)!
                        }
                    }
            } footer: {
                Text("MAXIMUM_CAPACITY_FOOTER_TEXT", tableName: table)
            }
            
            Section {
                Text("PPC_NAME", tableName: table)
            } footer: {
                Text("PPC_PERFMGMT_DYNAMIC", tableName: table)
            }
            
            Section {
                Toggle("SC_TITLE".localize(table: table), isOn: $optimizedBatteryChargingEnabled)
                    .onChange(of: optimizedBatteryChargingEnabled) {
                        showingOptimizeWarning = !optimizedBatteryChargingEnabled
                        temporaryOptimizePauseEnabled = false
                    }
            } footer: {
                Text("SC_FOOTER_TEXT".localize(table: table, "80%") + " \(temporaryOptimizePauseEnabled ? "SC_FOOTER_TEXT_TEMP_DISABLE_ADDITION".localize(table: table, "6:00 AM") : String())")
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
            
            Section {
                Toggle("CLEAN_ENERGY_TITLE".localize(table: table), isOn: $cleanEnergyChargingEnabled)
                    .onChange(of: cleanEnergyChargingEnabled) {
                        showingCleanEnergyWarning = !cleanEnergyChargingEnabled
                        temporaryCleanPauseEnabled = false
                    }
            } footer: {
                Text("CLEAN_ENERGY_FOOTER".localize(table: table) + " \(temporaryCleanPauseEnabled ? "SC_FOOTER_TEXT_TEMP_DISABLE_ADDITION".localize(table: table, "6:00 AM") : String())")
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
}

#Preview {
    NavigationStack {
        BatteryHealthChargingView()
    }
}
