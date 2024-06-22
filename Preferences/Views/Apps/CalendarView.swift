//
//  CalendarView.swift
//  Preferences
//
//  Settings > Apps > Calendar
//

import SwiftUI

struct CalendarView: View {
    var body: some View {
        CustomList(title: "Calendar") {
            SectionHelp(title: "Calendar", icon: "appleCalendar", description: "Add and manage your accounts to create and edit events in the Calendar app. [Learn more...](#)")
        }
    }
}

#Preview {
    NavigationStack {
        CalendarView()
    }
}
