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
        CustomList(title: "APPLE_ID_REBRAND".localize(table: table)) {
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
                SLink("SPYGLASS_SPECIFIER_PAYMENT_AND_SHIPPING".localize(table: table), color: .gray, icon: "person.text.rectangle.fill") {}
                SLink("SPYGLASS_SPECIFIER_SIGNIN_AND_SECURITY".localize(table: table), color: .gray, icon: "custom.key.shield.fill") {}
            }
            
            Section {
                Button {} label: {
                    SLink("ICLOUD_SERVICE_STORAGE_TITLE".localize(table: table), icon: "iCloud", status: "Set Up") {}
                        .foregroundStyle(Color(.label))
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
