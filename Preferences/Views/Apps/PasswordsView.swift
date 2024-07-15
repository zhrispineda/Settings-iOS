//
//  PasswordsView.swift
//  Preferences
//
//  Settings > Apps > Passwords
//

import SwiftUI

struct PasswordsView: View {
    // Variables
    @State private var detectCompromisedPasswordsEnabled = true
    @State private var showAccountsLabel: AccountDisplayMode = .titles
    @State private var suggestStrongPasswords = true
    @State private var autoPasskeyUpgrades = true
    
    enum AccountDisplayMode {
        case titles
        case websites
    }
    
    var body: some View {
        CustomList(title: "Passwords") {
            if UIDevice.isSimulator {
                PermissionsView(appName: "Passwords", cellular: false, location: false, notifications: false, cellularEnabled: .constant(true))
            } else {
                PermissionsView(appName: "Passwords", location: false, cellularEnabled: .constant(true))
                
                LanguageView()
            }
            
            Section {
                Picker("Show Accounts As", selection: $showAccountsLabel) {
                    Text("Titles").tag(AccountDisplayMode.titles)
                    Text("Websites").tag(AccountDisplayMode.websites)
                }
            }
            
            Section {
                Toggle("Detect Compromised Passwords", isOn: $detectCompromisedPasswordsEnabled)
            } footer: {
                Text("\(UIDevice.current.model) can securely monitor your passwords and alert you if they appear in known data leaks. [About Passwords & Privacy...](#)")
            }
            
            Section {
                Toggle("Suggest Strong Passwords", isOn: $suggestStrongPasswords)
            } footer: {
                Text("Automatically suggest unique, strong passwords when creating accounts or changing passwords in Safari and other apps.")
            }
            
            Section {
                Toggle("Allow Automatic Passkey Upgrades", isOn: $autoPasskeyUpgrades)
            } footer: {
                Text("Allow websites and apps to automatically upgrade existing accounts to use passkeys when available. Passwords saved for upgraded accounts will not be affected. [Learn more about passkeys...](#)")
            }
            
            Section {
                Button("Open Passwords") {}
                Button("View AutoFill Settings") {}
            }
        }
    }
}

#Preview {
    NavigationStack {
        PasswordsView()
    }
}
