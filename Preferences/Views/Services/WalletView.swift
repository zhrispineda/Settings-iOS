//
//  WalletView.swift
//  Preferences
//
//  Settings > Wallet/Wallet & Apple Pay
//

import SwiftUI

struct WalletView: View {
    @AppStorage("AppleCashEnabled") private var appleCashEnabled = false
    @State private var cellularEnabled = true
    @State private var hideExpiredPassesEnabled = true
    let path = "/System/Library/Frameworks/PassKit.framework/"
    let payTable = "Payment_Localizable"
    let peerTable = "PeerPayment_Localizable"
    let walletTable = "WalletSettings_Localizable"
    
    var body: some View {
        CustomList(title: "WALLET_&_APPLE_PAY".localized(path: path, table: walletTable), topPadding: true) {
            if UIDevice.IsSimulator {
                PermissionsView(appName: "WALLET_&_APPLE_PAY".localized(path: path, table: walletTable), cellular: false, liveActivityToggle: true, location: false, siri: true, cellularEnabled: $cellularEnabled)
            } else {
                PermissionsView(appName: "WALLET_&_APPLE_PAY".localized(path: path, table: walletTable), cellular: true, liveActivityToggle: true, location: false, siri: true, cellularEnabled: $cellularEnabled)
            }
            
            if !UIDevice.IsSimulator {
                Section {
                    SLink("SETTINGS_APPLE_PAY_DEFAULTS_TITLE".localized(path: path, table: payTable), icon: "com.apple.graphic-icon.account.payment", subtitle: "SETTINGS_APPLE_PAY_DEFAULTS_SUBTITLE".localized(path: path, table: payTable)) {}
                }
                
                Section {
                    Toggle("SE_STORAGE_APPLET_CATEGORY_APLET_TYPE_PTC".localized(path: path, table: payTable), isOn: $appleCashEnabled.animation())
                } footer: {
                    if UIDevice.iPhone {
                        Text("PEER_PAYMENT_REGISTRATION_FOOTER_TEXT_IPHONE".localized(path: path, table: peerTable))
                    } else if UIDevice.iPad {
                        Text("PEER_PAYMENT_REGISTRATION_FOOTER_TEXT_IPAD".localized(path: path, table: peerTable))
                    }
                }
                
                Section {
                    Button("PEER_PAYMENT_ADD_CARD_BUTTON_TITLE".localized(path: path, table: peerTable)) {}
                } header: {
                    Text("SETTINGS_PAYMENT_CARDS_GROUP".localized(path: path, table: payTable))
                } footer: {
                    if !appleCashEnabled {
                        Text(.init("\(UIDevice.PearlIDCapability ? UIDevice.iPhone ? "SETTINGS_ABOUT_FOOTER_FACEID_IPHONE".localized(path: path, table: payTable) : "SETTINGS_ABOUT_FOOTER_FACEID_IPAD".localized(path: path, table: payTable) : UIDevice.iPad ? "SETTINGS_ABOUT_FOOTER_IPAD".localized(path: path, table: payTable) : "SETTINGS_ABOUT_FOOTER_IPHONE".localized(path: path, table: payTable)) [\("APPLE_PAY_PRIVACY".localized(path: path, table: walletTable))](#)"))
                    }
                }
            }
            
            SLink("FPAN_ADD_TO_APPLE_PAY_TITLE".localized(path: path, table: payTable), icon: "None", status: "0") {}
            
            if !UIDevice.IsSimulator && UIDevice.iPhone {
                Section {
                    SettingsLink("SETTINGS_EXPRESS_TRANSIT_CARDS_SECTION_HEADER".localized(path: path, table: payTable), status: "NONE".localized(path: path, table: payTable), destination: EmptyView())
                } header: {
                    Text("SETTINGS_EXPRESS_TRANSIT_CARD_CATEGORY_SECTION_HEADER".localized(path: path, table: payTable))
                } footer: {
                    Text(UIDevice.PearlIDCapability ? "SETTINGS_EXPRESS_TRANSIT_SECTION_FOOTER_IPHONE_LPEM_FACEID".localized(path: path, table: payTable) : "SETTINGS_EXPRESS_TRANSIT_SECTION_FOOTER_IPHONE_LPEM_TOUCHID".localized(path: path, table: payTable))
                }
            }
            
            Section {
                Toggle("ALLOW_EXPIRED_PASSES_TITLE".localized(path: path), isOn: $hideExpiredPassesEnabled)
            }
            
            Section {
                NavigationLink("Order Tracking") {}
            }
        }
        .animation(.default, value: appleCashEnabled)
    }
}

#Preview {
    NavigationStack {
        WalletView()
    }
}
