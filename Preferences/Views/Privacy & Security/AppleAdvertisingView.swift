//
//  AppleAdvertisingView.swift
//  Preferences
//
//  Settings > Privacy & Security > Apple Advertising
//

import SwiftUI

struct AppleAdvertisingView: View {
    var body: some View {
        CustomList(title: "Apple Advertising") {
            Section {} header: {
                Text("\n\nApple-Delivered Advertising")
            } footer: {
                Text("The Apple advertising platform does not track you. It is designed to protect your privacy and does not follow you across apps and websites owned by other companies. You have control over how Apple uses your information. [About Apple Advertising & Privacy...](#)")
            }
            
            Section {
                Button("View Ad Targeting Information") {}
            } footer: {
                Text("Ad targeting information is used by Apple to personalize your ad experience.")
            }
            
            Section {} footer: {
                Text("After the App Store, Apple News, or Stocks asks your permission to receive personalized ads, a setting will appear here reflecting your choice.")
            }
        }
    }
}

#Preview {
    NavigationStack {
        AppleAdvertisingView()
    }
}
