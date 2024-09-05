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
    
    var body: some View {
        CustomList(title: "Back") {
            Section {
                SectionHelp(title: "Reminders", icon: "appleReminders", description: "Add and remove accounts, manage Siri & Search, and customize how your reminders work. [Learn more...](https://support.apple.com/guide/\(UIDevice.current.model))")
                    .overlay { // For calculating opacity of the principal toolbar item
                        GeometryReader { geo in
                            Color.clear
                                .onChange(of: geo.frame(in: .scrollView).minY) {
                                    frameY = geo.frame(in: .scrollView).minY
                                    opacity = frameY / -30
                                }
                        }
                    }
                CustomNavigationLink(title: "Reminders Accounts", status: "1", destination: EmptyView())
            }
            
            PermissionsView(appName: "Reminders", cellular: false, location: true, notifications: false, cellularEnabled: .constant(false))
            
            Section {
                CustomNavigationLink(title: "Default List", status: "Reminders", destination: EmptyView())
            } footer: {
                Text("Reminders created outside of a specific list are placed in this list.")
            }
            
            Section {
                Toggle("Today Notifications", isOn: $todayNotifications.animation())
                if todayNotifications {
                    Button {
                        showingTimePicker.toggle()
                    } label: {
                        HStack {
                            Text("Time")
                                .foregroundStyle(Color["Label"])
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
                }
                if showingTimePicker {
                    DatePicker(
                        "Selected Time",
                        selection: $selectedTime,
                        displayedComponents: .hourAndMinute
                    )
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .frame(maxWidth: .infinity)
                }
            } header: {
                Text("All-Day Reminders")
            } footer: {
                Text("Set a time to show a notification when there are all-day reminders (with no specified time).")
            }
            
            Section {
                Toggle("Show as Overdue", isOn: $showOverdue)
            } footer: {
                Text("Show all-day reminders as overdue starting on the next day.")
            }
            
            Section {
                Toggle("Include Due Today", isOn: $includeDueToday)
            } header: {
                Text("Badge Count")
            } footer: {
                Text("Include both overdue and due today items in badge count.")
            }
            
            Section("Assigned Reminders") {
                Toggle("Mute Notifications", isOn: $muteAssignedReminders)
            }
            
            Section("When Adding Reminders") {
                Toggle("Show Suggestions", isOn: $showSuggestions)
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Reminders")
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
