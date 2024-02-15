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
                CustomNavigationLink(title: "Region", status: "United States", destination: EmptyView())
                CustomNavigationLink(title: "Calendar", status: "Gregorian", destination: EmptyView())
                CustomNavigationLink(title: "Temperature", status: "°F", destination: EmptyView())
                CustomNavigationLink(title: "Measurement System", status: "US", destination: EmptyView())
                CustomNavigationLink(title: "First Day of Week", status: "Sunday", destination: EmptyView())
                CustomNavigationLink(title: "Date Format", status: "8/19/24", destination: EmptyView())
                CustomNavigationLink(title: "Number Format", status: "1,234,567.89", destination: EmptyView())
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
    LanguageRegionView()
}
