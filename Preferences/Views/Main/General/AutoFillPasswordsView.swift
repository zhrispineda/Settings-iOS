//
//  AutoFillPasswordsView.swift
//  Preferences
//
//  Settings > General > AutoFill & Passwords
//

import SwiftUI

struct AutoFillPasswordsView: View {
    // Variables
    @State private var autoFillPasswordPasskeysEnabled = true
    @State private var keychainEnabled = true
    @State private var deleteAfterUseEnabled = true
    
    var body: some View {
        CustomList(title: "AutoFill & Passwords") {
            Section {
                Toggle("AutoFill Passwords and Passkeys", isOn: $autoFillPasswordPasskeysEnabled)
            } footer: {
                Text("Automatically suggest passwords, passkeys, and verification codes when signing in to apps and websites.")
            }
            
            Section {
                IconToggle(enabled: $keychainEnabled, color: .gray, icon: "applePasswords", title: "Passwords", subtitle: "Passkeys, passwords, and codes")
            } header: {
                Text("AutoFill From:")
            }
            
            Section {
                Toggle("Delete After Use", isOn: $deleteAfterUseEnabled)
            } header: {
                Text("Verification Codes")
            } footer: {
                Text("Automatically delete verification codes in Messages and Mail after they are used.")
            }
            
            Section {
                HStack {
                    Text("Set Up Codes In")
                    Spacer()
                    Text("Passwords")
                        .foregroundStyle(.secondary)
                }
            } footer: {
                Text("Open verification code setup links and QR code with this app.")
            }
        }
    }
}

#Preview {
    NavigationStack {
        AutoFillPasswordsView()
    }
}
