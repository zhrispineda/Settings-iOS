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
    @State private var showingSheet = false
    let table = "PasswordsSettings"
    
    enum AccountDisplayMode {
        case titles
        case websites
    }
    
    var body: some View {
        CustomList(title: "Passwords", topPadding: true) {
            if UIDevice.IsSimulator {
                PermissionsView(appName: "Passwords", cellular: false, location: false, notifications: false, cellularEnabled: .constant(true))
            } else {
                PermissionsView(appName: "Passwords", location: false, cellularEnabled: .constant(true))
                
                //LanguageView()
            }
            
            Section {
                Picker("Show Accounts As".localize(table: table), selection: $showAccountsLabel) {
                    Text("Titles", tableName: table).tag(AccountDisplayMode.titles)
                    Text("Websites", tableName: table).tag(AccountDisplayMode.websites)
                }
            }
            
            Section {
                Toggle("Detect Compromised Passwords".localize(table: table), isOn: $detectCompromisedPasswordsEnabled)
            } footer: {
                if UIDevice.iPhone {
                    Text(.init("iPhone can securely monitor your passwords and alert you if they appear in known data leaks. %passwords-privacy-link%".localize(table: table).replacingOccurrences(of: "0x0asswords-privacy-link", with: "[\("BUTTON_TITLE".localize(table: "Passwords"))](pref://)")))
                } else if UIDevice.iPad {
                    Text(.init("iPad can securely monitor your passwords and alert you if they appear in known data leaks. %passwords-privacy-link%".localize(table: table).replacingOccurrences(of: "0x0asswords-privacy-link", with: "[\("BUTTON_TITLE".localize(table: "Passwords"))](pref://)")))
                }
            }
            
            Section {
                Toggle("Suggest Strong Passwords".localize(table: table), isOn: $suggestStrongPasswords)
            } footer: {
                Text("Automatically suggest unique, strong passwords when creating accounts or changing passwords in Safari and other apps.", tableName: table)
            }
            
            Section {
                Toggle("Allow Automatic Passkey Upgrades".localize(table: table), isOn: $autoPasskeyUpgrades)
            } footer: {
                Text(.init("Allow websites and apps to automatically upgrade existing accounts to use passkeys when available. Passwords saved for upgraded accounts will not be affected. %learn-more-link%".localize(table: table).replacingOccurrences(of: "0.000000E+00arn-more-link", with: "[\("Learn more about passkeys…".localize(table: table))](#)")))
            }
            
            Section {
                Button("Open Passwords".localize(table: table)) {}
                Button("View AutoFill Settings".localize(table: table)) {}
            }
        }
        .onOpenURL { url in
            if url.scheme == "pref" {
                showingSheet = true
            }
        }
        .sheet(isPresented: $showingSheet) {
            OnBoardingKitView(bundleID: "com.apple.onboarding.passwords")
                .ignoresSafeArea()
        }
    }
}

#Preview {
    NavigationStack {
        PasswordsView()
    }
}
