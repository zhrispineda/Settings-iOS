//
//  CommunicationSafetyView.swift
//  Preferences
//
//  Settings > Screen Time > Communication Safety
//

import SwiftUI

struct CommunicationSafetyView: View {
    // Variables
    @State private var communicationSafetyEnabled = false
    @State private var improveCommunicationSafety = false
    let table = "ScreenTimeSettingsUI"
    let onTable = "ImproveSensitiveContentWarning"
    
    var body: some View {
        CustomList(title: "CommunicationSafetyTitle".localize(table: table), topPadding: true) {
            Section {
                Toggle("CommunicationSafetyEnableFeatureSpecifierTitle".localize(table: table), isOn: $communicationSafetyEnabled)
            } header: {
                Text("CommunicationSafetyEnableFeatureGroupSpecifierTitle", tableName: table)
            } footer: {
                Text(.init("CommunicationSafetyEnableFeatureGroupSpecifierFooter".localize(table: table, "[\("CommunicationSafetyLearnMoreFooterLink".localize(table: table))](#)")))
            }
            
            Section {
                Button("CommunicationSafetyViewResourcesSpecifierTitle".localize(table: table)) {}
            } footer: {
                Text("CommunicationSafetyViewResourcesGroupSpecifierFooter", tableName: table)
            }
            
            Section {
                Toggle("CommunicationSafetyEnableAnalyticsSpecifierTitle".localize(table: table), isOn: $improveCommunicationSafety)
                    .disabled(!communicationSafetyEnabled)
            } header: {
                Text("CommunicationSafetyAnalyticsGroupSpecifierTitle", tableName: table)
            } footer: {
                Text(.init("CommunicationSafetyAnalyticsGroupSpecifierFooter".localize(table: table, "[\("BUTTON_TITLE".localize(table: onTable))](#)")))
            }
        }
    }
}

#Preview {
    NavigationStack {
        CommunicationSafetyView()
    }
}
