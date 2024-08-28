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
    @State private var automaticTime = true
    @State private var showingDatePicker = false
    @State private var selectedDay: Date = Date()
    @State private var selectedTime: Date = Date()
    
    var body: some View {
        CustomList(title: "Date & Time") {
            Section {
                Toggle("24-Hour Time", isOn: $twentyFourHourTime)
            }
            
            Section {
                Toggle("Set Automatically", isOn: $automaticTime)
                    .onChange(of: automaticTime) {
                        showingDatePicker = false
                    }
                if automaticTime {
                    LabeledContent("Time Zone", value: "Cupertino")
                } else {
                    CustomNavigationLink(title: "Time Zone", status: "Cupertino", destination: EmptyView())
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
                        DatePicker("**Time**", selection: $selectedTime, displayedComponents: .hourAndMinute)
                            .listRowSeparator(.hidden)
                            .offset(y: -5)
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
