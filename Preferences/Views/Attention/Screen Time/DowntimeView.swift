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
    @State private var selected = "Every Day"
    let options = ["Every Day", "Customize Days"]
    let days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
    var body: some View {
        CustomList(title: "Downtime") {
            Section {} footer: {
                Text("During downtime, only apps that you choose to allow and phone calls will be available.")
            }
            
            Section {
                Button(downtimeEnabled ? (scheduledEnabled ? "Ignore Downtime Until Schedule" : "Turn Off Downtime") : "Turn On Downtime Until \(scheduledEnabled ? "Schedule" : "Tomorrow")") {
                    downtimeEnabled.toggle()
                }
                .tint(downtimeEnabled ? .red : .accent)
            } footer: {
                Text(downtimeEnabled ? (scheduledEnabled ? "Give more screen time without adjusting your schedule." : "Resume using your device.") : "Downtime will be turned on until \(scheduledEnabled ? "schedule resumes" : "midnight").")
            }
            
            Section {
                Toggle("Scheduled", isOn: $scheduledEnabled)
            } footer: {
                Text("Scheduled turns on downtime for the time period you select. A downtime reminder will appear five minutes before downtime.")
            }
            
            if scheduledEnabled {
                Picker("", selection: $selected) {
                    ForEach(options, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.inline)
                
                Section {
                    if selected == "Every Day" {
                        Button {} label: {
                            CustomNavigationLink(title: "Time", status: "10:00 PM–7:00 AM", destination: EmptyView())
                                .foregroundStyle(Color["Label"])
                        }
                    } else {
                        ForEach(days, id: \.self) { day in
                            Button {} label: {
                                CustomNavigationLink(title: day, status: "10:00 PM–7:00 AM", destination: EmptyView())
                                    .foregroundStyle(Color["Label"])
                            }
                        }
                    }
                } footer: {
                    Text("Downtime will apply to this device. A downtime reminder will appear five minutes before downtime begins.")
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
