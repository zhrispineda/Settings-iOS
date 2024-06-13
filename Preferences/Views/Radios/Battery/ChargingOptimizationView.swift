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
    let options = ["Optimized Battery Charging", "80% Limit", "None"]
    @State private var chargeLimit = 100.0
    
    var body: some View {
        //CustomList(title: "Charging Optimization") {
        CustomList(title: "Charging") {
            Section {} footer: {
                Text("\(UIDevice().model) can learn from your charging and usage habits to set charge limits and decide when to charge, which can help preserve battery lifespan over time. [Learn more...](https://support.apple.com/en-us/108055)")
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
                Text("Charge Limit")
            }
            
            Section {
                Toggle("Optimized Battery Charging", isOn: $optimizedBatteryChargingEnabled)
                    .onChange(of: optimizedBatteryChargingEnabled) {
                        showingOptimizeWarning = !optimizedBatteryChargingEnabled
                        temporaryOptimizePauseEnabled = false
                    }
            } footer: {
                Text("When the charge limit is set to 100%, allow \(Device().model) to wait to finish charging past 80% until the time you need to use it. \(temporaryOptimizePauseEnabled ? "Optimized Battery Charging is off until 6:00 AM. " : "")")
            }
            .disabled(chargeLimit < 100.0)
            .alert("Optimized Battery Charging helps reduce battery aging.", isPresented: $showingOptimizeWarning, actions: {
                Button("**Turn Off Until Tomorrow**", role: .none, action: {
                    temporaryOptimizePauseEnabled = true
                })
                Button("Turn Off", role: .none, action: {
                    temporaryOptimizePauseEnabled = false
                })
                Button("Cancel", role: .none, action: {
                    optimizedBatteryChargingEnabled = true
                })
            })
            
            Section {
                Toggle("Clean Energy Charging", isOn: $cleanEnergyChargingEnabled)
                    .onChange(of: cleanEnergyChargingEnabled) {
                        showingCleanEnergyWarning = !cleanEnergyChargingEnabled
                        temporaryCleanPauseEnabled = false
                    }
            } footer: {
                Text("In your region, \(Device().model) will try to reduce your carbon footprint by selectively charging when lower carbon emission electricity is available. \(Device().model) learns from your daily charging routine so it can reach full charge before you need to use it. \(temporaryCleanPauseEnabled ? "Clean Energy Charging is off until 6:00 AM. " : "")[Learn more...](https://support.apple.com/en-us/108068)")
            }
            .alert("Clean Energy Charging helps reduce carbon footprint.", isPresented: $showingCleanEnergyWarning, actions: {
                Button("**Turn Off Until Tomorrow**", role: .none) {
                    temporaryCleanPauseEnabled = true
                }
                Button("Turn Off", role: .none) {
                    cleanEnergyChargingEnabled = false
                }
                Button("Cancel", role: .none) {
                    cleanEnergyChargingEnabled = true
                }
            })
        }
    }
}

#Preview {
    NavigationStack {
        ChargingOptimizationView()
    }
}
