//
//  CalendarTypeView.swift
//  Preferences
//
//  Settings > General > Language & Region > Calendar
//

import SwiftUI

struct CalendarTypeView: View {
    // Variables
    @State private var selected = "Gregorian"
    let options = ["Gregorian", "Japanese", "Buddhist"]
    let table = "InternationalSettings"
    
    var body: some View {
        CustomList(title: "CALENDAR".localize(table: table), topPadding: true) {
            Section("CALENDAR".localize(table: table)) {
                Picker("CALENDAR".localize(table: table), selection: $selected) {
                    ForEach(options, id: \.self) { calendar in
                        Text(calendar)
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            }
        }
    }
}

#Preview {
    NavigationStack {
        CalendarTypeView()
    }
}
