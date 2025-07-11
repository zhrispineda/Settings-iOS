//
//  NetworkDetailView.swift
//  Preferences
//
//  Settings > Wi-Fi > [Network]
//

import SwiftUI

struct NetworkDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var privateAddressOption = "kWFLocRandomMACRotatingOption"
    @State private var selectedIPV4AddressMethod = "kWFLocSettingsIPV4ConfigureAutomatic"
    @State private var selectedDNSMethod = "kWFLocSettingsDNSConfigureAutomatic"
    @State private var selectedProxyMethod = "kWFLocSettingsProxyConfigOffTitle"
    let table = "WiFiKitUILocalizableStrings"
    let MACAddress = generateRandomAddress()
    var name = ""
    
    var body: some View {
        CustomList(title: name) {
            Section {
                if name.isEmpty {
                    // Join This Network
                    Button("kWFLocSettingJoinNetworkTitle".localize(table: table)) {
                        dismiss()
                    }
                } else {
                    // Forget This Network
                    Button("kWFLocSettingForgetNetworkTitle".localize(table: table)) {}
                }
            }
            
            Section {
                // Private Wi-Fi Address
                SettingsLink("KWFLocSettingRandomMACSwitchTitle".localize(table: table), status: "kWFLocRandomMACStaticOption".localize(table: table), destination: SelectOptionList("KWFLocSettingRandomMACSwitchTitle", options: [
                    "kWFLocRandomMACOffOption",
                    "kWFLocRandomMACStaticOption",
                    "kWFLocRandomMACRotatingOption"
                ], selected: privateAddressOption, table: table))
                // Wi-Fi Address
                LabeledContent("MACAddress".localized(path: "/System/Library/PrivateFrameworks/Settings/GeneralSettingsUI.framework"), value: MACAddress)
            } footer: {
                VStack(alignment: .leading) {
                    Text("kWFLocPirvateAddressFooterMainTitle", tableName: table)
                    switch privateAddressOption {
                    case "kWFLocRandomMACOffOption":
                        Text("kWFLocPirvateAddressFooterOffDetail", tableName: table)
                    case "kWFLocRandomMACStaticOption":
                        Text("kWFLocPirvateAddressFooterStaticDetail", tableName: table)
                    case "kWFLocRandomMACRotatingOption":
                        Text("kWFLocPirvateAddressFooterRotatingDetail", tableName: table)
                    default:
                        EmptyView()
                    }
                }
            }
            
            // IPv4 Address
            Section {
                SettingsLink("kWFLocSettingsIPConfigureTitle".localize(table: table), status: selectedIPV4AddressMethod.localize(table: table), destination: ConfigureIPView(selected: $selectedIPV4AddressMethod))
            } header: {
                Text("kWFLocSettingsIPSectionTitle", tableName: table)
            }
            
            // DNS
            Section {
                SettingsLink("kWFLocSettingsDNSConfigureButton".localize(table: table), status: selectedDNSMethod.localize(table: table), destination: ConfigureDNSView(selected: $selectedDNSMethod))
            } header: {
                Text("kWFLocSettingsDNSSectionTitle", tableName: table)
            }
            
            // HTTP Proxy
            Section {
                SettingsLink("kWFLocSettingsProxyConfigureButton".localize(table: table), status: selectedProxyMethod.localize(table: table), destination: ConfigureProxyView(selected: $selectedProxyMethod))
            } header: {
                Text("kWFLocSettingsProxySectionTitle", tableName: table)
            }
        }
    }
}

#Preview {
    NavigationStack {
        NetworkDetailView()
    }
}
