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
                NavigationLink(destination: {}, label: {
                    HRowLabels(title: "Region", subtitle: "United States")
                })
                NavigationLink(destination: {}, label: {
                    HRowLabels(title: "Calendar", subtitle: "Gregorian")
                })
                NavigationLink(destination: {}, label: {
                    HRowLabels(title: "Temperature", subtitle: "°F")
                })
                NavigationLink(destination: {}, label: {
                    HRowLabels(title: "Measurement System", subtitle: "US")
                })
                NavigationLink(destination: {}, label: {
                    HRowLabels(title: "First Day of Week", subtitle: "Sunday")
                })
                NavigationLink(destination: {}, label: {
                    HRowLabels(title: "Date Format", subtitle: "8/19/24")
                })
                NavigationLink(destination: {}, label: {
                    HRowLabels(title: "Number Format", subtitle: "1,234,567.89")
                })
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
