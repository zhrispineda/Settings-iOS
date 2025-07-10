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
    let path = "/System/Library/PrivateFrameworks/SoftwareUpdateSettings.framework"
    let table = "Software Update"
    
    var body: some View {
        CustomList(title: "AUTOMATIC_UPDATES".localized(path: path, table: table), topPadding: true) {
            Section {
                Toggle("AUTOMATIC_UPDATES_AUTO_INSTALL_HEADER".localized(path: path, table: table), isOn: $automaticUpdatesEnabled.animation())
                if !automaticUpdatesEnabled {
                    Toggle("AUTOMATIC_UPDATES_AUTO_DOWNLOAD_HEADER".localized(path: path, table: table), isOn: $autoDownload)
                }
            } header: {
                if !automaticUpdatesEnabled {
                    Text(UIDevice.iPhone ? "AUTOMATIC_INSTALL_TOGGLE_TEXT_IPHONE".localized(path: path, table: table) : "AUTOMATIC_INSTALL_TOGGLE_TEXT_IPAD".localized(path: path, table: table))
                }
            } footer: {
                if UIDevice.iPhone {
                    Text("AUTOMATIC_UPDATES_AUTO_INSTALL_EXPLANATION_WIFI_IPHONE".localized(path: path, table: table))
                } else if UIDevice.iPad {
                    Text("AUTOMATIC_UPDATES_AUTO_INSTALL_EXPLANATION_WIFI_IPAD".localized(path: path, table: table))
                }
            }

            if !automaticUpdatesEnabled {
                Section {
                    if UIDevice.iPhone {
                        Toggle("AUTOMATIC_UPDATES_AUTO_INSTALL_HEADER".localized(path: path, table: table), isOn: $autoInstallSysFiles)
                    } else if UIDevice.iPad {
                        Toggle("AUTOMATIC_UPDATES_AUTO_INSTALL_HEADER".localized(path: path, table: table), isOn: $autoInstallSysFiles)
                    }
                } header: {
                    Text("System Files".localized(path: path, table: table))
                } footer: {
                    if UIDevice.iPhone {
                        Text("AUTOMATIC_UPDATES_AUTO_DOWNLOAD_EXPLANATION_IPHONE".localized(path: path, table: table))
                    } else if UIDevice.iPad {
                        Text("AUTOMATIC_UPDATES_AUTO_DOWNLOAD_EXPLANATION_IPAD".localized(path: path, table: table))
                    }
                }
            }
        }
        .animation(.default, value: automaticUpdatesEnabled)
    }
}

#Preview {
    NavigationStack {
        AutomaticUpdateView()
    }
}
