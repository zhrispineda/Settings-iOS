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
    @State private var deleteAfterUseEnabled = false
    @State private var selected = "Passwords"
    let options = ["Passwords"]
    
    var body: some View {
        CustomList(title: "AutoFill & Passwords", topPadding: true) {
            Section {
                Toggle("AutoFill Passwords and Passkeys", isOn: $autoFillPasswordPasskeysEnabled)
            } footer: {
                Text("Automatically suggest passwords, passkeys, and verification codes when signing in to apps and websites.")
            }
            
            Section {
                IconToggle("Passwords", isOn: $keychainEnabled, icon: "com.apple.Passwords", subtitle: "Passkeys, passwords, and codes")
            } header: {
                Text("AutoFill from:")
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
                    Picker("", selection: $selected) {
                        ForEach(options, id: \.self) { option in
                            HStack {
                                Text(" " + option)
                                Image(uiImage: UIImage.icon(forBundleID: "com.apple.Passwords")!)
                            }
                        }
                    }
                    .frame(maxHeight: 30)
                    .labelsHidden()
                    .pickerStyle(.menu)
                    .tint(.primary)
                }
            } footer: {
                Text("Open verification code setup links and QR codes with this app.")
            }
        }
    }
}

#Preview {
    NavigationStack {
        AutoFillPasswordsView()
    }
}
