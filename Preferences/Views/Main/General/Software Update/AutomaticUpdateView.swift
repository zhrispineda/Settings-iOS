//
//  AutomaticUpdateView.swift
//  Preferences
//
//  Settings > General > Software Update > Automatic Updates
//

import SwiftUI

struct AutomaticUpdateView: View {
    @State private var automaticUpdatesEnabled = true
    @State private var autoDownload = true
    @State private var autoInstallSysFiles = true
    let table = "Software Update"
    
    var body: some View {
        CustomList(title: "AUTOMATIC_UPDATES".localize(table: table), topPadding: true) {
            Section {
                Toggle("AUTOMATIC_UPDATES_AUTO_INSTALL_HEADER".localize(table: table), isOn: $automaticUpdatesEnabled.animation())
                if !automaticUpdatesEnabled {
                    Toggle("AUTOMATIC_UPDATES_AUTO_DOWNLOAD_HEADER".localize(table: table), isOn: $autoDownload)
                }
            } header: {
                if !automaticUpdatesEnabled {
                    Text(UIDevice.iPhone ? "AUTOMATIC_INSTALL_TOGGLE_TEXT_IPHONE" : "AUTOMATIC_INSTALL_TOGGLE_TEXT_IPAD", tableName: table)
                }
            } footer: {
                if UIDevice.iPhone {
                    Text("AUTOMATIC_UPDATES_AUTO_INSTALL_EXPLANATION_WIFI_IPHONE", tableName: table)
                } else if UIDevice.iPad {
                    Text("AUTOMATIC_UPDATES_AUTO_INSTALL_EXPLANATION_WIFI_IPAD", tableName: table)
                }
            }

            if !automaticUpdatesEnabled {
                Section {
                    if UIDevice.iPhone {
                        Toggle("AUTOMATIC_UPDATES_AUTO_INSTALL_HEADER".localize(table: table), isOn: $autoInstallSysFiles)
                    } else if UIDevice.iPad {
                        Toggle("AUTOMATIC_UPDATES_AUTO_INSTALL_HEADER".localize(table: table), isOn: $autoInstallSysFiles)
                    }
                } header: {
                    Text("System Files", tableName: table)
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
}

#Preview {
    NavigationStack {
        AutomaticUpdateView()
    }
}
