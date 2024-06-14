//
//  PasswordOptionsView.swift
//  Preferences
//
//  Settings > Passwords > Password Options
//

import SwiftUI

struct PasswordOptionsView: View {
    // Variables
    @State private var autoFillPasswordPasskeysEnabled = true
    @State private var keychainEnabled = true
    @State private var deleteAfterUseEnabled = false
    
    var body: some View {
        CustomList(title: "Password Options") {
            Section {
                Toggle("AutoFill Passwords and Passkeys", isOn: $autoFillPasswordPasskeysEnabled)
            } footer: {
                Text("AutoFill helps you sign into apps and websites.")
            }
            
            Section {
                IconToggle(enabled: $keychainEnabled, color: .gray, icon: "key.fill", title: "Keychain")
            } header: {
                Text("Use Passwords and Passkeys From:")
            }
            
            Section {
                Toggle("Delete After Use", isOn: $deleteAfterUseEnabled)
            } header: {
                Text("Verification Codes")
            } footer: {
                Text("Automatically delete verification codes in Messages and Mail after they are used.")
            }
        }
    }
}

#Preview {
    PasswordOptionsView()
}
