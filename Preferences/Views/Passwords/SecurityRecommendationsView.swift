//
//  SecurityRecommendationsView.swift
//  Preferences
//
//  Settings > Passwords > Security Recommendations
//

import SwiftUI

struct SecurityRecommendationsView: View {
    // Variables
    @State private var detectCompromisedPasswordsEnabled = true
    
    var body: some View {
        CustomList(title: "Security Recommendations") {
            Section(content: {
                Toggle("Detect Compromised Passwords", isOn: $detectCompromisedPasswordsEnabled)
            }, footer: {
                Text("iPhone can securely monitor your passwords and alert you if they appear in known data leaks. [About Passwords & Privacy...](#)")
            })
        }
    }
}

#Preview {
    SecurityRecommendationsView()
}
