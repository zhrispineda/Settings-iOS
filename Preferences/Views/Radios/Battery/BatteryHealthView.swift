//
//  BatteryHealthView.swift
//  Preferences
//
//  Settings > Battery > Battery Health
//

import SwiftUI

struct BatteryHealthView: View {
    @State private var maximumCapacity = "100%"
    @AppStorage("ChargeLimitToggle") private var eightyPercentLimitEnabled = false
    @State private var showingSheet = false
    let table = "BatteryUI"
    
    var body: some View {
        CustomList(title: "BATTERY_HEALTH_TITLE".localize(table: table)) {
            Section {
                LabeledContent("BATTERY_HEALTH_TITLE".localize(table: table), value: "NORMAL_STATE".localize(table: table))
            } footer: {
                LocalizedLink(UIDevice.iPhone ? "BATTERY_HEALTH_STATE_FOOTER_NORMAL_IPHONE" : "BATTERY_HEALTH_STATE_FOOTER_NORMAL_IPAD", table: table, link: "ABOUT_BATTERY_LINK", url: "pref://")
            }
            
            Section {
                LabeledContent("MAXIMUM_CAPACITY_NAME".localize(table: table), value: maximumCapacity)
                    .onAppear {
                        // Get battery capacity value
                        let answer = MGHelper.read(key: "f2DlVMUVcV+MeWs/g2ku+g") ?? "Unknown"
                        if answer == "101" {
                            maximumCapacity = "100%"
                        } else if answer != "Unknown" {
                            maximumCapacity = answer + "%"
                        }
                    }
            } footer: {
                Text("MAXIMUM_CAPACITY_FOOTER_TEXT", tableName: table)
            }
            
            Section {
                LabeledContent("CYCLE_COUNT_TITLE".localize(table: table), value: "0")
            } footer: {
                Text(UIDevice.iPhone ? "CYCLE_COUNT_FOOTER_IPHONE".localize(table: table) : "CYCLE_COUNT_FOOTER_IPAD".localize(table: table)) + Text(" ") + Text("[\("LM_TEXT".localize(table: table))](\("CYCLE_COUNT_LINK".localize(table: table)))")
            }
            
            if UIDevice.iPad {
                Section {
                    Toggle("CHARGING_FIXED_LIMIT".localize(table: table, "80%"), isOn: $eightyPercentLimitEnabled)
                } footer: {
                    Text("FIXED_FOOTER_IPAD".localize(table: table, "80%")) + Text(" ") + Text("[\("LM_TEXT".localize(table: table))](\(UIDevice.iPhone ? "BW_LM_URL_2_IPHONE".localize(table: table) : "BW_LM_URL_2_IPAD".localize(table: table)))")
                }
            }
            
            Section {
                LabeledContent("MANUFACTURE_DATE_TITLE".localize(table: table), value: UIDevice.iPhone ? "August 202\(UIDevice.AlwaysCaptureDepthCapability ? "4" : "3")" : "February 2024")
                LabeledContent("FIRST_USE_TITLE".localize(table: table), value: UIDevice.iPhone ? "September 202\(UIDevice.AlwaysCaptureDepthCapability ? "4" : "3")" : "May 2024")
            }
        }
        .onOpenURL { url in
            if url.scheme == "pref" {
                showingSheet = true
            }
        }
        .sheet(isPresented: $showingSheet) {
            OnBoardingView(table: "BatteryUI")
        }
    }
}

#Preview {
    NavigationStack {
        BatteryHealthView()
    }
}
