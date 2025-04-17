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
                CustomNavigationLink("InstallingAppsSpecifierName".localize(table: table), status: "Allow".localize(table: table), destination: SelectOptionList("InstallingAppsSpecifierName", table: table))
                CustomNavigationLink("InstallingUIAppsSpecifierName".localize(table: table), status: "Allow".localize(table: table), destination: SelectOptionList("InstallingUIAppsSpecifierName", table: table))
                CustomNavigationLink("InstallingMarketplaceAppsSpecifierName".localize(table: table), status: "Allow".localize(table: table), destination: SelectOptionList("InstallingMarketplaceAppsSpecifierName", table: table))
            } header: {
                Text("AppInstallationsLabel", tableName: table)
            } footer: {
                Text("AppInstallationsDetailText", tableName: table)
            }
            
            Section {
                CustomNavigationLink("IAPSpecifierName".localize(table: table), status: "Allow".localize(table: table), destination: SelectOptionList("IAPSpecifierName", table: table))
                CustomNavigationLink("RequirePasswordLabel".localize(table: table), status: "DontRequireSpecifierName".localize(table: table), destination: SelectOptionList("RequirePasswordLabel", options: ["AlwaysRequireSpecifierName", "DontRequireSpecifierName"], selected: "DontRequireSpecifierName", table: table))
            } header: {
                Text("PurchasesLabel", tableName: table)
            }
            
            Section {
                CustomNavigationLink("DeletingAppsSpecifierName".localize(table: table), status: "Allow".localize(table: table), destination: SelectOptionList("DeletingAppsSpecifierName", table: table))
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
