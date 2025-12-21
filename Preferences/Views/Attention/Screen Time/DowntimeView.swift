//
//  DowntimeView.swift
//  Preferences
//

import SwiftUI

/// View for Settings > Screen Time > Downtime
struct DowntimeView: View {
    @State private var downtimeEnabled = false
    @State private var scheduledEnabled = false
    @State private var selected = "DeviceDowntimeEveryDaySpecifierName"
    private let options = ["DeviceDowntimeEveryDaySpecifierName", "DeviceDowntimeCustomizeDaysSpecifierName"]
    private let days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    private let path = "/System/Library/PrivateFrameworks/ScreenTimeSettingsUI.framework"
    
    var body: some View {
        CustomList(title: "AppAndWebsiteActivityEDUDowntimeTitle".localized(path: path)) {
            Section {} footer: {
                Text("DeviceDowntimeTitleFooterText".localized(path: path))
            }
            
            Section {
                Button(
                    downtimeEnabled
                        ? (scheduledEnabled
                           ? "DeviceDowntimeDisableButtonWithScheduleName".localized(path: path)
                           : "DeviceDowntimeDisableButtonWithoutScheduleName".localized(path: path))
                        : scheduledEnabled
                            ? "DeviceDowntimeEnableButtonWithScheduleName".localized(path: path)
                            : "DeviceDowntimeEnableButtonWithoutScheduleName".localized(path: path)
                ) {
                    downtimeEnabled.toggle()
                }
                .tint(downtimeEnabled ? .red : .accentColor)
            } footer: {
                Text(
                    downtimeEnabled
                        ? (scheduledEnabled
                           ? "DeviceDowntimeDisableButtonLocalUserWithScheduleFooter".localized(path: path)
                           : "DeviceDowntimeDisableButtonLocalUserWithoutScheduleFooter".localized(path: path))
                        : scheduledEnabled
                            ? "DeviceDowntimeEnableButtonUnblockedUserWithScheduleFooter".localized(path: path)
                            : "DeviceDowntimeEnableButtonUnblockedUserWithoutScheduleFooter".localized(path: path)
                )
            }
            
            Section {
                Toggle("DeviceDowntimeScheduledSpecifierName".localized(path: path), isOn: $scheduledEnabled)
            } footer: {
                Text("DeviceDowntimeScheduledFooterText".localized(path: path))
            }
            
            if scheduledEnabled {
                Picker("", selection: $selected) {
                    ForEach(options, id: \.self) {
                        Text($0.localized(path: path))
                    }
                }
                .pickerStyle(.inline)
                
                Section {
                    if selected == "DeviceDowntimeEveryDaySpecifierName" {
                        Button {} label: {
                            SLink("AllowanceTimeSpecifierName".localized(path: path), status: "10:00 PM–7:00 AM") {}
                        }
                        .foregroundStyle(.primary)
                    } else {
                        ForEach(days, id: \.self) { day in
                            Button {} label: {
                                SLink(day, status: "10:00 PM–7:00 AM") {}
                            }
                            .foregroundStyle(.primary)
                        }
                    }
                } footer: {
                    Text("DeviceDowntimeScheduleFooterTextLocal".localized(path: path))
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
