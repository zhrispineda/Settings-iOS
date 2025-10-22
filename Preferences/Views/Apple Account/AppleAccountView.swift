//
//  AppleAccountView.swift
//  Preferences
//
//  Settings > Apple Account
//

import SwiftUI

struct AppleAccountView: View {
    let path = "/System/Library/PrivateFrameworks/AppleAccountUI.framework"
    
    var body: some View {
        CustomList(title: "APPLE_ID_REBRAND".localized(path: path)) {
            VStack {
                Button {} label: {
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 90))
                        .foregroundStyle(.white, .gray.gradient)
                }
                .buttonStyle(.plain)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .listRowBackground(Color.clear)
            
            Section {
                SLink("SPYGLASS_SPECIFIER_PAYMENT_AND_SHIPPING".localized(path: path), icon: "person.text.rectangle.fill") {}
                SLink("SPYGLASS_SPECIFIER_SIGNIN_AND_SECURITY".localized(path: path), icon: "custom.key.shield.fill") {}
            }
            
            Section {
                SLink("ICLOUD_SERVICE_STORAGE_TITLE".localized(path: path), icon: "iCloud", status: "Set Up") {}
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
