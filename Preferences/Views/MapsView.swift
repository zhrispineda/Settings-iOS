//
//  MapsView.swift
//  Preferences
//
//  Settings > Maps
//

import SwiftUI

struct MapsView: View {
    // Variables
    @State private var backgroundAppRefreshEnabled = true
    @State private var selected = "Driving"
    @State private var airQualityIndexEnabled = true
    @State private var weatherConditionsEnabled = true
    @State private var alwaysEnglishEnabled = true
    let options = ["Driving", "Walking", "Transit", "Cycling"]
    
    var body: some View {
        CustomList(title: "Maps") {
            Section(content: {
                SettingsLink(icon: "applesiri", id: "Siri & Search", content: {})
                Toggle("Background App Refresh", isOn: $backgroundAppRefreshEnabled)
            }, header: {
                Text("Allow Maps to Access")
            }, footer: {
                Text("[About Apple Maps & Privacy...](#)")
            })
            
            Section(content: {
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        selected = option
                    }, label: {
                        HStack {
                            Text(option)
                                .foregroundStyle(Color(UIColor.label))
                            Spacer()
                            Image(systemName: "\(selected == option ? "checkmark" : "")")
                        }
                    })
                }
            }, header: {
                Text("Preferred Type of Travel")
            }, footer: {
                Text("When available, this transportation type will be used to get directions and to estimate your travel time.")
            })
            
            Section(content: {
                NavigationLink("Driving", destination: {})
                NavigationLink("Walking", destination: {})
                NavigationLink("Transit", destination: {})
                NavigationLink("Cycling", destination: {})
            }, header: {
                Text("Directions")
            })
            
            Section(content: {
                Toggle("Air Quality Index", isOn: $airQualityIndexEnabled)
                Toggle("Weather Conditions", isOn: $weatherConditionsEnabled)
            }, header: {
                Text("Climate")
            })
            
            Section(content: {
                Toggle("Always in English", isOn: $alwaysEnglishEnabled)
            }, header: {
                Text("Map Labels")
            })
        }
    }
}

#Preview {
    MapsView()
}
