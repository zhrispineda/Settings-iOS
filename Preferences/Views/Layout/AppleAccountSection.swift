//
//  AppleAccountSection.swift
//  Preferences
//
//  Settings
//

import SwiftUI

/// Apple Account Button Label
struct AppleAccountSection: View {
    var body: some View {
        HStack {
            Image(
                "AppleAccount_Icon_Blue",
                bundle: Bundle(path: "\(UIDevice.RuntimePath)/System/Library/PrivateFrameworks/AppleAccountUI.framework")
            )
            .resizable()
            .frame(width: 60, height: 60)
            
            VStack(alignment: .leading) {
                Text("Apple Account")
                    .bold()
                    .font(.title3)
                Text("Sign in to access your iCloud data, the App Store, Apple services, and more.")
                    .foregroundStyle(.secondary)
                    .font(.footnote)
            }
            .padding(.leading, 0)
        }
    }
}

#Preview {
    NavigationStack {
        List {
            AppleAccountSection()
        }
    }
}
