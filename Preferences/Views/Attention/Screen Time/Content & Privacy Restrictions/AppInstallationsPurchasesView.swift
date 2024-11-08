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
                CustomNavigationLink(title: "InstallingAppsSpecifierName".localize(table: table), status: "Allow".localize(table: table), destination: SelectOptionList(title: "InstallingAppsSpecifierName", table: table))
                CustomNavigationLink(title: "InstallingUIAppsSpecifierName".localize(table: table), status: "Allow".localize(table: table), destination: SelectOptionList(title: "InstallingUIAppsSpecifierName", table: table))
                CustomNavigationLink(title: "InstallingMarketplaceAppsSpecifierName".localize(table: table), status: "Allow".localize(table: table), destination: SelectOptionList(title: "InstallingMarketplaceAppsSpecifierName", table: table))
            } header: {
                Text("AppInstallationsLabel", tableName: table)
            } footer: {
                Text("AppInstallationsDetailText", tableName: table)
            }
            
            Section {
                CustomNavigationLink(title: "IAPSpecifierName".localize(table: table), status: "Allow".localize(table: table), destination: SelectOptionList(title: "IAPSpecifierName", table: table))
                CustomNavigationLink(title: "RequirePasswordLabel".localize(table: table), status: "DontRequireSpecifierName".localize(table: table), destination: SelectOptionList(title: "RequirePasswordLabel", options: ["AlwaysRequireSpecifierName", "DontRequireSpecifierName"], selected: "DontRequireSpecifierName", table: table))
            } header: {
                Text("PurchasesLabel", tableName: table)
            }
            
            Section {
                CustomNavigationLink(title: "DeletingAppsSpecifierName".localize(table: table), status: "Allow".localize(table: table), destination: SelectOptionList(title: "DeletingAppsSpecifierName", table: table))
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
