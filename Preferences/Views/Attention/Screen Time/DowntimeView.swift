//
//  DowntimeView.swift
//  Preferences
//
//  Settings > Screen Time > Downtime
//

import SwiftUI

struct DowntimeView: View {
    // Variables
    @State private var downtimeEnabled = false
    @State private var scheduledEnabled = false
    @State private var selected = "DeviceDowntimeEveryDaySpecifierName"
    let options = ["DeviceDowntimeEveryDaySpecifierName", "DeviceDowntimeCustomizeDaysSpecifierName"]
    let days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    let table = "ScreenTimeSettingsUI"
    
    var body: some View {
        CustomList(title: "AppAndWebsiteActivityEDUDowntimeTitle".localize(table: table)) {
            Section {} footer: {
                Text("DeviceDowntimeTitleFooterText", tableName: table)
            }
            
            Section {
                Button(downtimeEnabled ? (scheduledEnabled ? "DeviceDowntimeDisableButtonWithScheduleName".localize(table: table) : "DeviceDowntimeDisableButtonWithoutScheduleName".localize(table: table)) : scheduledEnabled ? "DeviceDowntimeEnableButtonWithScheduleName".localize(table: table) : "DeviceDowntimeEnableButtonWithoutScheduleName".localize(table: table)) {
                    downtimeEnabled.toggle()
                }
                .tint(downtimeEnabled ? .red : .accent)
            } footer: {
                Text(downtimeEnabled ? (scheduledEnabled ? "DeviceDowntimeDisableButtonLocalUserWithScheduleFooter".localize(table: table) : "DeviceDowntimeDisableButtonLocalUserWithoutScheduleFooter".localize(table: table)) : scheduledEnabled ? "DeviceDowntimeEnableButtonUnblockedUserWithScheduleFooter".localize(table: table) : "DeviceDowntimeEnableButtonUnblockedUserWithoutScheduleFooter".localize(table: table))
            }
            
            Section {
                Toggle("DeviceDowntimeScheduledSpecifierName".localize(table: table), isOn: $scheduledEnabled)
            } footer: {
                Text("DeviceDowntimeScheduledFooterText", tableName: table)
            }
            
            if scheduledEnabled {
                Picker("", selection: $selected) {
                    ForEach(options, id: \.self) {
                        Text($0.localize(table: table))
                    }
                }
                .pickerStyle(.inline)
                
                Section {
                    if selected == "DeviceDowntimeEveryDaySpecifierName" {
                        Button {} label: {
                            CustomNavigationLink("AllowanceTimeSpecifierName".localize(table: table), status: "10:00 PM–7:00 AM", destination: EmptyView())
                                .foregroundStyle(Color["Label"])
                        }
                    } else {
                        ForEach(days, id: \.self) { day in
                            Button {} label: {
                                CustomNavigationLink(day, status: "10:00 PM–7:00 AM", destination: EmptyView())
                                    .foregroundStyle(Color["Label"])
                            }
                        }
                    }
                } footer: {
                    Text("DeviceDowntimeScheduleFooterTextLocal", tableName: table)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        DowntimeView()
    }
}
