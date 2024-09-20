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
    
    var body: some View {
        CustomList(title: "Calendar", topPadding: true) {
            Section("Calendar") {
                Picker("Calendar", selection: $selected) {
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
