//
//  DateTimeView.swift
//  Preferences
//
//  Settings > General > Date & Time
//

import SwiftUI

struct DateTimeView: View {
    // Variables
    @State private var twentyFourHourTime = false
    @State private var showAmPmStatus = true
    @State private var showDateStatus = true
    @State private var automaticTime = true
    @State private var showingDatePicker = false
    @State private var selectedDay: Date = Date()
    @State private var selectedTime: Date = Date()
    let table = "Date & Time"
    
    var body: some View {
        CustomList(title: "DATE_TIME_TITLE".localize(table: table)) {
            Section {
                Toggle("24-Hour Time".localize(table: table), isOn: $twentyFourHourTime)
                if UIDevice.iPad {
                    Toggle("SHOW_AMPM_IN_STATUS_BAR".localize(table: table), isOn: $showAmPmStatus)
                    Toggle("SHOW_DATE_IN_STATUS_BAR".localize(table: table), isOn: $showDateStatus)
                }
            }
            
            Section {
                Toggle("SET_AUTOMATICALLY".localize(table: table), isOn: $automaticTime)
                    .onChange(of: automaticTime) {
                        showingDatePicker = false
                    }
                if automaticTime {
                    LabeledContent("TIME_ZONE".localize(table: table), value: "Cupertino")
                } else {
                    SettingsLink("TIME_ZONE".localize(table: table), status: "Cupertino", destination: EmptyView())
                    HStack {
                        Spacer()
                        Text(selectedDay.formatted(date: .abbreviated, time: .omitted))
                        Spacer()
                        Text(selectedTime, style: .time)
                    }
                    .foregroundStyle(.blue)
                    .contentShape(Rectangle())
                    .frame(height: 20)
                    .onTapGesture {
                        withAnimation {
                            showingDatePicker = true
                        }
                    }
                    if showingDatePicker {
                        DatePicker(
                            "Selected Date",
                            selection: $selectedDay,
                            displayedComponents: .date
                        )
                        .datePickerStyle(.graphical)
                        .listRowSeparator(.hidden)
                        DatePicker("Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                            .listRowSeparator(.hidden)
                            .offset(y: -5)
                            .fontWeight(.semibold)
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
