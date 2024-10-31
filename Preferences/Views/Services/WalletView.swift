//
//  WalletView.swift
//  Preferences
//
//  Settings > Wallet/Wallet & Apple Pay
//

import SwiftUI

struct WalletView: View {
    // Variables
    @State private var cellularEnabled: Bool = true
    
    @State private var appleCashEnabled = true
    @State private var doubleClickButtonEnabled = true
    @State private var hideExpiredPassesEnabled = true
    
    @State private var payLaterEnabled = true
    @State private var rewardsEnabled = true
    @State private var compatibleCardsEnabled = false
    @State private var addOrdersWalletEnabled = true
    @State private var orderNotificationsEnabled = true
    @State private var otherPayLaterOptionsEnabled = true
    
    let table = "PassKit"
    let nfcTable = "ContactlessAndCredentialSettings_Localizable"
    let offerTable = "PaymentOffers_Localizable"
    let orderTable = "OrderManagement_Localizable"
    let payTable = "Payment_Localizable"
    let peerTable = "PeerPayment_Localizable"
    let virtualTable = "VirtualCard_Localizable"
    let walletTable = "WalletSettings_Localizable"
    
    var body: some View {
        CustomList(title: "WALLET_&_APPLE_PAY".localize(table: walletTable), topPadding: true) {
            if UIDevice.iPhone {
                if UIDevice.IsSimulator {
                    PermissionsView(appName: "PASS_DETAILS_WALLET".localize(table: payTable), cellular: false, location: false, cellularEnabled: $cellularEnabled)
                } else {
                    PermissionsView(appName: "WALLET_&_APPLE_PAY".localize(table: walletTable), liveActivityToggle: true, location: false, cellularEnabled: $cellularEnabled)
                }
            }
            
            if !UIDevice.IsSimulator {
                Section {
                    Toggle("SE_STORAGE_APPLET_CATEGORY_APLET_TYPE_PTC".localize(table: payTable), isOn: $appleCashEnabled.animation())
                } footer: {
                    if UIDevice.iPhone {
                        Text("PEER_PAYMENT_REGISTRATION_FOOTER_TEXT_IPHONE", tableName: peerTable)
                    } else if UIDevice.iPad {
                        Text("PEER_PAYMENT_REGISTRATION_FOOTER_TEXT_IPAD", tableName: peerTable)
                    }
                }
                
                Section {
                    if appleCashEnabled {
                        NavigationLink(destination: EmptyView()) {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("SE_STORAGE_APPLET_CATEGORY_APLET_TYPE_PTC", tableName: payTable)
                                Text("PEER_PAYMENT_SETTINGS_REGISTRATION_NOT_SET_UP", tableName: peerTable)
                                    .font(.caption)
                            }
                        }
                        .alignmentGuide(.listRowSeparatorLeading) { ViewDimensions in
                            return -20
                        }
                    }
                    Button("PEER_PAYMENT_ADD_CARD_BUTTON_TITLE".localize(table: peerTable)) {}
                } header: {
                    Text("SETTINGS_PAYMENT_CARDS_GROUP", tableName: payTable)
                } footer: {
                    if !appleCashEnabled {
                        Text(UIDevice.PearlIDCapability ? "SETTINGS_ABOUT_FOOTER_IPHONE" : "SETTINGS_ABOUT_FOOTER_FACEID_IPAD", tableName: payTable) + Text("[\("APPLE_PAY_PRIVACY".localize(table: walletTable))](#)")
                    }
                }
                
                if UIDevice.iPhone {
                    Section {
                        Toggle(UIDevice.HomeButtonCapability ? "DOUBLE_CLICK_HOME_BUTTON".localize(table: nfcTable) : "DOUBLE_CLICK_SIDE_BUTTON".localize(table: nfcTable), isOn: $doubleClickButtonEnabled)
                    } footer: {
                        Text(UIDevice.HomeButtonCapability ? "DOUBLE_CLICK_HOME_BUTTON_FOOTER" : "DOUBLE_CLICK_SIDE_BUTTON_FOOTER", tableName: nfcTable)
                    }
                }
            }
            
            Section {
                Toggle("ALLOW_EXPIRED_PASSES_TITLE".localize(table: table), isOn: $hideExpiredPassesEnabled)
            }
            
            if !UIDevice.IsSimulator && UIDevice.iPhone {
                Section {
                    CustomNavigationLink(title: "SETTINGS_EXPRESS_TRANSIT_CARDS_SECTION_HEADER".localize(table: payTable), status: "NONE".localize(table: payTable), destination: EmptyView())
                } header: {
                    Text("SETTINGS_EXPRESS_TRANSIT_CARD_CATEGORY_SECTION_HEADER", tableName: payTable)
                } footer: {
                    Text(UIDevice.PearlIDCapability ? "SETTINGS_EXPRESS_TRANSIT_SECTION_FOOTER_IPHONE_LPEM_FACEID" : "SETTINGS_EXPRESS_TRANSIT_SECTION_FOOTER_IPHONE_LPEM_TOUCHID", tableName: payTable)
                }
                
                if appleCashEnabled {
                    Section {
                        NavigationLink("SETTINGS_TRANSACTION_DEFAULTS_PAYMENT_CARD".localize(table: payTable)) {}
                            .disabled(true)
                        NavigationLink("SETTINGS_OPTIONS_SHIPPING_ADDRESS_VC_TITLE".localize(table: payTable)) {}
                        NavigationLink("SETTINGS_TRANSACTION_DEFAULTS_EMAIL".localize(table: payTable)) {}
                        NavigationLink("SETTINGS_TRANSACTION_DEFAULTS_PHONE".localize(table: payTable)) {}
                    } header: {
                        Text("SETTINGS_TRANSACTION_DEFAULTS_GROUP", tableName: payTable)
                    } footer: {
                        Text("SETTINGS_TRANSACTION_DEFAULTS_FOOTER", tableName: payTable) + Text(" [\("APPLE_PAY_PRIVACY".localize(table: walletTable))](#)")
                    }
                }
            }
            
            Section {
                Toggle("PAY_LATER_BADGE_TEXT".localize(table: offerTable), isOn: $payLaterEnabled)
                Toggle("Rewards", isOn: $rewardsEnabled)
            } header: {
                Text("CARD_BENEFITS_HEADER", tableName: offerTable)
            } footer: {
                Text("CARD_BENEFITS_FOOTER", tableName: offerTable)
            }
            
            Section {
                Toggle("ALLOW_ONLINE_PAYMENTS_TITLE".localize(table: virtualTable), isOn: $compatibleCardsEnabled)
            } header: {
                Text("ALLOW_ONLINE_PAYMENTS_HEADER", tableName: virtualTable)
            } footer: {
                Text("ALLOW_ONLINE_PAYMENTS_FOOTER", tableName: virtualTable)
            }
            
            if !UIDevice.IsSimulator {
                if appleCashEnabled {
                    Section {
                        Toggle("ALLOW_ORDER_MANAGEMENT_TITLE".localize(table: orderTable), isOn: $addOrdersWalletEnabled)
                    } header: {
                        Text("ALLOW_ORDER_MANAGEMENT_HEADER", tableName: orderTable)
                    } footer: {
                        Text(UIDevice.iPhone ? "ALLOW_ORDER_MANAGEMENT_FOOTER_IPHONE" : "ALLOW_ORDER_MANAGEMENT_FOOTER_IPAD", tableName: orderTable)
                    }
                }
                
                Section {
                    Toggle("ALLOW_ORDER_MANAGEMENT_NOTIFICATIONS_TITLE".localize(table: orderTable), isOn: $orderNotificationsEnabled)
                }
            }
            
            Section {
                Toggle("Other Pay Later Options", isOn: $otherPayLaterOptionsEnabled)
            } footer: {
                Text("See additional pay later services not associated with your cards in Wallet when you check out with Apple Pay.")
            }
        }
    }
}

#Preview {
    NavigationStack {
        WalletView()
    }
}
