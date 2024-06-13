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
    
    @State private var optimizedBatteryChargingEnabled = true
    @State private var showingOptimizeWarning = false
    @State private var temporaryOptimizePauseEnabled = false
    
    @State private var cleanEnergyChargingEnabled = true
    @State private var showingCleanEnergyWarning = false
    @State private var temporaryCleanPauseEnabled = false
    
    var body: some View {
        CustomList(title: "Battery Health & Charging") {
            Section {} footer: {
                Text("Phone batteries, like all rechargeable batteries, are consumable components that become less effective as they age. [Learn more...](https://support.apple.com/en-us/106348)")
            }
            
            Section {
                LabeledContent("Maximum Capacity", value: "\(maximumCapacity)%")
            } footer: {
                Text("This is a measure of battery capacity relative to when it was new. Lower capacity may result in fewer hours of usage between charges.")
            }
            
            Section {
                Text("Peak Performance Capability")
            } footer: {
                Text("Built-in dynamic software and hardware systems will help counter performance impacts that may be noticed as your \(Device().model) battery chemically ages.")
            }
            
            Section {
                Toggle("Optimized Battery Charging", isOn: $optimizedBatteryChargingEnabled)
                    .onChange(of: optimizedBatteryChargingEnabled) {
                        showingOptimizeWarning = !optimizedBatteryChargingEnabled
                        temporaryOptimizePauseEnabled = false
                    }
            } footer: {
                Text("To reduce battery aging, \(Device().model) learns from your daily charging routines so it can wait to finish charging past 80% until you need to use it. \(temporaryOptimizePauseEnabled ? "Optimized Battery Charging is off until 6:00 AM. " : "")")
            }
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
                Button("**Turn Off Until Tomorrow**", role: .none, action: {
                    temporaryCleanPauseEnabled = true
                })
                Button("Turn Off", role: .none, action: {
                    cleanEnergyChargingEnabled = false
                })
                Button("Cancel", role: .none, action: {
                    cleanEnergyChargingEnabled = true
                })
            })
        }
    }
}

#Preview {
    NavigationStack {
        BatteryHealthChargingView()
    }
}
