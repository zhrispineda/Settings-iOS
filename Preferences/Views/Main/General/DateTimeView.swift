//
//  DateTimeView.swift
//  Preferences
//
//  Settings > General > Date & Time
//

import SwiftUI

struct DateTimeView: View {
    @State private var twentyFourHourTime = false
    @State private var showAmPmStatus = true
    @State private var showDateStatus = true
    @State private var automaticTime = true
    @State private var showingDatePicker = false
    @State private var selectedDay = Date()
    @State private var selectedTime = Date()
    let path = "/System/Library/PreferenceBundles/DateAndTime.bundle"
    
    var body: some View {
        CustomList(title: "Date & Time".localized(path: path)) {
            Section {
                Toggle("24-Hour Time".localized(path: path), isOn: $twentyFourHourTime)
                if UIDevice.iPad {
                    Toggle("Show AM/PM in Status Bar".localized(path: path), isOn: $showAmPmStatus)
                    Toggle("Show Date in Status Bar".localized(path: path), isOn: $showDateStatus)
                }
            }
            
            Section {
                Toggle("Set Automatically".localized(path: path), isOn: $automaticTime)
                    .onChange(of: automaticTime) {
                        showingDatePicker = false
                    }
                if automaticTime {
                    LabeledContent("Time Zone".localized(path: path), value: "Cupertino")
                } else {
                    SettingsLink("Time Zone".localized(path: path), status: "Cupertino", destination: EmptyView())
                    HStack {
                        Spacer()
                        DatePicker(
                                "Selected Date",
                                selection: $selectedDay,
                                displayedComponents: [.date]
                            )
                        .datePickerStyle(.compact)
                        .labelsHidden()
                        DatePicker(
                                "Selected Time",
                                selection: $selectedTime,
                                displayedComponents: [.hourAndMinute]
                            )
                        .datePickerStyle(.compact)
                        .labelsHidden()
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        DateTimeView()
    }
}
