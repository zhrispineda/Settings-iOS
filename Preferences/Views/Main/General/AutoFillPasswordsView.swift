//
//  AutoFillPasswordsView.swift
//  Preferences
//
//  Settings > General > AutoFill & Passwords
//

import SwiftUI

struct AutoFillPasswordsView: View {
    @State private var autoFillPasswordPasskeysEnabled = true
    @State private var keychainEnabled = true
    @State private var deleteAfterUseEnabled = false
    @State private var selected = "Passwords"
    let options = ["Passwords"]
    let path = "/System/Library/PrivateFrameworks/PasswordManagerUI.framework"
    
    var body: some View {
        CustomList(title: "AutoFill & Passwords (navigation title)".localized(path: path), topPadding: true) {
            Section {
                Toggle("AutoFill Passwords and Passkeys".localized(path: path), isOn: $autoFillPasswordPasskeysEnabled)
            } footer: {
                Text("Automatically suggest passwords, passkeys, and verification codes when signing in to apps and websites.".localized(path: path))
            }
            
            Section {
                IconToggle(
                    "Passwords".localized(path: path),
                    isOn: $keychainEnabled,
                    icon: "com.apple.Passwords",
                    subtitle: "Passkeys, passwords, and codes".localized(path: path))
            } header: {
                Text("AutoFill from:".localized(path: path))
            }
            
            Section {
                Toggle("Delete After Use".localized(path: path), isOn: $deleteAfterUseEnabled)
            } header: {
                Text("Verification Codes".localized(path: path))
            } footer: {
                Text("Automatically delete verification codes in Messages and Mail after they are used.".localized(path: path))
            }
            
            Section {
                HStack {
                    Text("Set Up Codes In".localized(path: path))
                    Spacer()
                    Picker("", selection: $selected) {
                        ForEach(options, id: \.self) { option in
                            HStack {
                                Text(" " + option.localized(path: path))
                                Image(uiImage: UIImage.icon(forBundleID: "com.apple.Passwords")!)
                            }
                        }
                    }
                    .frame(maxHeight: 30)
                    .labelsHidden()
                    .pickerStyle(.menu)
                    .tint(.secondary)
                }
            } footer: {
                Text("“%@” will be used to open links and QR codes for setting up verification codes.".localized(path: path, selected.localized(path: path)))
            }
        }
    }
}

#Preview {
    NavigationStack {
        AutoFillPasswordsView()
    }
}
