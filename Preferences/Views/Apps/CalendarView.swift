//
//  CalendarView.swift
//  Preferences
//
//  Settings > Apps > Calendar
//

import SwiftUI

struct CalendarView: View {
    @State private var weekNumbersEnabled = false
    @State private var weekViewStartsTodayEnabled = false
    @State private var showInviteeDeclinesEnabled = true
    @State private var locationSuggestionsEnabled = true
    @State private var opacity: Double = 0
    @State private var frameY: Double = 0
    @State private var showingHelpSheet = false
    let path = "/System/Library/PreferenceBundles/MobileCalSettings.bundle"
    let table = "MobileCalSettings"
    
    var body: some View {
        CustomList(title: "CalendarSettingsPlacard_Calendar".localized(path: path, table: table)) {
            Section {
                Placard(title: "CalendarSettingsPlacard_Calendar".localized(path: path, table: table), icon: "com.apple.mobilecal", description: "Add or remove accounts, manage Siri & Search, and customize how your calendar appears. [Learn more…](%@)".localized(path: path, table: table, "pref://helpkit"), frameY: $frameY, opacity: $opacity)
                Button("ADD_ACCOUNT".localized(path: "/System/Library/PrivateFrameworks/Preferences.framework", table: "PSSystemPolicy")) {}
            }
            
            PermissionsView(appName: "CalendarSettingsPlacard_Calendar".localized(path: path, table: table), cellular: false, location: false, notifications: false, cellularEnabled: .constant(false))
            
            Section {
                SettingsLink("Time Zone Override".localized(path: path, table: table), status: "Off".localized(path: path, table: table), destination: EmptyView())
                SettingsLink("Alternate Calendars".localized(path: path, table: table), status: "Alternate Calendar Off".localized(path: path, table: table), destination: EmptyView())
                Toggle("Week Numbers".localized(path: path, table: table), isOn: $weekNumbersEnabled)
                Toggle("Week View Starts On Today".localized(path: path, table: table), isOn: $weekViewStartsTodayEnabled)
                Toggle("Show Invitee Declines".localized(path: path, table: table), isOn: $showInviteeDeclinesEnabled)
                if !UIDevice.IsSimulator {
                    SettingsLink("Sync Specifier Name".localized(path: path, table: table), status: "No Limit".localized(path: path, table: table), destination: EmptyView())
                }
                NavigationLink("Default Alert Times".localized(path: path, table: table)) {}
                SettingsLink("Duration for New Events".localized(path: path, table: table), status: "1 hour", destination: EmptyView())
                NavigationLink("Start Week On".localized(path: path, table: table)) {}
                Toggle("Location Suggestions".localized(path: path, table: table), isOn: $locationSuggestionsEnabled)
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("CalendarSettingsPlacard_Calendar".localized(path: path, table: table))
                    .fontWeight(.semibold)
                    .font(.subheadline)
                    .opacity(frameY < 50.0 ? opacity : 0)
            }
        }
        .onOpenURL { url in
            if url.absoluteString == "pref://helpkit" {
                showingHelpSheet = true
            }
        }
        .sheet(isPresented: $showingHelpSheet) {
            HelpKitView(topicID: UIDevice.iPhone ? "ipha0d932e96" : "ipadee835d39")
                .ignoresSafeArea(edges: .bottom)
                .interactiveDismissDisabled()
        }
    }
}

#Preview {
    NavigationStack {
        CalendarView()
    }
}
