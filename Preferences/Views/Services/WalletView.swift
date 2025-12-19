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
    private let path = "/System/Library/Frameworks/PassKit.framework"
    private let payTable = "Payment_Localizable"
    private let peerTable = "PeerPayment_Localizable"
    private let walletTable = "WalletSettings_Localizable"
    private var appleCashFooter: String {
        if UIDevice.iPhone {
            return UIDevice.PearlIDCapability ? "SETTINGS_ABOUT_FOOTER_FACEID_IPHONE" : "SETTINGS_ABOUT_FOOTER_IPHONE"
        }
        return "SETTINGS_ABOUT_FOOTER_IPAD"
    }
    
    var body: some View {
        CustomList(title: "WALLET_&_APPLE_PAY".localized(path: path, table: walletTable), topPadding: true) {
            if UIDevice.IsSimulator {
                PermissionsView(
                    appName: "WALLET_&_APPLE_PAY".localized(path: path, table: walletTable),
                    cellular: false,
                    liveActivityToggle: true,
                    location: false,
                    siri: true,
                    cellularEnabled: $cellularEnabled
                )
            } else {
                PermissionsView(
                    appName: "WALLET_&_APPLE_PAY".localized(path: path, table: walletTable),
                    cellular: true,
                    liveActivityToggle: true,
                    location: false,
                    siri: true,
                    cellularEnabled: $cellularEnabled
                )
            }
            
            if !UIDevice.IsSimulator {
                Section {
                    SLink(
                        "SETTINGS_APPLE_PAY_DEFAULTS_TITLE".localized(path: path, table: payTable),
                        icon: "com.apple.graphic-icon.account.payment",
                        subtitle: "SETTINGS_APPLE_PAY_DEFAULTS_SUBTITLE".localized(path: path, table: payTable)
                    ) {}
                }
                
                Section {
                    Toggle("SE_STORAGE_APPLET_CATEGORY_APLET_TYPE_PTC".localized(path: path, table: payTable),
                        isOn: $appleCashEnabled.animation())
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
                        Text(.init(
                                appleCashFooter.localized(path: path, table: payTable) +
                                " [\("APPLE_PAY_PRIVACY".localized(path: path, table: walletTable))](#)")
                        )
                    }
                }
            }
            
            SLink(
                "FPAN_ADD_TO_APPLE_PAY_TITLE".localized(path: path, table: payTable),
                status: "0"
            ) {}
            
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
