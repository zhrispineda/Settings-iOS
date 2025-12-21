//
//  AppInstallationsPurchasesView.swift
//  Preferences
//
//  Settings > Screen Time > Content & Privacy Restrictions > App Installation & Purchases View
//

import SwiftUI

struct AppInstallationsPurchasesView: View {
    @State private var installingAppsSelection = "Allow"
    @State private var installingUISelection = "Allow"
    @State private var marketplaceAppsSelection = "Allow"
    @State private var inAppPurchasesSelection = "Allow"
    @State private var requirePasswordSelection = "DontRequireSpecifierName"
    @State private var deletingAppsSelection = "Allow"
    private let path = "/System/Library/PrivateFrameworks/ScreenTimeSettingsUI.framework"
    private let table = "Restrictions"
    
    var body: some View {
        CustomList(title: "AppsInstallationsAndPurchasesSpecifierName".localized(path: path, table: table), topPadding: true) {
            Section {
                SLink(
                    "InstallingAppsSpecifierName".localized(path: path, table: table),
                    status: "Allow".localized(path: path, table: table),
                    destination: SelectOptionList(
                        "InstallingAppsSpecifierName",
                        selected: $installingAppsSelection,
                        path: path,
                        table: table
                    )
                )
                SLink(
                    "InstallingUIAppsSpecifierName".localized(path: path, table: table),
                    status: "Allow".localized(path: path, table: table),
                    destination: SelectOptionList(
                        "InstallingUIAppsSpecifierName",
                        selected: $installingUISelection,
                        path: path,
                        table: table
                    )
                )
                SLink(
                    "InstallingMarketplaceAppsSpecifierName".localized(path: path, table: table),
                    status: "Allow".localized(path: path, table: table),
                    destination: SelectOptionList(
                        "InstallingMarketplaceAppsSpecifierName",
                        selected: $marketplaceAppsSelection,
                        path: path,
                        table: table
                    )
                )
            } header: {
                Text("AppInstallationsLabel".localized(path: path, table: table))
            } footer: {
                Text("AppInstallationsDetailText".localized(path: path, table: table))
            }
            
            Section {
                SLink(
                    "IAPSpecifierName".localized(path: path, table: table),
                    status: "Allow".localized(path: path, table: table),
                    destination: SelectOptionList(
                        "IAPSpecifierName",
                        selected: $inAppPurchasesSelection,
                        path: path,
                        table: table
                    )
                )
                SLink(
                    "RequirePasswordLabel".localized(path: path, table: table),
                    status: "DontRequireSpecifierName".localized(path: path, table: table),
                    destination: SelectOptionList(
                        "RequirePasswordLabel",
                        options: ["AlwaysRequireSpecifierName", "DontRequireSpecifierName"],
                        selected: $requirePasswordSelection,
                        table: table
                    )
                )
            } header: {
                Text("PurchasesLabel".localized(path: path, table: table))
            }
            
            Section {
                SLink(
                    "DeletingAppsSpecifierName".localized(path: path, table: table),
                    status: "Allow".localized(path: path, table: table),
                    destination: SelectOptionList(
                        "DeletingAppsSpecifierName",
                        selected: $deletingAppsSelection,
                        path: path,
                        table: table
                    )
                )
            } header: {
                Text("AppManagementLabel".localized(path: path, table: table))
            }
        }
    }
}

#Preview {
    NavigationStack {
        AppInstallationsPurchasesView()
    }
}
