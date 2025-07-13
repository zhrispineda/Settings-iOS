//
//  AppleAccountSection.swift
//  Preferences
//
//  Settings
//

import SwiftUI

/// Apple Account Button Label
struct AppleAccountSection: View {
    let path = "/System/Library/PrivateFrameworks/AppleAccountUI.framework"
    
    var body: some View {
        HStack {
            if let asset = UIImage.asset(path: path, name: "AppleAccount_Icon_Blue") {
                Image(uiImage: asset)
                    .resizable()
                    .frame(width: 60, height: 60)
                    .offset(x: -2)
            }
            
            VStack(alignment: .leading, spacing: 3) {
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
