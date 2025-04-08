//
//  RemindersView.swift
//  Preferences
//
//  Settings > Apps > Reminders
//

import SwiftUI

struct RemindersView: View {
    // Variables
    @State private var opacity = Double()
    @State private var frameY = Double()
    @State private var todayNotifications = true
    @State private var showingTimePicker = false
    @State private var selectedTime: Date = Date()
    @State private var showOverdue = true
    @State private var includeDueToday = false
    @State private var muteAssignedReminders = false
    @State private var showSuggestions = true
    let table = "RemindersSettings"
    
    var body: some View {
        CustomList(title: "Back") {
            Section {
                Placard(title: "Reminders".localize(table: table), icon: "appleReminders", description: "SETTINGS_PLACARD_DESCRIPTION_TEXT".localize(table: table, "#"), frameY: $frameY, opacity: $opacity)
                CustomNavigationLink("Reminders Accounts".localize(table: table), status: "1", destination: EmptyView())
            }
            
            PermissionsView(appName: "Reminders".localize(table: table), cellular: false, location: true, notifications: false, cellularEnabled: .constant(false))
            
            Section {
                CustomNavigationLink("Default List".localize(table: table), status: "Reminders".localize(table: table), destination: EmptyView())
            } footer: {
                Text("Reminders created outside of a specific list are placed in this list.", tableName: table)
            }
            
            Section {
                Toggle("Today Notifications".localize(table: table), isOn: $todayNotifications.animation())
                if todayNotifications {
                    Button {
                        showingTimePicker.toggle()
                    } label: {
                        HStack {
                            Text("Time", tableName: table)
                            Spacer()
                            Text(selectedTime, style: .time)
                                .onAppear {
                                    var components = DateComponents()
                                    components.hour = 9
                                    components.minute = 0
                                    
                                    if let newDate = Calendar.current.date(from: components) {
                                        selectedTime = newDate
                                    }
                                }
                        }
                    }
                    .containerShape(Rectangle())
                    .foregroundStyle(.primary)
                }
                if showingTimePicker {
                    DatePicker(
                        "Time".localize(table: table),
                        selection: $selectedTime,
                        displayedComponents: .hourAndMinute
                    )
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .frame(maxWidth: .infinity)
                }
            } header: {
                Text("All-Day Reminders", tableName: table)
            } footer: {
                Text("Set a time to show a notification when there are all-day reminders (with no specified time).", tableName: table)
            }
            
            Section {
                Toggle("Show as Overdue".localize(table: table), isOn: $showOverdue)
            } footer: {
                Text("Show all-day reminders as overdue starting on the next day.", tableName: table)
            }
            
            Section {
                Toggle("Include Due Today".localize(table: table), isOn: $includeDueToday)
            } header: {
                Text("Badge Count", tableName: table)
            } footer: {
                Text("Include both overdue and due today items in badge count.", tableName: table)
            }
            
            Section("Assigned Reminders".localize(table: table)) {
                Toggle("Mute Notifications", isOn: $muteAssignedReminders)
            }
            
            Section("When Adding Reminders".localize(table: table)) {
                Toggle("Show Suggestions".localize(table: table), isOn: $showSuggestions)
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Reminders", tableName: table)
                    .fontWeight(.semibold)
                    .font(.subheadline)
                    .opacity(frameY < 50.0 ? opacity : 0) // Only fade when passing the help section title at the top
            }
        }
    }
}

#Preview {
    NavigationStack {
        RemindersView()
    }
}
