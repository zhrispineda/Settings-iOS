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
    let path = "/System/Library/PrivateFrameworks/WiFiKitUI.framework"
    let table = "WiFiKitUILocalizableStrings"
    let MACAddress = generateRandomAddress()
    var name = ""
    
    var body: some View {
        CustomList(title: name) {
            Section {
                if name.isEmpty {
                    // Join This Network
                    Button("kWFLocSettingJoinNetworkTitle".localized(path: path, table: table)) {
                        dismiss()
                    }
                } else {
                    // Forget This Network
                    Button("kWFLocSettingForgetNetworkTitle".localized(path: path, table: table)) {}
                }
            }
            
            Section {
                // Private Wi-Fi Address
                SettingsLink("KWFLocSettingRandomMACSwitchTitle".localized(path: path, table: table), status: "kWFLocRandomMACStaticOption".localized(path: path, table: table), destination: SelectOptionList("KWFLocSettingRandomMACSwitchTitle", options: [
                    "kWFLocRandomMACOffOption",
                    "kWFLocRandomMACStaticOption",
                    "kWFLocRandomMACRotatingOption"
                ], selected: $privateAddressOption, table: table))
                // Wi-Fi Address
                LabeledContent("MACAddress".localized(path: "/System/Library/PrivateFrameworks/Settings/GeneralSettingsUI.framework"), value: MACAddress)
            } footer: {
                VStack(alignment: .leading) {
                    Text("kWFLocPrivateAddressFooterMainTitle".localized(path: path, table: table))
                    switch privateAddressOption {
                    case "kWFLocRandomMACOffOption":
                        Text("kWFLocPrivateAddressFooterOffDetail".localized(path: path, table: table))
                    case "kWFLocRandomMACStaticOption":
                        Text("kWFLocPrivateAddressFooterStaticDetail".localized(path: path, table: table))
                    case "kWFLocRandomMACRotatingOption":
                        Text("kWFLocPrivateAddressFooterRotatingDetail".localized(path: path, table: table))
                    default:
                        EmptyView()
                    }
                }
            }
            
            // IPv4 Address
            Section {
                SettingsLink("kWFLocSettingsIPConfigureTitle".localized(path: path, table: table), status: selectedIPV4AddressMethod.localize(table: table), destination: ConfigureIPView(selected: $selectedIPV4AddressMethod))
            } header: {
                Text("kWFLocSettingsIPSectionTitle".localized(path: path, table: table))
            }
            
            // DNS
            Section {
                SettingsLink("kWFLocSettingsDNSConfigureButton".localized(path: path, table: table), status: selectedDNSMethod.localized(path: path, table: table), destination: ConfigureDNSView(selected: $selectedDNSMethod))
            } header: {
                Text("kWFLocSettingsDNSSectionTitle".localized(path: path, table: table))
            }
            
            // HTTP Proxy
            Section {
                SettingsLink("kWFLocSettingsProxyConfigureButton".localized(path: path, table: table), status: selectedProxyMethod.localized(path: path, table: table), destination: ConfigureProxyView(selected: $selectedProxyMethod))
            } header: {
                Text("kWFLocSettingsProxySectionTitle".localized(path: path, table: table))
            }
        }
    }
}

#Preview {
    NavigationStack {
        NetworkDetailView()
    }
}
