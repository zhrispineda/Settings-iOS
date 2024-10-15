//
//  AutomaticUpdateView.swift
//  Preferences
//
//  Settings > General > Software Update > Automatic Updates
//

import SwiftUI

struct AutomaticUpdateView: View {
    // Variables
    @State private var automaticUpdatesEnabled = true
    @State private var securityResponsesEnabled = true
    @State private var automaticDownloadsEnabled = true
    let table = "Software Update"
    
    var body: some View {
        CustomList(title: "AUTOMATIC_UPDATES".localize(table: table), topPadding: true) {
            Section {
                if UIDevice.iPhone {
                    Toggle("AUTOMATIC_INSTALL_TOGGLE_TEXT_IPHONE".localize(table: table), isOn: $automaticUpdatesEnabled)
                } else if UIDevice.iPad {
                    Toggle("AUTOMATIC_INSTALL_TOGGLE_TEXT_IPAD".localize(table: table), isOn: $automaticUpdatesEnabled)
                }
                Toggle("AUTOMATIC_UPDATES_DOWNLOAD_TOGGLE_SECURITY_RESPONSE_AND_SYSTEM_FILES".localize(table: table), isOn: $securityResponsesEnabled)
            } header: {
                Text("AUTOMATIC_UPDATES_AUTO_INSTALL_HEADER", tableName: table)
            } footer: {
                if UIDevice.iPhone {
                    Text("AUTOMATIC_UPDATES_AUTO_INSTALL_EXPLANATION_WIFI_IPHONE", tableName: table)
                } else if UIDevice.iPad {
                    Text("AUTOMATIC_UPDATES_AUTO_INSTALL_EXPLANATION_WIFI_IPAD", tableName: table)
                }
            }
            
            Section {
                if UIDevice.iPhone {
                    Toggle("AUTOMATIC_INSTALL_TOGGLE_TEXT_IPHONE".localize(table: table), isOn: $automaticDownloadsEnabled)
                } else if UIDevice.iPad {
                    Toggle("AUTOMATIC_INSTALL_TOGGLE_TEXT_IPAD".localize(table: table), isOn: $automaticDownloadsEnabled)
                }
            } header: {
                Text("AUTOMATIC_UPDATES_AUTO_DOWNLOAD_HEADER", tableName: table)
            } footer: {
                if UIDevice.iPhone {
                    Text("AUTOMATIC_UPDATES_AUTO_DOWNLOAD_EXPLANATION_IPHONE", tableName: table)
                } else if UIDevice.iPad {
                    Text("AUTOMATIC_UPDATES_AUTO_DOWNLOAD_EXPLANATION_IPAD", tableName: table)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AutomaticUpdateView()
    }
}
