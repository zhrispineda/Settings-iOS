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
    @State private var ratingsPhotosEnabled = true
    @State private var showRatingsPhotoSuggestions = true
    @State private var allowPhotoProvidersUse = false
    let options = ["Driving", "Walking", "Transit", "Cycling"]
    
    var body: some View {
        CustomList(title: "Maps", topPadding: true) {
            if UIDevice.IsSimulator {
                PermissionsView(appName: "Maps", background: true, cellular: false, location: false, notifications: false, cellularEnabled: .constant(true))
            } else {
                PermissionsView(appName: "Maps", background: true, cellularEnabled: .constant(true))
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
            
            Section("Directions") {
                NavigationLink("Driving", destination: DrivingView())
                NavigationLink("Walking", destination: WalkingView())
                NavigationLink("Transit", destination: TransitView())
                NavigationLink("Cycling", destination: CyclingView())
            }
            
            if !UIDevice.IsSimulator && UIDevice.iPhone {
                Section {
                    NavigationLink("Spoken Directions") {}
                }
            }
            
            Section("Climate") {
                Toggle("Air Quality Index", isOn: $airQualityIndexEnabled)
                Toggle("Weather Conditions", isOn: $weatherConditionsEnabled)
            }
            
            Section {
                Toggle("Always in English", isOn: $alwaysEnglishEnabled)
            } header: {
                Text("Map Labels")
            }
            
            if !UIDevice.IsSimulator {
                Section {
                    Toggle("Ratings and Photos", isOn: $ratingsPhotosEnabled)
                    Toggle("Show Ratings and Photos Suggestions", isOn: $showRatingsPhotoSuggestions)
                } header: {
                    Text("Contribute to Maps")
                } footer: {
                    Text("[See how your data is managed...](#)")
                }
                
                Section {
                    Toggle("Allow Photo Providers to Use Your Photos", isOn: $allowPhotoProvidersUse)
                } header: {
                    Text("Photo Use")
                } footer: {
                    Text("Allow companies that provide photos to Maps to use the photos that you add to Maps in their own products and services. Photos include their locations but not your identity. If you turn this off, photo providers may no longer use your photos, but this may take a few days to apply.")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        MapsView()
    }
}
