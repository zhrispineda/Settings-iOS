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
    @State private var temporaryOptimizePauseEnabled = false
    @State private var temporaryCleanPauseEnabled = false
    @State private var cleanEnergyChargingEnabled = true
    @State private var showingCleanEnergyWarning = false
    let options = ["Optimized Battery Charging", "80% Limit", "None"]
    
    var body: some View {
        CustomList(title: "Charging Optimization") {
            Section(content: {
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        if selected == "Optimized Battery Charging" && option == "None" {
                            showingNoneWarning.toggle()
                        } else if selected == "None" && option == "Optimized Battery Charging" {
                            temporaryOptimizePauseEnabled = false
                        }
                        
                        selected = option
                    }, label: {
                        HStack {
                            Text(option)
                                .foregroundStyle(Color["Label"])
                            Spacer()
                            Image(systemName: selected == option ? "checkmark" : "")
                        }
                    })
                }
            }, footer: {
                switch selected {
                case "None":
                    if temporaryOptimizePauseEnabled {
                        Text("To reduce battery aging, \(DeviceInfo().model) learns from your daily charging routine so it can wait to finish charging past 80% until you need to use it. Optimized Battery Charging is off until 6:00 AM. [Learn more...](https://support.apple.com/en-us/108055)")
                    } else {
                        Text("Your \(DeviceInfo().model) will charge to its full capacity. [Learn more...](https://support.apple.com/en-us/108055)")
                    }
                case "80% Limit":
                    Text("Your \(DeviceInfo().model) will only charge to about 80%. [Learn more...](https://support.apple.com/en-us/108055)")
                default:
                    Text("To reduce battery aging, \(DeviceInfo().model) learns from your daily charging routine so it can wait to finish charging past 80% until you need to use it. [Learn more...](https://support.apple.com/en-us/108055)")
                }
            })
            .alert("Optimized Battery Charging helps reduce battery aging.", isPresented: $showingNoneWarning, actions: {
                Button("**Turn Off Until Tomorrow**", role: .none, action: {
                    temporaryOptimizePauseEnabled = true
                })
                Button("Turn Off", role: .none, action: {
                    temporaryOptimizePauseEnabled = false
                })
                Button("Cancel", role: .none, action: {
                    selected = "Optimized Battery Charging"
                })
            })
            
            Section(content: {
                Toggle("Clean Energy Charging", isOn: $cleanEnergyChargingEnabled)
                    .onChange(of: cleanEnergyChargingEnabled) {
                        showingCleanEnergyWarning = !cleanEnergyChargingEnabled
                        temporaryCleanPauseEnabled = false
                    }
            }, footer: {
                Text("In your region, \(DeviceInfo().model) will try to reduce your carbon footprint by selectively charging when lower carbon emission electricity is available. \(DeviceInfo().model) learns from your daily charging routine so it can reach full charge before you need to use it. \(temporaryCleanPauseEnabled ? "Clean Energy Charging is off until 6:00 AM. " : "")[Learn more...](https://support.apple.com/en-us/108068)")
            })
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
        ChargingOptimizationView()
    }
}
