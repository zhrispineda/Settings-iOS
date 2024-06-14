//
//  TVProviderView.swift
//  Preferences
//
//  Settings > Developer > TV Provider
//

import SwiftUI

struct TVProviderView: View {
    // Variables
    @State private var cacheBusterEnabled = false
    @State private var disableTimeoutsEnabled = false
    @State private var simluateExpiredTokenEnabled = false
    
    var body: some View {
        CustomList(title: "TV Provider") {
            Section {
                Toggle("Cache Buster", isOn: $cacheBusterEnabled)
            } header: {
                Text("\n\nOptions")
            } footer: {
                Text("When enabled, the query parameter “cachebuster“ will be added to development TV Provider Auth URLs.")
            }
            
            Section {
                Toggle("Disable Timeouts", isOn: $disableTimeoutsEnabled)
            } footer: {
                Text("When enabled, the defauzlt callback timeouts will be disabled in development TV Provider authentication contexts.")
            }
            
            Section {
                Toggle("Simulate Expired Token", isOn: $disableTimeoutsEnabled)
            } footer: {
                Text("When enabled, authentication tokens provided to applications and the JavaScript authentication context will have an expiration date in the past.")
            }
            
            Section {
                Button {} label: {
                    Text("Add TV Provider")
                        .frame(maxWidth: .infinity)
                }
            } header: {
                Text("Development TV Providers")
            }
        }
    }
}

#Preview {
    TVProviderView()
}
