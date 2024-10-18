//
//  LanguageRegionView.swift
//  Preferences
//
//  Settings > General > Language & Region
//

import SwiftUI

struct LanguageRegionView: View {
    // Variables
    @State private var languages = ["English"]
    @State private var liveTextEnabled = true
    let table = "InternationalSettings"
    
    var body: some View {
        CustomList(title: "INTERNATIONAL".localize(table: table), topPadding: true) {
            Section {
                ForEach($languages, id: \.self, editActions: .move) { $lang in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(lang)
                            if UIDevice.iPhone {
                                Text("DEVICE_LANGUAGE_IPHONE", tableName: table)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            } else if UIDevice.iPad {
                                Text("DEVICE_LANGUAGE_IPAD", tableName: table)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        Spacer()
                        Image(systemName: "line.3.horizontal")
                            .imageScale(.large)
                            .foregroundStyle(.tertiary)
                    }
                }
                Button("ADD_PREFERRED_LANGUAGE".localize(table: table)) {}
            } header: {
                Text("PREFERRED_LANGUAGES", tableName: table)
            } footer: {
                Text("PREFERRED_LANGUAGE_DESCRIPTION", tableName: table)
            }
            
            Section {
                Button {} label: {
                    HStack {
                        Text("LOCALE", tableName: table)
                        Spacer()
                        Text("United States")
                            .foregroundStyle(.secondary)
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.tertiary)
                            .imageScale(.small)
                            .fontWeight(.medium)
                    }
                    .foregroundStyle(Color["Label"])
                }
                CustomNavigationLink(title: "CALENDAR".localize(table: table), status: "Gregorian", destination: CalendarTypeView())
                CustomNavigationLink(title: "TEMPERATURE_UNIT".localize(table: table), status: "°F".localize(table: table), destination: SelectOptionList(title: "TEMPERATURE_UNIT".localize(table: table), options: ["Celsius (°C)".localize(table: table), "Fahrenheit (°F)".localize(table: table)], selected: "Fahrenheit (°F)".localize(table: table)))
                CustomNavigationLink(title: "MEASUREMENT_SYSTEM".localize(table: table), status: "MEASUREMENT_US".localize(table: table), destination: SelectOptionList(title: "MEASUREMENT_SYSTEM".localize(table: table), options: ["MEASUREMENT_METRIC".localize(table: table), "MEASUREMENT_US".localize(table: table), "MEASUREMENT_UK".localize(table: table)], selected: "MEASUREMENT_US".localize(table: table)))
                CustomNavigationLink(title: "FIRST_WEEKDAY".localize(table: table), status: "Sunday", destination: SelectOptionList(title: "FIRST_WEEKDAY".localize(table: table), options: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"], selected: "Sunday"))
                CustomNavigationLink(title: "DATE_FORMAT".localize(table: table), status: "8/19/24", destination: DateFormatView())
                CustomNavigationLink(title: "NUMBER_FORMAT".localize(table: table), status: "1,234,567.89", destination: SelectOptionList(title: "NUMBER_FORMAT".localize(table: table), options: ["1,234,567.89", "1.234.567,89", "1234567.89", "1 234 567,89"], selected: "1,234,567.89"))
            }
            
            Section {
                Toggle("LIVE_TEXT".localize(table: table), isOn: $liveTextEnabled)
            } footer: {
                Text("LIVE_TEXT_FOOTER", tableName: table)
            }
            
            Section {
                VStack(alignment: .center) {
                    Text("EXAMPLE".localize(table: table))
                        .padding(.bottom, 5)
                    Text("12:34 AM")
                    Text("Monday, August 19, 2024")
                    Text("$12,345.67\t4,567.90")
                }
                .frame(maxWidth: .infinity)
                .listRowBackground(Color.clear)
            }
        }
    }
}

#Preview {
    NavigationStack {
        LanguageRegionView()
    }
}
