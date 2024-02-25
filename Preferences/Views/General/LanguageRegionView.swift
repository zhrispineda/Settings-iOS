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
    
    var body: some View {
        CustomList(title: "Language & Region") {
            Section(content: {
                ForEach($languages, id: \.self, editActions: .move) { $lang in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(lang)
                            Text("\(DeviceInfo().model) Language")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        Image(systemName: "line.3.horizontal")
                            .imageScale(.large)
                            .foregroundStyle(.tertiary)
                    }
                }
                Button("Add Language...", action: {})
            }, header: {
                Text("Preferred Languages")
            }, footer: {
                Text("Apps and websites will use the first language in this list that they support.")
            })
            
            Section {
                Button(action: {}, label: {
                    HStack {
                        Text("Region")
                        Spacer()
                        Text("United States")
                            .foregroundStyle(.secondary)
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.tertiary)
                            .imageScale(.small)
                            .fontWeight(.medium)
                    }
                    .foregroundStyle(Color(UIColor.label))
                })
                Button(action: {}, label: {
                    HStack {
                        Text("Calendar")
                        Spacer()
                        Text("Gregorian")
                            .foregroundStyle(.secondary)
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.tertiary)
                            .imageScale(.small)
                            .fontWeight(.medium)
                    }
                    .foregroundStyle(Color(UIColor.label))
                })
                CustomNavigationLink(title: "Temperature", status: "°F", destination: SelectOptionList(title: "Temperature", options: ["Celsius (°C)", "Fahrenheit (°F)"], selected: "Fahrenheit (°F)"))
                CustomNavigationLink(title: "Measurement System", status: "US", destination: SelectOptionList(title: "Measurement System", options: ["Metric", "US", "UK"], selected: "US"))
                CustomNavigationLink(title: "First Day of Week", status: "Sunday", destination: SelectOptionList(title: "First Day of Week", options: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"], selected: "Sunday"))
                CustomNavigationLink(title: "Date Format", status: "8/19/24", destination: DateFormatView())
                CustomNavigationLink(title: "Number Format", status: "1,234,567.89", destination: SelectOptionList(title: "Number Format", options: ["1,234,567.89", "1.234.567,89", "1234567.89", "1 234 567,89"], selected: "1,234,567.89"))
            }
            
            Section(content: {
                Toggle("Live Text", isOn: $liveTextEnabled)
            }, footer: {
                Text("Select text in images to copy or taker action.")
            })
            
            Section {
                VStack(alignment: .center) {
                    Text("Region Format Example")
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
