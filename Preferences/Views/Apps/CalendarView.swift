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
    @State private var opacity: Double = 0
    @State private var frameY: Double = 0
    let table = "MobileCalSettings"
    
    var body: some View {
        CustomList(title: "CalendarSettingsPlacard_Calendar".localize(table: table)) {
            Section {
                Placard(title: "CalendarSettingsPlacard_Calendar".localize(table: table), icon: "appleCalendar", description: "Add or remove accounts, manage Siri & Search, and customize how your calendar appears. [Learn more…](%@)".localize(table: table, UIDevice.iPhone ? "iphone/set-up-mail-contacts-and-calendar-accounts-ipha0d932e96/ios" : "ipad/set-up-mail-contacts-and-calendar-accounts-ipadee835d39/ipados"), frameY: $frameY, opacity: $opacity)
                CustomNavigationLink(title: "Calendar Accounts".localize(table: table), status: "1", destination: EmptyView())
            }
            
            PermissionsView(appName: "CalendarSettingsPlacard_Calendar".localize(table: table), cellular: false, location: false, notifications: false, cellularEnabled: .constant(false))
            
            //LanguageView()
            
            Section {
                CustomNavigationLink(title: "Time Zone Override".localize(table: table), status: "Off".localize(table: table), destination: EmptyView())
                CustomNavigationLink(title: "Alternate Calendars".localize(table: table), status: "Alternate Calendar Off".localize(table: table), destination: EmptyView())
                Toggle("Week Numbers".localize(table: table), isOn: $weekNumbersEnabled)
                Toggle("Week View Starts On Today".localize(table: table), isOn: $weekViewStartsTodayEnabled)
                Toggle("Show Invitee Declines".localize(table: table), isOn: $showInviteeDeclinesEnabled)
                if !UIDevice.IsSimulator {
                    CustomNavigationLink(title: "Sync Specifier Name".localize(table: table), status: "No Limit".localize(table: table), destination: EmptyView())
                }
                NavigationLink("Default Alert Times".localize(table: table)) {}
                CustomNavigationLink(title: "Duration for New Events".localize(table: table), status: "1 hour", destination: EmptyView())
                NavigationLink("Start Week On".localize(table: table)) {}
                //CustomNavigationLink(title: "Default Calendar", status: "Personal", destination: EmptyView())
                Toggle("Location Suggestions".localize(table: table), isOn: $locationSuggestionsEnabled)
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("CalendarSettingsPlacard_Calendar".localize(table: table))
                    .fontWeight(.semibold)
                    .font(.subheadline)
                    .opacity(frameY < 50.0 ? opacity : 0) // Only fade when passing the help section title at the top
            }
        }
    }
}

#Preview {
    NavigationStack {
        CalendarView()
    }
}
