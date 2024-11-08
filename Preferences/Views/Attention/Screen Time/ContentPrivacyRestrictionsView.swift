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
    let table = "Restrictions"
    
    var body: some View {
        CustomList(title: "ContentPrivacySpecifierName".localize(table: table)) {
            Section {
                Toggle("ContentPrivacySpecifierName".localize(table: table), isOn: $contentPrivacyRestrictionsEnabled)
            }
            
            Section {
                NavigationLink("AppsInstallationsAndPurchasesSpecifierName".localize(table: table), destination: AppInstallationsPurchasesView())
                NavigationLink("AllowedAppsSpecifierName".localize(table: table), destination: AllowedAppsView())
                NavigationLink("ContentRestrictionsSpecifierName".localize(table: table), destination: ContentRestrictionsView())
            }
            .disabled(!contentPrivacyRestrictionsEnabled)
            
            Section {
                CustomNavigationLink(title: "LocationServicesSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: RestrictionsLocationServicesView())
                CustomNavigationLink(title: "ContactsSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: ContentPrivacyRestrictionsDetailView(title: "ContactsSpecifierName"))
                CustomNavigationLink(title: "CalendarsSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: ContentPrivacyRestrictionsDetailView(title: "CalendarsSpecifierName"))
                CustomNavigationLink(title: "RemindersSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: ContentPrivacyRestrictionsDetailView(title: "RemindersSpecifierName"))
                CustomNavigationLink(title: "PhotosSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: ContentPrivacyRestrictionsDetailView(title: "PhotosSpecifierName"))
                CustomNavigationLink(title: "ShareLocationSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: SelectOptionList(title: "ShareLocationSpecifierName"))
                CustomNavigationLink(title: "BluetoothSharingSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: ContentPrivacyRestrictionsDetailView(title: "BluetoothSharingSpecifierName"))
                CustomNavigationLink(title: "MicrophoneSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: ContentPrivacyRestrictionsDetailView(title: "MicrophoneSpecifierName"))
                CustomNavigationLink(title: "SpeechRecognitionSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: ContentPrivacyRestrictionsDetailView(title: "SpeechRecognitionSpecifierName"))
                CustomNavigationLink(title: "AdvertisingSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: SelectOptionList(title: "AdvertisingSpecifierName"))
                CustomNavigationLink(title: "UserTrackingSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: ContentPrivacyRestrictionsDetailView(title: "UserTrackingSpecifierName"))
                CustomNavigationLink(title: "MediaAppleMusicSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: ContentPrivacyRestrictionsDetailView(title: "MediaAppleMusicSpecifierName"))
            } header: {
                Text("PrivacySpecifierName", tableName: table)
            }
            .disabled(!contentPrivacyRestrictionsEnabled)
            
            Section {
                CustomNavigationLink(title: "PasscodeChangesSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: SelectOptionList(title: "PasscodeChangesSpecifierName", table: table))
                CustomNavigationLink(title: "AccountChangesSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: SelectOptionList(title: "AccountChangesSpecifierName", table: table))
                CustomNavigationLink(title: "CellularChangesSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: SelectOptionList(title: "CellularChangesSpecifierName", table: table))
                CustomNavigationLink(title: "ReduceLoudSoundsSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: SelectOptionList(title: "ReduceLoudSoundsSpecifierName", table: table))
                CustomNavigationLink(title: "DrivingFocusSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: SelectOptionList(title: "DrivingFocusSpecifierName", table: table))
                CustomNavigationLink(title: "TVProviderSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: SelectOptionList(title: "TVProviderSpecifierName", table: table))
                CustomNavigationLink(title: "BackgroundAppActivitiesSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: SelectOptionList(title: "BackgroundAppActivitiesSpecifierName", table: table))
            } header: {
                Text("AllowChangesLabel", tableName: table)
            }
            .disabled(!contentPrivacyRestrictionsEnabled)
        }
    }
}

#Preview {
    NavigationStack {
        ContentPrivacyRestrictionsView()
    }
}
