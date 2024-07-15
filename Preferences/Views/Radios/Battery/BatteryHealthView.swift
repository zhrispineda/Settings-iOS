//
//  BatteryHealthView.swift
//  Preferences
//
//  Settings > Battery > Battery Health
//

import SwiftUI

struct BatteryHealthView: View {
    @State private var maximumCapacity = 100
    @State private var eightyPercentLimitEnabled = false
    
    var body: some View {
        CustomList(title: "Battery Health") {
            Section {
                LabeledContent("Battery Health", value: "Normal")
            } footer: {
                Text("This \(UIDevice.current.model) battery is performing as expected. [About Battery & Warranty...](#)")
            }
            
            Section {
                LabeledContent("Maximum Capacity", value: "\(maximumCapacity)%")
            } footer: {
                Text("This is a measure of battery capacity relative to when it was new. Lower capacity may result in fewer hours of usage between charges.")
            }
            
            Section {
                LabeledContent("Cycle Count", value: "0")
            } footer: {
                Text("This is the number of times \(UIDevice.current.model) has used your battery's capacity. [Learn more...](https://www.apple.com/batteries/why-lithium-ion/)")
            }
            
            if UIDevice.iPad {
                Section {
                    Toggle("80% Limit", isOn: $eightyPercentLimitEnabled)
                } footer: {
                    Text("iPad will only charge to about 80%. [Learn more...](https://support.apple.com/en-us/118418)")
                }
            }
            
            Section {
                LabeledContent("Manufacture Date", value: "August 2023")
                LabeledContent("First Use", value: "September 2023")
            }
        }
    }
}

#Preview {
    NavigationStack {
        BatteryHealthView()
    }
}
