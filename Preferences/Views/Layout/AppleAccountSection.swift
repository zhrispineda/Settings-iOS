//
//  AppleAccountSection.swift
//  Preferences
//
//  Settings
//

import SwiftUI

/// Apple Account Button
struct AppleAccountSection: View {
    var body: some View {
        HStack {
            Image("appleAccount")
                .resizable()
                .frame(width: 60, height: 60)
                .offset(x: -2)
            VStack(alignment: .leading, spacing: 3) {
                Text("Apple Account")
                    .bold()
                    .font(.title3)
                    .foregroundStyle(Color["Label"])
                Text("Sign in to access your iCloud data, the App Store, Apple services, and more.")
                    .foregroundStyle(.secondary)
                    .font(.footnote)
            }
            .padding(.leading, 0)
        }
        .foregroundStyle(Color["Label"])
    }
}

#Preview {
    AppleAccountSection()
}
