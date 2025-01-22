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
                NavigationLink("DIAGNOSTIC_USAGE_DATA".localize(table: table), destination: AnalyticsDataView())
            } footer: {
                LocalizedLink("PROBLEM_REPORTING_EXPLANATION", table: table, link: "ABOUT_DIAGNOSTICS_LINK")
            }
            
            if problemReportingEnabled {
                // App Developers Section
                Section {
                    Toggle("SHARE_WITH_APP_DEVELOPERS".localize(table: table), isOn: $thirdPartyAnalytics)
                } footer: {
                    LocalizedLink("APP_ANALYTICS_EXPLANATION", table: table, link: "ABOUT_APP_ANALYTICS_LINK")
                }
                
                // Health Section
                Section {
                    Toggle("ABOUT_HEALTH_DATA".localize(table: table), isOn: $healthAnalytics)
                } footer: {
                    LocalizedLink("HEALTH_DATA_EXPLANATION", table: table, link: "HEALTH_DATA_LINK")
                }
            }
            
            // Siri Section
            Section {
                Toggle("IMPROVE_SIRI".localize(table: table), isOn: $improveSiri)
            } footer: {
                LocalizedLink("IMPROVE_SIRI_EXPLANATION", table: table, link: "ABOUT_IMPROVE_SIRI")
            }
            
            Section {
                Toggle("IMPROVE_ASSISTIVE_VOICE".localize(table: table), isOn: $assistiveVoice)
            } footer: {
                LocalizedLink("IMPROVE_ASSISTIVE_VOICE_EXPLANATION", table: table, link: "ABOUT_IMPROVE_ASSISTIVE_VOICE")
            }
        }
    }
}

#Preview {
    NavigationStack {
        AnalyticsImprovementsView()
    }
}
