//
//  PasswordsView.swift
//  Preferences
//
//  Settings > Apps > Passwords
//

import SwiftUI

struct PasswordsView: View {
    @State private var detectCompromisedPasswordsEnabled = true
    @State private var showAccountsLabel: AccountDisplayMode = .titles
    @State private var savePasswordsLabel: PasswordDisplayMode = .ask
    @State private var suggestStrongPasswords = true
    @State private var autoPasskeyUpgrades = true
    @State private var showingSheet = false
    let privacy = "/System/Library/OnBoardingBundles/com.apple.onboarding.passwords.bundle"
    let path = "/System/Library/PreferenceBundles/PasswordsSettings.bundle"
    
    enum AccountDisplayMode {
        case titles
        case websites
    }
    
    enum PasswordDisplayMode {
        case ask
        case doNotAsk
    }
    
    var body: some View {
        CustomList(title: "Passwords (app name)".localized(path: path), topPadding: true) {
            if UIDevice.IsSimulator {
                PermissionsView(appName: "Passwords (app name)".localized(path: path), cellular: false, location: false, notifications: false, cellularEnabled: .constant(true))
            } else {
                PermissionsView(appName: "Passwords (app name)".localized(path: path), cellular: false, location: false, notifications: false, cellularEnabled: .constant(true))
            }
            
            Section {
                Picker("Show Accounts As".localized(path: path), selection: $showAccountsLabel) {
                    Text("Titles".localized(path: path)).tag(AccountDisplayMode.titles)
                    Text("Websites (App Settings Picker Item)".localized(path: path)).tag(AccountDisplayMode.websites)
                }
            }
            
            Section {
                Picker("Save Passwords".localized(path: path), selection: $savePasswordsLabel) {
                    Text("Ask When Signing In".localized(path: path)).tag(PasswordDisplayMode.ask)
                    Text("Do Not Ask When Signing In".localized(path: path)).tag(PasswordDisplayMode.doNotAsk)
                }
            }
            
            Section {
                Toggle("Detect Compromised Passwords".localized(path: path), isOn: $detectCompromisedPasswordsEnabled)
            } footer: {
                if UIDevice.iPhone {
                    Text(.init("iPhone can securely monitor your passwords and alert you if they appear in known data leaks. %passwords-privacy-link%".localized(path: path).replacing("0x0asswords-privacy-link", with: "[\("BUTTON_TITLE".localized(path: privacy, table: "Passwords"))](pref://)")))
                } else if UIDevice.iPad {
                    Text(.init("iPad can securely monitor your passwords and alert you if they appear in known data leaks. %passwords-privacy-link%".localized(path: path).replacing("0x0asswords-privacy-link", with: "[\("BUTTON_TITLE".localized(path: privacy, table: "Passwords")))](pref://)")))
                }
            }
            
            Section {
                Toggle("Suggest Strong Passwords".localized(path: path), isOn: $suggestStrongPasswords)
            } footer: {
                Text("Automatically suggest unique, strong passwords when creating accounts or changing passwords in Safari and other apps.".localized(path: path))
            }
            
            Section {
                Toggle("Allow Automatic Passkey Upgrades".localized(path: path), isOn: $autoPasskeyUpgrades)
            } footer: {
                Text(.init("Allow websites and apps to automatically upgrade existing accounts to use passkeys when available. Passwords saved for upgraded accounts will not be affected. %learn-more-link%".localized(path: path).replacing("0.000000E+00arn-more-link", with: "[\("Learn more about passkeys…".localized(path: path))](#)")))
            }
            
            Section {
                Button("Open Passwords".localized(path: path)) {}
                Button("View AutoFill Settings".localized(path: path)) {}
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
