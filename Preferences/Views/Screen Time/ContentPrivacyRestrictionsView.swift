//
//  ContentPrivacyRestrictionsView.swift
//  Preferences
//
//  Settings > Screen Time > Content & Privacy Restrictions
//

import SwiftUI

struct ContentPrivacyRestrictionsView: View {
    // Variables
    @State private var contentPrivacyRestrictionsEnabled = false
    
    var body: some View {
        CustomList(title: "Content & Privacy Restrictions") {
            Section {
                Toggle("Content & Privacy Restrictions", isOn: $contentPrivacyRestrictionsEnabled)
            }
            
            Section {
                NavigationLink("App Installations & Purchases", destination: AppInstallationsPurchasesView())
                NavigationLink("Allowed Apps", destination: AllowedAppsView())
                NavigationLink("Content Restrictions", destination: ContentRestrictionsView())
            }
            .disabled(!contentPrivacyRestrictionsEnabled)
            
            Section(content: {
                CustomNavigationLink(title: "Location Services", status: "Allow", destination: RestrictionsLocationServicesView())
                CustomNavigationLink(title: "Contacts", status: "Allow", destination: EmptyView())
                CustomNavigationLink(title: "Calendars", status: "Allow", destination: EmptyView())
                CustomNavigationLink(title: "Reminders", status: "Allow", destination: EmptyView())
                CustomNavigationLink(title: "Photos", status: "Allow", destination: EmptyView())
                CustomNavigationLink(title: "Share My Location", status: "Allow", destination: EmptyView())
                CustomNavigationLink(title: "Bluetooth Sharing", status: "Allow", destination: EmptyView())
                CustomNavigationLink(title: "Microphone", status: "Allow", destination: EmptyView())
                CustomNavigationLink(title: "Speech Recognition", status: "Allow", destination: EmptyView())
                CustomNavigationLink(title: "Apple Advertising", status: "Allow", destination: EmptyView())
                CustomNavigationLink(title: "Allow Apps to Request to Track", status: "Allow", destination: EmptyView())
                CustomNavigationLink(title: "Media & Apple Music", status: "Allow", destination: EmptyView())
            }, header: {
                Text("Privacy")
            })
            .disabled(!contentPrivacyRestrictionsEnabled)
            
            Section(content: {
                CustomNavigationLink(title: "Passcode Changes", status: "Allow", destination: AllowDenySelection(title: "Passcode Changes"))
                CustomNavigationLink(title: "Account Changes", status: "Allow", destination: AllowDenySelection(title: "Account Changes"))
                CustomNavigationLink(title: "Cellular Data Changes", status: "Allow", destination: AllowDenySelection(title: "Cellular Data Changes"))
                CustomNavigationLink(title: "Reduce Loud Sounds", status: "Allow", destination: AllowDenySelection(title: "Reduce Loud Sounds"))
                CustomNavigationLink(title: "Driving Focus", status: "Allow", destination: AllowDenySelection(title: "Driving Focus"))
                CustomNavigationLink(title: "TV Provider", status: "Allow", destination: AllowDenySelection(title: "TV Provider"))
                CustomNavigationLink(title: "Background App Activities", status: "Allow", destination: AllowDenySelection(title: "Background App Activities"))
            }, header: {
                Text("Allow Changes:")
            })
            .disabled(!contentPrivacyRestrictionsEnabled)
        }
    }
}

#Preview {
    NavigationStack {
        ContentPrivacyRestrictionsView()
    }
}
