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
        CustomList(title: "kWFLocOtherNetworkSecurityTitle".localize(table: table)) {
            Section {
                SettingsLink("KWFLocSettingRandomMACSwitchTitle".localize(table: table),status: selectedRotation.localize(table: table), destination: SelectOptionList("KWFLocSettingRandomMACSwitchTitle", options: [
                    "kWFLocRandomMACOffOption",
                    "kWFLocRandomMACStaticOption",
                    "kWFLocRandomMACRotatingOption"
                ], selectedBinding: $selectedRotation, table: table))
            }
            
            Section {
                Picker("", selection: $security) {
                    ForEach(options, id: \.self) { option in
                        Text(option.localize(table: table))
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
