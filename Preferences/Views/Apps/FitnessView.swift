//
//  FitnessView.swift
//  Preferences
//
//  Settings > Apps > Fitness
//

import SwiftUI

struct FitnessView: View {
    // Variables
    @State private var cellularEnabled = true
    @AppStorage("UseSessionDataToggle") private var useSessionData = true
    @State private var showingFitnessPlusSheet = false
    @State private var showingActivitySheet = false
    let table = "FitnessSettings"
    
    var body: some View {
        CustomList(title: "Fitness", topPadding: true) {
            PermissionsView(appName: "Fitness", liveActivityToggle: true, location: false, notifications: false, cellularEnabled: $cellularEnabled)
            
            Section {
                Toggle("FITNESS_PLUS_PERSONALIZATION_PRIVACY_SWITCH".localize(table: table), isOn: $useSessionData)
            } header: {
                Text("FITNESS_PLUS_PRIVACY_SECTION", tableName: table)
            } footer: {
                Text("FITNESS_PLUS_PERSONALIZATION_PRIVACY_FOOTER", tableName: table)
            }
            
            Section {
                Button("PRIVACY_PRESENT_BUTTON".localize(table: table)) {
                    showingFitnessPlusSheet = true
                }
                
            }
            
            Section("ACTIVITY_SHARING_PRIVACY_SECTION".localize(table: table)) {
                Button("PRIVACY_PRESENT_BUTTON".localize(table: table)) {
                    showingActivitySheet = true
                }
            }
        }
        .sheet(isPresented: $showingFitnessPlusSheet) {
            OnBoardingKitView(bundleID: "com.apple.onboarding.fitnessplus")
                .ignoresSafeArea()
        }
        .sheet(isPresented: $showingActivitySheet) {
            OnBoardingKitView(bundleID: "com.apple.onboarding.activity")
                .ignoresSafeArea()
        }
    }
}

#Preview {
    NavigationStack {
        FitnessView()
    }
}
