//
//  NetworkDetailView.swift
//  Preferences
//
//  Settings > Wi-Fi > [Network]
//

import SwiftUI

struct NetworkDetailView: View {
    @State private var privateAddressOption = "Fixed"
    let table = "WiFiKitUILocalizableStrings"
    
    var body: some View {
        CustomList(title: "NETWORK") {
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
                Button("kWFLocSettingJoinNetworkTitle".localize(table: table)) {}
            }
            
            Section {
                //Toggle("Private Wi-Fi Address", isOn: $privateWifiAddressEnabled)
                CustomNavigationLink(title: "Private Wi-Fi Address", status: "Fixed", destination: SelectOptionList(title: "Private Wi-Fi Address", options: ["kWFLocRandomMACOffOption".localize(table: table), "kWFLocRandomMACStaticOption".localize(table: table), "kWFLocRandomMACRotatingOption".localize(table: table)], selected: privateAddressOption))
                LabeledContent("MACAddress", value: generateRandomAddress())
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
