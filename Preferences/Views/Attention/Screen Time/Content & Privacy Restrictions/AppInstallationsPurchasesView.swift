//
//  AppInstallationsPurchasesView.swift
//  Preferences
//
//  Settings > Screen Time > Content & Privacy Restrictions > App Installation & Purchases View
//

import SwiftUI

struct AppInstallationsPurchasesView: View {
    var body: some View {
        CustomList(title: "App Installations & Purchases") {
            Section(content: {
                CustomNavigationLink(title: "Installing Apps", status: "Allow", destination: SelectOptionList(title: "Installing Apps"))
                CustomNavigationLink(title: "App Store", status: "Allow", destination: SelectOptionList(title: "App Store"))
                CustomNavigationLink(title: "App Marketplaces", status: "Allow", destination: SelectOptionList(title: "App Marketplaces"))
            }, header: {
                Text("App Installations")
            }, footer: {
                Text("Allow app downloads from the App Store, or other app marketplaces.")
            })
            
            Section(content: {
                CustomNavigationLink(title: "In-app Purchases", status: "Allow", destination: SelectOptionList(title: "In-app Purchases"))
                CustomNavigationLink(title: "Require Password", status: "Don‘t Require", destination: SelectOptionList(title: "Require Password", options: ["Always Require", "Don‘t Require"], selected: "Don‘t Require"))
            }, header: {
                Text("iTunes, Book, App Store Purchases")
            })
            
            Section(content: {
                CustomNavigationLink(title: "Deleting Apps", status: "Allow", destination: SelectOptionList(title: "Deleting Apps"))
            }, header: {
                Text("App Management")
            })
        }
    }
}

#Preview {
    NavigationStack {
        AppInstallationsPurchasesView()
    }
}
