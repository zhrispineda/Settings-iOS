//
//  AppInstallationsPurchasesView.swift
//  Preferences
//
//  Settings > Screen Time > Content & Privacy Restrictions > App Installation & Purchases View
//

import SwiftUI

struct AppInstallationsPurchasesView: View {
    // Variables
    let table = "Restrictions"
    
    var body: some View {
        CustomList(title: "AppsInstallationsAndPurchasesSpecifierName".localize(table: table), topPadding: true) {
            Section {
                SettingsLink("InstallingAppsSpecifierName".localize(table: table), status: "Allow".localize(table: table), destination: SelectOptionList("InstallingAppsSpecifierName", table: table))
                SettingsLink("InstallingUIAppsSpecifierName".localize(table: table), status: "Allow".localize(table: table), destination: SelectOptionList("InstallingUIAppsSpecifierName", table: table))
                SettingsLink("InstallingMarketplaceAppsSpecifierName".localize(table: table), status: "Allow".localize(table: table), destination: SelectOptionList("InstallingMarketplaceAppsSpecifierName", table: table))
            } header: {
                Text("AppInstallationsLabel", tableName: table)
            } footer: {
                Text("AppInstallationsDetailText", tableName: table)
            }
            
            Section {
                SettingsLink("IAPSpecifierName".localize(table: table), status: "Allow".localize(table: table), destination: SelectOptionList("IAPSpecifierName", table: table))
                SettingsLink("RequirePasswordLabel".localize(table: table), status: "DontRequireSpecifierName".localize(table: table), destination: SelectOptionList("RequirePasswordLabel", options: ["AlwaysRequireSpecifierName", "DontRequireSpecifierName"], selected: "DontRequireSpecifierName", table: table))
            } header: {
                Text("PurchasesLabel", tableName: table)
            }
            
            Section {
                SettingsLink("DeletingAppsSpecifierName".localize(table: table), status: "Allow".localize(table: table), destination: SelectOptionList("DeletingAppsSpecifierName", table: table))
            } header: {
                Text("AppManagementLabel", tableName: table)
            }
        }
    }
}

#Preview {
    NavigationStack {
        AppInstallationsPurchasesView()
    }
}
