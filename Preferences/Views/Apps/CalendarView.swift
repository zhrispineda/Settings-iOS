//
//  CalendarView.swift
//  Preferences
//
//  Settings > Apps > Calendar
//

import SwiftUI

struct CalendarView: View {
    // Variables
    @State private var weekNumbersEnabled = false
    @State private var weekViewStartsTodayEnabled = false
    @State private var showInviteeDeclinesEnabled = true
    @State private var locationSuggestionsEnabled = true
    
    var body: some View {
        CustomList(title: "Calendar") {
            Section {
                SectionHelp(title: "Calendar", icon: "appleCalendar", description: "Add and manage your accounts to create and edit events in the Calendar app. [Learn more...](https://support.apple.com/guide/\(Device().isPhone ? "iphone/set-up-mail-contacts-and-calendar-accounts-ipha0d932e96/ios"  : "ipad/set-up-mail-contacts-and-calendar-accounts-ipadee835d39/ipados"))")
                CustomNavigationLink(title: "Calendar Accounts", status: "1", destination: EmptyView())
            }
            
            PermissionsView(appName: "Calendar", cellular: false, location: false, notifications: false, cellularEnabled: .constant(false))
            
            LanguageView()
            
            Section {
                CustomNavigationLink(title: "Time Zone Override", status: "Off", destination: EmptyView())
                CustomNavigationLink(title: "Alternate Calendars", status: "Off", destination: EmptyView())
                Toggle("Week Numbers", isOn: $weekNumbersEnabled)
                Toggle("Week View Starts On Today", isOn: $weekViewStartsTodayEnabled)
                Toggle("Show Invitee Declines", isOn: $showInviteeDeclinesEnabled)
                if !UIDevice.isSimulator {
                    CustomNavigationLink(title: "Sync", status: "All Events", destination: EmptyView())
                }
                NavigationLink("Default Alert Times") {}
                CustomNavigationLink(title: "Duration for New Events", status: "1 hour", destination: EmptyView())
                NavigationLink("Start Week On") {}
                //CustomNavigationLink(title: "Default Calendar", status: "Personal", destination: EmptyView())
                Toggle("Location Suggestions", isOn: $locationSuggestionsEnabled)
            }
        }
    }
}

#Preview {
    NavigationStack {
        CalendarView()
    }
}
