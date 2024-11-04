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
    let options = ["Driving Transportation Mode Label [Settings]", "Walking Label [Settings]", "Transit Label [Settings]", "Cycling Label [Settings]"]
    let table = "MapsSettings"
    let axTable = "AXUILocalizedStrings"
    
    var body: some View {
        CustomList(title: "MAPS_CLIENT".localize(table: axTable), topPadding: true) {
            if UIDevice.IsSimulator {
                PermissionsView(appName: "MAPS_CLIENT".localize(table: axTable), background: true, cellular: false, location: false, notifications: false, cellularEnabled: .constant(true))
            } else {
                PermissionsView(appName: "MAPS_CLIENT".localize(table: axTable), background: true, cellularEnabled: .constant(true))
            }
            
            Section {
                Picker("Default Transportation Mode Title [Settings]", selection: $selected) {
                    ForEach(options, id: \.self) {
                        Text($0.localize(table: table))
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } header: {
                Text("Default Transportation Mode Title [Settings]", tableName: table)
            } footer: {
                Text("Default Transportation Mode Footer [Settings]", tableName: table)
            }
            
            Section("Directions Group Label [Settings]".localize(table: table)) {
                NavigationLink("Driving Group Title [Settings]".localize(table: table), destination: DrivingView())
                NavigationLink("Walking Label [Settings]".localize(table: table), destination: WalkingView())
                NavigationLink("Transit Label [Settings]".localize(table: table), destination: TransitView())
                NavigationLink("Cycling Label [Settings]".localize(table: table), destination: CyclingView())
            }
            
            if !UIDevice.IsSimulator && UIDevice.iPhone {
                Section {
                    NavigationLink("Spoken Directions Label [Settings]".localize(table: table)) {}
                }
            }
            
            Section("Climate Group Label [Settings]".localize(table: table)) {
                Toggle("Air Quality Index Switch Label [Settings]".localize(table: table), isOn: $airQualityIndexEnabled)
                Toggle("Weather Conditions Switch Label [Settings]".localize(table: table), isOn: $weatherConditionsEnabled)
            }
            
            Section {
                Toggle("Label Language Switch Label [Settings]".localize(table: table), isOn: $alwaysEnglishEnabled)
            } header: {
                Text("Label Language Group Title [Settings]".localize(table: table))
            }
            
            if !UIDevice.IsSimulator {
                Section {
                    Toggle("Ratings and Photos [Laguna Beach][Settings]".localize(table: table), isOn: $ratingsPhotosEnabled)
                    Toggle("Show Ratings and Photos Suggestions [Laguna Beach][Settings]".localize(table: table), isOn: $showRatingsPhotoSuggestions)
                } header: {
                    Text("Contribute to Maps [Settings]", tableName: table)
                } footer: {
                    Text("[See how your data is managed...](#)")
                }
                
                Section {
                    Toggle("Allow Photo Providers to Use Your Photos [Settings]".localize(table: table), isOn: $allowPhotoProvidersUse)
                } header: {
                    Text("Photo Use [Settings]", tableName: table)
                } footer: {
                    Text("Photo Sharing Footer [Settings]", tableName: table)
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
