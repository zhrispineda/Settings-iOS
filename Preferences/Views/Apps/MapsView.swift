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
    @State private var selected = "Driving Transportation Mode Label [Settings]"
    @State private var airQualityIndexEnabled = true
    @State private var weatherConditionsEnabled = true
    @State private var alwaysEnglishEnabled = true
    @State private var ratingsPhotosEnabled = true
    @State private var showRatingsPhotoSuggestions = true
    @State private var allowPhotoProvidersUse = false
    @State private var showingPrivacySheet = true
    let options = ["Driving Transportation Mode Label [Settings]", "Walking Label [Settings]", "Transit Label [Settings]", "Cycling Label [Settings]"]
    let path = "/System/Library/PreferenceBundles/MapsSettings.bundle"
    
    var body: some View {
        CustomList(title: "Maps [Settings]".localized(path: path), topPadding: true) {
            if UIDevice.IsSimulator {
                PermissionsView(appName: "Maps [Settings]".localized(path: path), background: true, cellular: false, location: false, notifications: false, cellularEnabled: .constant(true))
            } else {
                PermissionsView(appName: "Maps [Settings]".localized(path: path), background: true, cellularEnabled: .constant(true))
            }
            
            Section {
                Picker("Default Transportation Mode Title [Settings]".localized(path: path), selection: $selected) {
                    ForEach(options, id: \.self) {
                        Text($0.localized(path: path))
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } header: {
                Text("Default Transportation Mode Title [Settings]".localized(path: path))
            } footer: {
                Text("Default Transportation Mode Footer [Settings]".localized(path: path))
            }
            
            Section("Directions Group Label [Settings]".localized(path: path)) {
                NavigationLink("Driving Group Title [Settings]".localized(path: path), destination: DrivingView())
                NavigationLink("Walking Label [Settings]".localized(path: path), destination: WalkingView())
                NavigationLink("Transit Label [Settings]".localized(path: path), destination: TransitView())
                NavigationLink("Cycling Label [Settings]".localized(path: path), destination: CyclingView())
            }
            
            if !UIDevice.IsSimulator && UIDevice.iPhone {
                Section {
                    NavigationLink("Spoken Directions Label [Settings]".localized(path: path)) {}
                }
            }
            
            Section("Climate Group Label [Settings]".localized(path: path)) {
                Toggle("Air Quality Index Switch Label [Settings]".localized(path: path), isOn: $airQualityIndexEnabled)
                Toggle("Weather Conditions Switch Label [Settings]".localized(path: path), isOn: $weatherConditionsEnabled)
            }
            
            Section {
                Toggle("Label Language Switch Label [Settings]".localized(path: path), isOn: $alwaysEnglishEnabled)
            } header: {
                Text("Label Language Group Title [Settings]".localized(path: path))
            }
            
            if !UIDevice.IsSimulator {
                Section {
                    Toggle("Ratings and Photos [Laguna Beach][Settings]".localized(path: path), isOn: $ratingsPhotosEnabled)
                    Toggle("Show Ratings and Photos Suggestions [Laguna Beach][Settings]".localized(path: path), isOn: $showRatingsPhotoSuggestions)
                } header: {
                    Text("Contribute to Maps [Settings]".localized(path: path))
                } footer: {
                    Text("[See how your data is managed…](pref://ratings)")
                }
                
                Section {
                    Toggle("Allow Photo Providers to Use Your Photos [Settings]".localized(path: path), isOn: $allowPhotoProvidersUse)
                } header: {
                    Text("Photo Use [Settings]".localized(path: path))
                } footer: {
                    Text("Photo Sharing Footer [Settings]".localized(path: path))
                }
            }
        }
        .onOpenURL { url in
            if url.absoluteString == "pref://ratings" {
                showingPrivacySheet = true
            }
        }
        .sheet(isPresented: $showingPrivacySheet) {
            OnBoardingKitView(bundleID: "com.apple.onboarding.ratingsAndPhotos")
                .ignoresSafeArea()
        }
    }
}

#Preview {
    NavigationStack {
        MapsView()
    }
}
