//
//  AppleAccountView.swift
//  Preferences
//
//  Settings > Apple Account
//

import SwiftUI

struct AppleAccountView: View {
    // Variables
    let table = "AppleAccountUI"
    
    var body: some View {
        CustomList(title: "APPLE_ID_REBRAND") {
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
                SettingsLink(color: .gray, icon: "person.text.rectangle.fill", id: "SPYGLASS_SPECIFIER_PAYMENT_AND_SHIPPING".localize(table: table)) {}
                SettingsLink(color: .gray, icon: "custom.key.shield.fill", id: "SPYGLASS_SPECIFIER_SIGNIN_AND_SECURITY".localize(table: table)) {}
            }
            
            Section {
                Button {} label: {
                    SettingsLink(icon: "iCloud", id: "ICLOUD_SERVICE_STORAGE_TITLE".localize(table: table), status: "Set Up") {}
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
