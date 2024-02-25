//
//  SafariAdvancedView.swift
//  Preferences
//
//  Settings > Safari > Advanced
//

import SwiftUI

struct SafariAdvancedView: View {
    // Variables
    @State private var blockAllCookiesEnabled = false
    @State private var showingBlockCookiesAlert = false
    @State private var privacyPreservingAdMeasurementEnabled = true
    @State private var checkForApplePayEnabled = true
    @State private var javaScriptEnabled = true
    
    var body: some View {
        CustomList(title: "Advanced") {
            Section {
                NavigationLink("Website Data", destination: {})
            }
            
            Section(content: {
                CustomNavigationLink(title: "Advanced Tracking and Fingerprinting Protection", status: "Private Browsing", destination: EmptyView())
                Toggle("Block All Cookies", isOn: $blockAllCookiesEnabled)
                    .onChange(of: blockAllCookiesEnabled, {
                        showingBlockCookiesAlert = blockAllCookiesEnabled
                    })
                    .alert("Are you sure you want to\nblock all cookies?", isPresented: $showingBlockCookiesAlert) {
                        Button("Block All", role: .destructive) {}
                        Button("Cancel", role: .cancel) { blockAllCookiesEnabled = false }
                    } message: {
                        Text("Websites may not work if you do this. It will remove existing cookies and website data. Safari will quit and your tabs will be reloaded.")
                    }
                Toggle("Privacy Preseving Ad Measurement", isOn: $privacyPreservingAdMeasurementEnabled)
                Toggle("Check for Apple Pay", isOn: $checkForApplePayEnabled)
            }, header: {
                Text("Privacy")
            }, footer: {
                Text("Allow websites to check if Apple Pay is enabled and if you have an Apple Card account.\n[About Safari & Privacy...](#)")
            })
            
            Section {
                Toggle("JavaScript", isOn: $javaScriptEnabled)
            }
            
            Section {
                NavigationLink("Feature Flags", destination: FeatureFlagsView())
            }
        }
    }
}

#Preview {
    NavigationStack {
        SafariAdvancedView()
    }
}
