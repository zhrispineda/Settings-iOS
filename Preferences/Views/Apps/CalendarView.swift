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
    
    var body: some View {
        CustomList(title: "Calendar") {
            Section {
                SectionHelp(title: "Calendar", icon: "appleCalendar", description: "Add and remove accounts, manage Siri & Search, and customize how your calendar appears. [Learn more...](https://support.apple.com/guide/\(UIDevice.iPhone ? "iphone/set-up-mail-contacts-and-calendar-accounts-ipha0d932e96/ios"  : "ipad/set-up-mail-contacts-and-calendar-accounts-ipadee835d39/ipados"))")
                    .overlay { // For calculating opacity of the principal toolbar item
                        GeometryReader { geo in
                            Color.clear
                                .onChange(of: geo.frame(in: .scrollView).minY) {
                                    frameY = geo.frame(in: .scrollView).minY
                                    opacity = frameY / -30
                                }
                        }
                    }
                CustomNavigationLink(title: "Calendar Accounts", status: "1", destination: EmptyView())
            }
            
            PermissionsView(appName: "Calendar", cellular: false, location: false, notifications: false, cellularEnabled: .constant(false))
            
            //LanguageView()
            
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
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Calendar")
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
