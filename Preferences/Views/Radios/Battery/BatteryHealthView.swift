//
//  BatteryHealthView.swift
//  Preferences
//
//  Settings > Battery > Battery Health
//

import SwiftUI

struct BatteryHealthView: View {
    @AppStorage("ChargeLimitToggle") private var eightyPercentLimitEnabled = false
    @State private var maximumCapacity = "100%"
    @State private var showingSheet = false
    let cycleTable = "BatteryUI-lotx"
    let table = "BatteryUI"
    
    var body: some View {
        CustomList(title: "BATTERY_HEALTH_TITLE".localize(table: table)) {
            // Battery Health
            Section {
                LabeledContent("BATTERY_HEALTH_TITLE".localize(table: table), value: "NORMAL_STATE".localize(table: table))
            } footer: {
                LocalizedLink(UIDevice.iPhone ? "BATTERY_HEALTH_STATE_FOOTER_NORMAL_IPHONE" : "BATTERY_HEALTH_STATE_FOOTER_NORMAL_IPAD", table: table, link: "ABOUT_BATTERY_LINK", url: "pref://")
            }
            
            // Maximum Capacity
            Section {
                LabeledContent("MAXIMUM_CAPACITY_NAME".localize(table: table), value: maximumCapacity)
            } footer: {
                Text("MAXIMUM_CAPACITY_FOOTER_TEXT", tableName: table)
            }
            
            // Cycle Count
            Section {
                LabeledContent("CYCLE_COUNT_TITLE".localize(table: table), value: "0")
            } footer: {
                if UIDevice.iPhone {
                    Text(.init("\("CYCLE_COUNT_FOOTER_IPHONE".localize(table: table)) [\("LM_TEXT".localize(table: table))](\("CYCLE_COUNT_LINK".localize(table: table)))"))
                } else if UIDevice.iPad {
                    Text(.init("\("CYCLE_COUNT_FOOTER_IPAD".localize(table: table)) [\("LM_TEXT".localize(table: table))](\("CYCLE_COUNT_LINK".localize(table: table)))"))
                }
            }
            
            // iPad: 80% Charging Limit Toggle
            if UIDevice.iPad {
                Section {
                    Toggle("CHARGING_FIXED_LIMIT".localize(table: table, "80%"), isOn: $eightyPercentLimitEnabled)
                } footer: {
                    Text(.init("\("FIXED_FOOTER_IPAD".localize(table: cycleTable, "80%")) [\("LM_TEXT".localize(table: table))](\("LEARN_MORE_URL_IPAD".localize(table: cycleTable)))"))
                }
            }
            
            // Manufacture Date + First Use Dates
            Section {
                LabeledContent("MANUFACTURE_DATE_TITLE".localize(table: table), value: "UNKNOWN".localize(table: table))
                LabeledContent("FIRST_USE_TITLE".localize(table: table), value: "UNKNOWN".localize(table: table))
            }
        }
        .onOpenURL { url in
            if url.scheme == "pref" {
                showingSheet = true
            }
        }
        .sheet(isPresented: $showingSheet) {
            if UIDevice.iPhone {
                OnBoardingView(title: "BATTERY_WARRANTY_TITLE".localize(table: table), summary: "BATTERY_WARRANTY_P1_IPHONE".localize(table: table), footer: "BATTERY_WARRANTY_P2_IPHONE".localize(table: table, "80%", "1000", "[\("LM_TEXT".localize(table: table))](\("BW_LM_URL_2_IPHONE".localize(table: table)))"), secondFooter: "BATTERY_WARRANTY_P3".localize(table: table, "[\("LM_TEXT".localize(table: table))](\("BW_LM_URL_3".localize(table: table))"))
            } else if UIDevice.iPad {
                OnBoardingView(title: "BATTERY_WARRANTY_TITLE".localize(table: table), summary: "BATTERY_WARRANTY_P1_IPAD".localize(table: table), footer: "BATTERY_WARRANTY_P2_IPAD".localize(table: table, "80%", "1000", "[\("LM_TEXT".localize(table: table))](\("BW_LM_URL_2_IPHONE".localize(table: table)))"))
            }
        }
    }
}

#Preview {
    NavigationStack {
        BatteryHealthView()
    }
}
