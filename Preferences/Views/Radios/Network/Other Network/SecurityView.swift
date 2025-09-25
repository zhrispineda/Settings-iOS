//
//  SecurityView.swift
//  Preferences
//
//  Settings > Wi-Fi > Other… > Security
//

import SwiftUI

struct SecurityView: View {
    @Binding var security: String
    @State private var selectedRotation = "kWFLocRandomMACOffOption"
    let path = "/System/Library/PrivateFrameworks/WiFiKitUI.framework"
    let table = "WiFiKitUILocalizableStrings"
    let options = [
        "kWFLocSecurityNoneTitle",
        "kWFLocSecurityWEPTitle",
        "kWFLocSecurityWPATitle",
        "kWFLocSecurityWPA2WPA3Title",
        "kWFLocSecurityWPA3Title",
        "kWFLocSecurityWPAEnterpriseTitle",
        "kWFLocSecurityWPA2EnterpriseTitle",
        "kWFLocSecurityWPA3EnterpriseTitle"
    ]
    
    var body: some View {
        CustomList(title: "kWFLocOtherNetworkSecurityTitle".localized(path: path, table: table)) {
            Section {
                SettingsLink(
                    "KWFLocSettingRandomMACSwitchTitle".localized(
                        path: path,
                        table: table
                    ),
                    status: selectedRotation.localized(
                        path: path,
                        table: table
                    ),
                    destination: SelectOptionList(
                        "KWFLocSettingRandomMACSwitchTitle",
                        options: [
                            "kWFLocRandomMACOffOption",
                            "kWFLocRandomMACStaticOption",
                            "kWFLocRandomMACRotatingOption"
                        ],
                        selectedBinding: $selectedRotation,
                        path: path,
                        table: table
                    )
                )
            }
            
            Section {
                Picker("", selection: $security) {
                    ForEach(options, id: \.self) { option in
                        Text(option.localized(path: path, table: table))
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            }
        }
    }
}

#Preview {
    NavigationStack {
        SecurityView(security: .constant("kWFLocSecurityWPA2WPA3Title"))
    }
}
