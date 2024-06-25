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
            Section {
                SectionHelp(title: "Calendar", icon: "appleCalendar", description: "Add and manage your accounts to create and edit events in the Calendar app. [Learn more...](#)")
                NavigationLink("Calendar Accounts", destination: {})
            }
            
            PermissionsView(appName: "Calendar", cellular: false, location: false, notifications: false, cellularEnabled: .constant(false))
            
            LanguageView()
        }
    }
}

#Preview {
    NavigationStack {
        CalendarView()
    }
}
