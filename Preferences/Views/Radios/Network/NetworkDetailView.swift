//
//  NetworkDetailView.swift
//  Preferences
//
//  Settings > Wi-Fi > [Network]
//

import SwiftUI

struct NetworkDetailView: View {
    @State private var privateAddressOption = "kWFLocRandomMACStaticOption"
    let table = "WiFiKitUILocalizableStrings"
    var name = String()
    
    var body: some View {
        CustomList(title: name) {
//            Section {
//                Text("**Unsecured Network**")
//                Text("Open networks provide no security and expose all network traffic.")
//                    .foregroundStyle(.secondary)
//                    .listRowSeparator(.hidden)
//                Text("If this is your Wi-Fi network, configure the router to use WPA2 (AES) or WPA3 security type.")
//                    .foregroundStyle(.secondary)
//                Text("**Privacy Warning**")
//                Text("Private Wi-Fi address is turned off for this network.")
//                    .foregroundStyle(.secondary)
//                    .listRowSeparator(.hidden)
//                Text("Using a private address helps reduce tracking of your iPhone across different Wi-Fi networks.")
//                    .foregroundStyle(.secondary)
//            } footer: {
//                Text("[Learn more about recommended settings for Wi-Fi...](#)")
//            }
            
            Section {
                if name.isEmpty {
                    Button("kWFLocSettingJoinNetworkTitle".localize(table: table)) {}
                } else {
                    Button("kWFLocSettingForgetNetworkTitle".localize(table: table)) {}
                }
            }
            
            Section {
                //Toggle("Private Wi-Fi Address", isOn: $privateWifiAddressEnabled)
                CustomNavigationLink(title: "KWFLocSettingRandomMACSwitchTitle".localize(table: table), status: "kWFLocRandomMACStaticOption".localize(table: table), destination: SelectOptionList(title: "KWFLocSettingRandomMACSwitchTitle", options: ["kWFLocRandomMACOffOption", "kWFLocRandomMACStaticOption", "kWFLocRandomMACRotatingOption"], selected: privateAddressOption, table: table))
                LabeledContent("MACAddress".localize(table: "GeneralSettingsUI"), value: generateRandomAddress())
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
            
            Section {
                CustomNavigationLink(title: "kWFLocSettingsIPConfigureTitle".localize(table: table), status: "kWFLocSettingsIPV4ConfigureAutomatic".localize(table: table), destination: EmptyView())
            } header: {
                Text("kWFLocSettingsIPSectionTitle", tableName: table)
            }
            
            Section {
                CustomNavigationLink(title: "kWFLocSettingsDNSConfigureButton".localize(table: table), status: "kWFLocSettingsDNSConfigureAutomatic".localize(table: table), destination: EmptyView())
            } header: {
                Text("kWFLocSettingsDNSSectionTitle", tableName: table)
            }
            
            Section {
                CustomNavigationLink(title: "kWFLocSettingsProxyConfigureButton".localize(table: table), status: "kWFLocSettingsProxyConfigOffTitle".localize(table: table), destination: EmptyView())
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
