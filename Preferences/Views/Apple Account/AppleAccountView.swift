//
//  AppleAccountView.swift
//  Preferences
//
//  Settings > Apple Account
//

import SwiftUI

struct AppleAccountView: View {
    var body: some View {
        CustomList(title: "Apple Account") {
            VStack {
                Button {} label: {
                    Image(_internalSystemName: "person.crop.circle.fill")
                        .font(.system(size: 90))
                        .foregroundStyle(.white, .gray.gradient)
                }
                .buttonStyle(.plain)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .listRowBackground(Color.clear)
            
            Section {
                SettingsLink(color: .gray, icon: "person.text.rectangle.fill", id: "Personal Information") {}
                SettingsLink(color: .gray, icon: "custom.key.shield.fill", id: "Sign-In & Security") {}
            }
            
            Section {
                Button {} label: {
                    SettingsLink(icon: "iCloud", id: "iCloud", status: "Set Up") {}
                        .foregroundStyle(Color["Label"])
                }
            }
            
            Button("Sign Out") {}
                .tint(.red)
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}

#Preview {
    NavigationStack {
        AppleAccountView()
    }
}
