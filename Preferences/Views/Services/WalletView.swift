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
    
    var body: some View {
        CustomList(title: "Wallet & Apple Pay") {
            if Device().isPhone {
                if Configuration().isSimulator {
                    PermissionsView(appName: "Wallet", cellular: false, location: false, cellularEnabled: $cellularEnabled)
                } else {
                    PermissionsView(appName: "Wallet", liveActivityToggle: true, location: false, cellularEnabled: $cellularEnabled)
                }
            }
            
            if !Configuration().isSimulator {
                Section {
                    Toggle("Apple Cash", isOn: $appleCashEnabled.animation())
                } footer: {
                    Text("Enable sending and receiving money on this \(Device().model).")
                }
                
                Section {
                    if appleCashEnabled {
                        NavigationLink(destination: EmptyView()) {
                            HStack {
                                Image(systemName: "creditcard.fill")
                                    .font(.system(size: 40))
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("Apple Cash")
                                    Text("Balance: $0")
                                        .font(.caption)
                                }
                            }
                        }
                        .alignmentGuide(.listRowSeparatorLeading) { ViewDimensions in
                            return -20
                        }
                    }
                    Button("Add Card") {}
                } header: {
                    Text("Payment Cards")
                } footer: {
                    if !appleCashEnabled {
                        Text("Pay with \(Device().hasFaceAuth ? "Face" : "Touch") ID using Apple Pay. Make purchases in apps and on the web without entering your card and shipping details. [See how your data is managed...](#)")
                    }
                }
                
                Section {
                    Toggle("Double-Click \(Device().hasHomeButton ? "Home" : "Side") Button", isOn: $doubleClickButtonEnabled)
                } footer: {
                    Text("Get cards and passes ready \(Device().hasHomeButton ? "from the lock screen by double-clicking the home" : "at any time by double-clicking the side") button.")
                }
            }
            
            Section {
                Toggle("Hide Expired Passes", isOn: $hideExpiredPassesEnabled)
            }
            
            if !Configuration().isSimulator && Device().isPhone {
                Section {
                    CustomNavigationLink(title: "Express Transit Card", status: "None", destination: EmptyView())
                } header: {
                    Text("Transit Cards")
                } footer: {
                    Text("Your selected Express Transit card works automatically, without requiring \(Device().hasFaceAuth ? "Face" : "Touch") ID or your passcode, and may be available when your iPhone needs to be charged.")
                }
                
                if appleCashEnabled {
                    Section {
                        NavigationLink("Default Card") {}
                            .disabled(true)
                        NavigationLink("Shipping Address") {}
                        NavigationLink("Email") {}
                        NavigationLink("Phone") {}
                    } header: {
                        Text("Transaction Defaults")
                    } footer: {
                        Text("Addresses and payment options can be changed at the time of transaction. [See how your data is managed...](#)")
                    }
                }
            }
            
            Section {
                Toggle("Pay Later", isOn: $payLaterEnabled)
                Toggle("Rewards", isOn: $rewardsEnabled)
            } header: {
                Text("Show Card Benefits")
            } footer: {
                Text("See available rewards and payment options from your cards in Wallet when you check out with Apple Pay.")
            }
            
            Section {
                Toggle("Compatible Cards", isOn: $compatibleCardsEnabled)
            } header: {
                Text("Online Payments")
            } footer: {
                Text("Verifies that your saved cards in Safari AutoFill are compatible with Apple Pay and allows you to use them in Wallet.")
            }
            
            if !Configuration().isSimulator {
                if appleCashEnabled {
                    Section {
                        Toggle("Add Orders to Wallet", isOn: $addOrdersWalletEnabled)
                    } header: {
                        Text("Order Tracking")
                    } footer: {
                        Text("Orders from participating merchants will be automatically added to Wallet\(Device().isPhone ? "." : "on your iPhone.")")
                    }
                }
                
                Section {
                    Toggle("Order Notifications", isOn: $orderNotificationsEnabled)
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
