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
    
    var body: some View {
        CustomList(title: "Passwords") {
            Section {
                Toggle("Detect Leaked Passwords", isOn: $detectCompromisedPasswordsEnabled)
            } footer: {
                Text("\(Device().model) can securely monitor your passwords and alert you if they appear in known data leaks. [About Passwords & Privacy...](#)")
            }
        }
    }
}

#Preview {
    NavigationStack {
        PasswordsView()
    }
}
