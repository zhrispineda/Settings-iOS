//
//  RemindersView.swift
//  Preferences
//
//  Settings > Apps > Reminders
//

import SwiftUI

struct RemindersView: View {
    @State private var opacity = Double()
    @State private var frameY = Double()
    @State private var todayNotifications = true
    @State private var showingTimePicker = false
    @State private var selectedTime: Date = Date()
    @State private var showOverdue = true
    @State private var includeDueToday = false
    @State private var muteAssignedReminders = false
    @State private var showSuggestions = true
    @State private var showingHelpSheet = false
    let path = "/System/Library/PreferenceBundles/RemindersSettings.bundle"
    
    var body: some View {
        CustomList(title: "Back") {
            Section {
                Placard(title: "Reminders".localized(path: path), icon: "com.apple.reminders", description: "SETTINGS_PLACARD_DESCRIPTION_TEXT".localized(path: path, "pref://helpkit"), frameY: $frameY, opacity: $opacity)
                SettingsLink("Reminders Accounts".localized(path: path), status: "1", destination: EmptyView())
            }
            
            PermissionsView(appName: "Reminders".localized(path: path), cellular: false, location: true, notifications: false, cellularEnabled: .constant(false))
            
            Section {
                SettingsLink("Default List".localized(path: path), status: "Reminders".localized(path: path), destination: EmptyView())
            } footer: {
                Text("Reminders created outside of a specific list are placed in this list.".localized(path: path))
            }
            
            Section {
                Toggle("Today Notifications".localized(path: path), isOn: $todayNotifications.animation())
                if todayNotifications {
                    Button {
                        showingTimePicker.toggle()
                    } label: {
                        HStack {
                            Text("Time".localized(path: path))
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
                        "Time".localized(path: path),
                        selection: $selectedTime,
                        displayedComponents: .hourAndMinute
                    )
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .frame(maxWidth: .infinity)
                }
            } header: {
                Text("All-Day Reminders".localized(path: path))
            } footer: {
                Text("Set a time to show a notification when there are all-day reminders (with no specified time).".localized(path: path))
            }
            
            Section {
                Toggle("Show as Overdue".localized(path: path), isOn: $showOverdue)
            } footer: {
                Text("Show all-day reminders as overdue starting on the next day.".localized(path: path))
            }
            
            Section {
                Toggle("Include Due Today".localized(path: path), isOn: $includeDueToday)
            } header: {
                Text("Badge Count".localized(path: path))
            } footer: {
                Text("Include both overdue and due today items in badge count.".localized(path: path))
            }
            
            Section("Assigned Reminders".localized(path: path)) {
                Toggle("Mute Notifications", isOn: $muteAssignedReminders)
            }
            
            Section("When Adding Reminders".localized(path: path)) {
                Toggle("Show Suggestions".localized(path: path), isOn: $showSuggestions)
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Reminders".localized(path: path))
                    .fontWeight(.semibold)
                    .font(.subheadline)
                    .opacity(frameY < 50.0 ? opacity : 0)
            }
        }
        .onOpenURL { url in
            if url.absoluteString == "pref://helpkit" {
                showingHelpSheet = true
            }
        }
        .sheet(isPresented: $showingHelpSheet) {
            HelpKitView(topicID: UIDevice.iPhone ? "f898416824ef" : "ipad3cd77052")
                .ignoresSafeArea(edges: .bottom)
                .interactiveDismissDisabled()
        }
    }
}

#Preview {
    NavigationStack {
        RemindersView()
    }
}
