//
//  MapsView.swift
//  Preferences
//
//  Settings > Apps > Maps
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
            Section {
                SettingsLink(icon: "appleSiri", id: "Siri & Search", content: {
                    SiriDetailView(appName: "Maps")
                })
                IconToggle(enabled: $backgroundAppRefreshEnabled, color: .gray, icon: "gear", title: "Background App Refresh")
            } header: {
                Text("Allow Maps to Access")
            } footer: {
                Text("[About Apple Maps & Privacy...](#)")
            }
            
            Section {
                Picker("", selection: $selected) {
                    ForEach(options, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } header: {
                Text("Preferred Type of Travel")
            } footer: {
                Text("When available, this transportation type will be used to get directions and to estimate your travel time.")
            }
            
            Section {
                NavigationLink("Driving", destination: DrivingView())
                NavigationLink("Walking", destination: WalkingView())
                NavigationLink("Transit", destination: TransitView())
                NavigationLink("Cycling", destination: CyclingView())
            } header: {
                Text("Directions")
            }
            
            Section {
                Toggle("Air Quality Index", isOn: $airQualityIndexEnabled)
                Toggle("Weather Conditions", isOn: $weatherConditionsEnabled)
            } header: {
                Text("Climate")
            }
            
            Section {
                Toggle("Always in English", isOn: $alwaysEnglishEnabled)
            } header: {
                Text("Map Labels")
            }
        }
    }
}

#Preview {
    NavigationStack {
        MapsView()
    }
}
