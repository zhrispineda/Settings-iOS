//
//  AnalyticsImprovementsView.swift
//  Preferences
//
//  Settings > Privacy & Security > Analytics & Improvements
//

import SwiftUI

struct AnalyticsImprovementsView: View {
    // Variables
    @AppStorage("ProblemReportingEnabled") private var problemReportingEnabled = true
    @AppStorage("AppDeveloperAnalyticsEnabled") private var thirdPartyAnalytics = true
    @AppStorage("ImproveHealthActivityEnabled") private var healthAnalytics = true
    @AppStorage("ImproveSiriDictationEnabled") private var improveSiri = true
    @AppStorage("ImproveAssistiveVoiceEnabled") private var assistiveVoice = true
    let table = "ProblemReporting"
    
    var body: some View {
        CustomList(title: "PROBLEM_REPORTING".localize(table: "Privacy")) {
            // Analytics Section
            Section {
                Toggle("SHARE_ANALYTICS".localize(table: table), isOn: $problemReportingEnabled.animation())
                NavigationLink("DIAGNOSTIC_USAGE_DATA".localize(table: table)) {}
            } footer: {
                Text(.init("PROBLEM_REPORTING_EXPLANATION".localize(table: table, "[\("ABOUT_DIAGNOSTICS_LINK".localize(table: table))](#)")))
            }
            
            if problemReportingEnabled {
                // App Developers Section
                Section {
                    Toggle("SHARE_WITH_APP_DEVELOPERS".localize(table: table), isOn: $thirdPartyAnalytics)
                } footer: {
                    Text(.init("APP_ANALYTICS_EXPLANATION".localize(table: table, "[\("ABOUT_APP_ANALYTICS_LINK".localize(table: table))](#)")))
                }
                
                // Health Section
                Section {
                    Toggle("ABOUT_HEALTH_DATA".localize(table: table), isOn: $healthAnalytics)
                } footer: {
                    Text(.init("HEALTH_DATA_EXPLANATION".localize(table: table, "[\("HEALTH_DATA_LINK".localize(table: table))](#)")))
                }
            }
            
            // Siri Section
            Section {
                Toggle("IMPROVE_SIRI".localize(table: table), isOn: $improveSiri)
            } footer: {
                Text(.init("IMPROVE_SIRI_EXPLANATION".localize(table: table, "[\("ABOUT_IMPROVE_SIRI".localize(table: table))](#)")))
            }
            
            Section {
                Toggle("IMPROVE_ASSISTIVE_VOICE".localize(table: table), isOn: $assistiveVoice)
            } footer: {
                Text(.init("IMPROVE_ASSISTIVE_VOICE_EXPLANATION".localize(table: table, "[\("ABOUT_IMPROVE_ASSISTIVE_VOICE".localize(table: table))](#)")))
            }
        }
    }
}

#Preview {
    NavigationStack {
        AnalyticsImprovementsView()
    }
}
