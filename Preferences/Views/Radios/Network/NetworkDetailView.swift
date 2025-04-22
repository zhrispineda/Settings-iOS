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
                CustomNavigationLink("KWFLocSettingRandomMACSwitchTitle".localize(table: table), status: "kWFLocRandomMACStaticOption".localize(table: table), destination: SelectOptionList("KWFLocSettingRandomMACSwitchTitle", options: [
                    "kWFLocRandomMACOffOption",
                    "kWFLocRandomMACStaticOption",
                    "kWFLocRandomMACRotatingOption"
                ], selected: privateAddressOption, table: table))
                // Wi-Fi Address
                LabeledContent("MACAddress".localize(table: "GeneralSettingsUI"), value: MACAddress)
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
                CustomNavigationLink("kWFLocSettingsIPConfigureTitle".localize(table: table), status: selectedIPV4AddressMethod.localize(table: table), destination: ConfigureIPView(selected: $selectedIPV4AddressMethod))
            } header: {
                Text("kWFLocSettingsIPSectionTitle", tableName: table)
            }
            
            // DNS
            Section {
                CustomNavigationLink("kWFLocSettingsDNSConfigureButton".localize(table: table), status: "kWFLocSettingsDNSConfigureAutomatic".localize(table: table), destination: EmptyView())
            } header: {
                Text("kWFLocSettingsDNSSectionTitle", tableName: table)
            }
            
            // HTTP Proxy
            Section {
                CustomNavigationLink("kWFLocSettingsProxyConfigureButton".localize(table: table), status: "kWFLocSettingsProxyConfigOffTitle".localize(table: table), destination: EmptyView())
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
