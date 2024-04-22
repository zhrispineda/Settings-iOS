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
                CustomNavigationLink(title: "Contacts", status: "Allow", destination: ContentPrivacyRestrictionsDetailView(title: "Contacts"))
                CustomNavigationLink(title: "Calendars", status: "Allow", destination: ContentPrivacyRestrictionsDetailView(title: "Calendars"))
                CustomNavigationLink(title: "Reminders", status: "Allow", destination: ContentPrivacyRestrictionsDetailView(title: "Reminders"))
                CustomNavigationLink(title: "Photos", status: "Allow", destination: ContentPrivacyRestrictionsDetailView(title: "Photos"))
                CustomNavigationLink(title: "Share My Location", status: "Allow", destination: SelectOptionList(title: "Share My Location"))
                CustomNavigationLink(title: "Bluetooth Sharing", status: "Allow", destination: ContentPrivacyRestrictionsDetailView(title: "Bluetooth Sharing"))
                CustomNavigationLink(title: "Microphone", status: "Allow", destination: ContentPrivacyRestrictionsDetailView(title: "Microphone"))
                CustomNavigationLink(title: "Speech Recognition", status: "Allow", destination: ContentPrivacyRestrictionsDetailView(title: "Speech Recognition"))
                CustomNavigationLink(title: "Apple Advertising", status: "Allow", destination: SelectOptionList(title: "Apple Advertising"))
                CustomNavigationLink(title: "Allow Apps to Request to Track", status: "Allow", destination: ContentPrivacyRestrictionsDetailView(title: "Allow Apps to Request to Track"))
                CustomNavigationLink(title: "Media & Apple Music", status: "Allow", destination: ContentPrivacyRestrictionsDetailView(title: "Media & Apple Music"))
            }, header: {
                Text("Privacy")
            })
            .disabled(!contentPrivacyRestrictionsEnabled)
            
            Section(content: {
                CustomNavigationLink(title: "Passcode Changes", status: "Allow", destination: SelectOptionList(title: "Passcode Changes"))
                CustomNavigationLink(title: "Account Changes", status: "Allow", destination: SelectOptionList(title: "Account Changes"))
                CustomNavigationLink(title: "Cellular Data Changes", status: "Allow", destination: SelectOptionList(title: "Cellular Data Changes"))
                CustomNavigationLink(title: "Reduce Loud Sounds", status: "Allow", destination: SelectOptionList(title: "Reduce Loud Sounds"))
                CustomNavigationLink(title: "Driving Focus", status: "Allow", destination: SelectOptionList(title: "Driving Focus"))
                CustomNavigationLink(title: "TV Provider", status: "Allow", destination: SelectOptionList(title: "TV Provider"))
                CustomNavigationLink(title: "Background App Activities", status: "Allow", destination: SelectOptionList(title: "Background App Activities"))
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
